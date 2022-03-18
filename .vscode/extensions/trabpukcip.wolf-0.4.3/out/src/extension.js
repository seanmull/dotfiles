"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.activate = void 0;
const vscode = require("vscode");
const api_1 = require("./api");
const helpers_1 = require("./helpers");
const utils_1 = require("./utils");
function activate(context) {
    const output = vscode.window.createOutputChannel("Wolf");
    const wolfAPI = api_1.wolfStandardApiFactory(context, { output });
    let updateTimeout = null;
    initializeWolfExtension();
    return wolfAPI;
    function initializeWolfExtension() {
        context.subscriptions.push(helpers_1.registerCommand("wolf.touchBarStart", startWolf), helpers_1.registerCommand("wolf.touchBarStop", stopWolf), helpers_1.registerCommand("wolf.barkAtCurrentFile", startWolf), helpers_1.registerCommand("wolf.stopBarking", stopWolf));
        const sharedOptions = [null, context.subscriptions];
        vscode.window.onDidChangeActiveTextEditor(changedActiveTextEditor, ...sharedOptions);
        vscode.workspace.onDidChangeTextDocument(changedTextDocument, ...sharedOptions);
        vscode.workspace.onDidChangeConfiguration(changedConfiguration, ...sharedOptions);
    }
    function startWolf() {
        if (wolfAPI.shouldShowHotModeWarning) {
            wolfAPI.displayHotModeWarning();
        }
        wolfAPI.stepInWolf();
        if (wolfAPI.activeEditorIsDirty)
            forceRefreshActiveDocument(wolfAPI);
    }
    function stopWolf() {
        wolfAPI.stopWolf();
        clearThrottleUpdateBuffer();
    }
    function changedActiveTextEditor(editor) {
        if (editor) {
            if (wolfAPI.sessions.sessionIsActiveByDocument(editor.document)) {
                if (wolfAPI.configChanged) {
                    vscode.window.showInformationMessage("Wolf detected a change to the Hot Mode configuration and was shut off.. " +
                        "Attempting to restart.");
                    wolfAPI.setConfigUpdatedFlag(false);
                    stopWolf();
                    wolfAPI.stepInWolf();
                }
                else {
                    wolfAPI.enterWolfContext();
                    forceRefreshActiveDocument(wolfAPI);
                }
            }
            else {
                wolfAPI.exitWolfContext();
            }
        }
    }
    function changedTextDocument(event) {
        if (wolfAPI.isDocumentWolfSession(event.document)) {
            throttledHandleDidChangeTextDocument(event);
        }
    }
    function changedConfiguration(event) {
        if (event.affectsConfiguration("wolf.pawPrintsInGutter") ||
            event.affectsConfiguration("wolf.updateFrequency") ||
            event.affectsConfiguration("wolf.maxLineLength")) {
            wolfAPI.setConfigUpdatedFlag(true);
        }
    }
    function throttledHandleDidChangeTextDocument(event) {
        var _a;
        clearThrottleUpdateBuffer();
        updateTimeout = setTimeout(() => wolfAPI.traceAndSetDecorationsUsingTempFile(event.document), utils_1.clamp(100, 10000, (_a = wolfAPI.updateFrequency) !== null && _a !== void 0 ? _a : Infinity));
    }
    function forceRefreshActiveDocument(wolfAPI) {
        throttledHandleDidChangeTextDocument({
            document: wolfAPI.activeEditor.document
        });
    }
    function clearThrottleUpdateBuffer() {
        if (updateTimeout)
            clearTimeout(updateTimeout);
    }
}
exports.activate = activate;
//# sourceMappingURL=extension.js.map