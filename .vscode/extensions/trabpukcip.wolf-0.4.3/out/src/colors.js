"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.wolfTextColorProvider = exports.wolfIconColorProvider = void 0;
const WolfIconColorMap = {
    blue: "blue",
    cornflower: "blue",
    red: "red",
    green: "green"
};
const WolfHexColorMap = {
    cornflower: "#6495ed",
    blue: "#00a1f1",
    green: "#7cbb00",
    red: "#ea2f36"
};
function wolfIconColorProvider(color) {
    return WolfIconColorMap[color];
}
exports.wolfIconColorProvider = wolfIconColorProvider;
function wolfTextColorProvider(color) {
    return WolfHexColorMap[color];
}
exports.wolfTextColorProvider = wolfTextColorProvider;
//# sourceMappingURL=colors.js.map