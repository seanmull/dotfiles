"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.WolfAPI = exports.wolfStandardApiFactory = void 0;
const fs = require("fs");
const decorations_1 = require("./decorations");
const vscode_1 = require("vscode");
const sessions_1 = require("./sessions");
const tracer_1 = require("./tracer");
const helpers_1 = require("./helpers");
const hotWarning_1 = require("./hotWarning");
const output_1 = require("./output");
const events_1 = require("events");
const os_1 = require("os");
const errors_1 = require("./errors");
function wolfStandardApiFactory(context, options) {
    return new WolfAPI(context, output_1.wolfOutputFactory(options.output), decorations_1.wolfDecorationStoreFactory(context), sessions_1.wolfSessionStoreFactory(), tracer_1.pythonTracerFactory());
}
exports.wolfStandardApiFactory = wolfStandardApiFactory;
class WolfAPI {
    constructor(context, _outputController, _decorationController, _sessionController, _pythonTracer) {
        this.context = context;
        this._outputController = _outputController;
        this._decorationController = _decorationController;
        this._sessionController = _sessionController;
        this._pythonTracer = _pythonTracer;
        this._changedConfigFlag = false;
        this._endOfFile = 0;
        this._eventEmitter = new events_1.EventEmitter();
        this.stepInWolf = () => {
            this.decorations.setDefaultDecorationOptions("green", "red");
            this.sessions.createSessionFromEditor(this.activeEditor);
            this.updateLineCount(this.activeEditor.document.lineCount);
            this.traceAndSetDecorations(this.activeEditor.document.fileName);
            this.enterWolfContext();
        };
        this.stopWolf = () => {
            this.clearAllSessionsAndDecorations();
            this.exitWolfContext();
        };
        this.traceAndSetDecorationsUsingTempFile = (document) => {
            const tempFileObj = helpers_1.makeTempFile(document.fileName);
            fs.writeFileSync(tempFileObj.name, document.getText());
            this.traceAndSetDecorations(tempFileObj.name)
                .finally(tempFileObj.removeCallback);
        };
        this.enterWolfContext = () => {
            vscode_1.commands.executeCommand("setContext", "inWolfContext", true);
        };
        this.exitWolfContext = () => {
            vscode_1.commands.executeCommand("setContext", "inWolfContext", false);
        };
        this.clearDecorations = (session) => {
            const emptyDecorations = this.decorations.getEmptyDecorations();
            this.setDecorations(session, emptyDecorations);
        };
        this.clearAllDecorations = () => {
            this.decorations.reInitDecorationCollection();
            for (const name of this.sessions.sessionNames) {
                const session = this.sessions.getSessionByFileName(name);
                this.clearDecorations(session);
            }
        };
        this.clearAllSessionsAndDecorations = () => {
            this.clearAllDecorations();
            this.sessions.clearAllSessions();
        };
        this.isDocumentWolfSession = (document) => {
            return this.sessions.sessionIsActiveByDocument(document);
        };
        this.onPythonDataError = (data) => {
            if (this.shouldLogErrors) {
                this.logToOutput("(Wolf Error):", data !== null && data !== void 0 ? data : '<no message>');
            }
        };
        this.onPythonDataSuccess = ([data, stdout]) => {
            this.parsePythonDataAndSetDecorations(this.activeEditor, data);
            if (this.printLogging) {
                const output = this.prettyPrintWolfData(data);
                this._outputController.clear();
                this.logToOutput(stdout ? stdout + '\n\n' : '');
                this.logToOutput(`(Wolf Output): ${JSON.stringify(output, null, 4)}`);
                this.logToOutput(`\n\nTotal Line Count: ${data === null || data === void 0 ? void 0 : data.length}`);
            }
            const filepath = this.activeEditor.document.uri.path;
            this.emit('decorations-changed', filepath, this.decorations);
        };
        this.parsePythonDataAndSetDecorations = (session, data = []) => {
            this.decorations.reInitDecorationCollection();
            this.decorations.prepareParsedPythonData(data);
            this.clearDecorations(session);
            this.setPreparedDecorations(session);
        };
        this.setPreparedDecorations = (session) => {
            this.decorations.setPreparedDecorationsForEditor(session);
            const decorations = this.decorations.getPreparedDecorations();
            this.setDecorations(session, decorations);
        };
        this.setDecorations = (session, decorations) => {
            const decorationTypes = this.decorations.getDecorationTypes();
            if (decorationTypes) {
                session.setDecorations(decorationTypes.success, decorations.success);
                session.setDecorations(decorationTypes.error, decorations.error);
            }
        };
        this.traceAndSetDecorations = (fileName) => {
            return this.tracer.tracePythonScript({
                fileName,
                pythonPath: this.pythonPath,
                rootDir: this.rootExtensionDir,
            })
                .then(this.onPythonDataSuccess)
                .catch(this.onPythonDataError);
        };
        this.updateLineCount = (count) => {
            this.oldLineCount = count;
        };
        this.updateStickysHot = (event) => {
            if (this.isHot) {
                this.setPreparedDecorations(this.activeEditor);
                this.updateLineCount(event.document.lineCount);
            }
            this.activeEditor.document.save();
        };
        this.logToOutput = (...text) => {
            this._outputController.log(text.join(" "));
        };
        this.emit = (event, filepath, ...args) => {
            this._eventEmitter.emit(event, filepath, ...args);
        };
        this.on = (event, listener) => {
            this._eventEmitter.addListener(event, listener);
        };
        this.__platform = os_1.platform().trim();
        this.getPythonMajorVersion = () => __awaiter(this, void 0, void 0, function* () {
            return yield this.tracer.getPythonMajorVersion(this.pythonPath);
        });
    }
    prettyPrintWolfData(data) {
        var _a;
        return (_a = data === null || data === void 0 ? void 0 : data.map(l => `LINENO: ${l.lineno} - VALUE: ${l.value}${l.error ? `, ERROR: ${l.error}` : ""}`)) !== null && _a !== void 0 ? _a : [];
    }
    setConfigUpdatedFlag(v) {
        this._changedConfigFlag = v;
    }
    displayHotModeWarning() {
        hotWarning_1.hotModeWarning();
    }
    get activeEditor() {
        return helpers_1.getActiveEditor();
    }
    get activeEditorIsDirty() {
        return this.activeEditor.document.isDirty;
    }
    get config() {
        return vscode_1.workspace.getConfiguration("wolf");
    }
    get configChanged() {
        return this._changedConfigFlag;
    }
    get decorations() {
        return this._decorationController;
    }
    get isHot() {
        return this.config.get("hot");
    }
    get updateFrequency() {
        return this.config.get("updateFrequency");
    }
    get oldLineCount() {
        return this._endOfFile;
    }
    set oldLineCount(v) {
        this._endOfFile = v;
    }
    get printLogging() {
        return this.config.get("printLoggingEnabled");
    }
    get rootExtensionDir() {
        var _a;
        const res = (_a = vscode_1.extensions.getExtension("traBpUkciP.wolf")) === null || _a === void 0 ? void 0 : _a.extensionPath;
        if (res === undefined)
            throw new errors_1.WolfError('no WolfAPI.rootExtensionDir)');
        return res;
    }
    get sessions() {
        return this._sessionController;
    }
    get shouldLogErrors() {
        return this.config.get("logErrors") === true;
    }
    get shouldShowHotModeWarning() {
        return this.config.get("disableHotModeWarning") !== true;
    }
    get tracer() {
        return this._pythonTracer;
    }
    get pythonPath() {
        const fromconfig = this.config.get("pythonPath");
        /* Github-Actions Windows CI tests don't like 'python3' */
        return fromconfig || this.__platform === "win32" ? 'python' : 'python3';
    }
}
exports.WolfAPI = WolfAPI;
//# sourceMappingURL=api.js.map