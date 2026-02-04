pragma Singleton

import QtQuick 2.12

QtObject {
    id: root

    readonly property color black: "#000000"
    readonly property color white: "#FFFFFF"
    readonly property color transparent: "transparent"
    readonly property color teal: "#1DCA9B"
    readonly property color red: "#E64646"

    readonly property QtObject subtrack: QtObject {
        readonly property color backgroundColor: "#535353"
        readonly property real opacity: 0.71
    }

    readonly property QtObject background: QtObject {
        readonly property color color1: root.white
        readonly property color color2: "#E8E8E8"
    }
}
