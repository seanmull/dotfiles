"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.makeTempFile = exports.registerCommand = exports.getActiveEditor = exports.formatWolfResponseElement = void 0;
const path = require("path");
const vscode = require("vscode");
const tmp = require("tmp");
function formatWolfResponseElement(element) {
    if (element.value || element.error) {
        if (Array.isArray(element.value)) {
            return "[" + element.value.join(", ") + "]";
        }
        switch (typeof element.value) {
            case "string":
            case "number":
                return element.value;
            case "object":
                return JSON.stringify(element.value);
            default:
                return `${element.value}`;
        }
    }
    return '';
}
exports.formatWolfResponseElement = formatWolfResponseElement;
function getActiveEditor() {
    const activeEditor = vscode.window.activeTextEditor;
    if (activeEditor == null)
        throw new Error('No active TextEditor');
    return activeEditor;
}
exports.getActiveEditor = getActiveEditor;
function registerCommand(cmdName, callBack) {
    return vscode.commands.registerCommand(cmdName, callBack);
}
exports.registerCommand = registerCommand;
function makeTempFile(filename) {
    return tmp.fileSync({
        dir: path.dirname(filename),
        prefix: "/.wolf",
        postfix: ".py"
    });
}
exports.makeTempFile = makeTempFile;
//# sourceMappingURL=helpers.js.map