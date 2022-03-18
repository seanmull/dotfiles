"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.WolfOutputController = exports.wolfOutputFactory = void 0;
function wolfOutputFactory(channel) {
    return new WolfOutputController(channel);
}
exports.wolfOutputFactory = wolfOutputFactory;
class WolfOutputController {
    constructor(_channel) {
        this._channel = _channel;
    }
    log(text) {
        this._channel.append(text);
    }
    clear() {
        this._channel.clear();
    }
}
exports.WolfOutputController = WolfOutputController;
//# sourceMappingURL=output.js.map