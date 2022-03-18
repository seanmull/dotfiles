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
exports.PythonTracer = exports.pythonTracerFactory = void 0;
const path = require("path");
const child_process_1 = require("child_process");
const utils_1 = require("./utils");
function pythonTracerFactory() {
    return new PythonTracer();
}
exports.pythonTracerFactory = pythonTracerFactory;
class PythonTracer {
    constructor() {
        this.tracePythonScript = (options) => __awaiter(this, void 0, void 0, function* () {
            return new Promise((resolve, reject) => {
                const { fileName, pythonPath, rootDir } = options;
                if (this.tracerTimeout !== null) {
                    clearTimeout(this.tracerTimeout);
                }
                const python = this.getPythonRunner(pythonPath, rootDir, fileName);
                this.tracerTimeout = setTimeout(function () { python.kill(); }, 10 * 1000);
                python.stderr.on("data", (data) => {
                    reject(data.toString());
                });
                python.stdout.on("data", (data) => {
                    resolve(this.tryParsePythonData(data));
                });
            });
        });
        this.tracerTimeout = null;
        this.tryParsePythonData = (buffer) => {
            const asString = buffer.toString();
            const index = utils_1.indexOrLast(asString, "WOOF:");
            if (index !== -1) {
                try {
                    return [
                        JSON.parse(asString.slice(index)),
                        asString.slice(0, index - "WOOF:".length),
                    ];
                }
                catch (err) {
                    console.error("Error parsing Wolf output. ->");
                    console.error(asString);
                    console.error(err);
                }
            }
            return [undefined, asString];
        };
    }
    getPythonMajorVersion(pythonPath) {
        const child = child_process_1.spawn(pythonPath, ['--version']);
        return new Promise((resolve, reject) => {
            child.stderr.on('data', err => {
                reject(err);
            });
            child.stdout.on('data', (data) => {
                resolve(data.toString().split(' ')[1].split('.')[0]);
            });
        });
    }
    getPythonRunner(pythonPath, rootDir, scriptName) {
        const wolfPath = path.join(rootDir, "scripts/wolf.py");
        const options = { env: Object.assign({}, process.env) };
        /* Copied from https://github.com/Almenon/AREPL-backend/blob/209eb5b8ae8cda1677f925749a10cd263f6d9860/index.ts#L85-L93 */
        if (process.platform == "darwin") {
            // needed for Mac to prevent ENOENT
            options.env.PATH = ["/usr/local/bin", process.env.PATH].join(":");
        }
        else if (process.platform == "win32") {
            // needed for windows for encoding to match what it would be in terminal
            // https://docs.python.org/3/library/sys.html#sys.stdin
            options.env.PYTHONIOENCODING = 'utf8';
        }
        return child_process_1.spawn(pythonPath, [wolfPath, scriptName], options);
    }
}
exports.PythonTracer = PythonTracer;
//# sourceMappingURL=tracer.js.map