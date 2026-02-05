pragma Singleton

import QtQuick 2.12

QtObject {
    id: root

    readonly property string fontFamily: "Inter"

    readonly property color black: "#000000"
    readonly property color white: "#FFFFFF"
    readonly property color transparent: "transparent"
    readonly property color teal: "#1DCA9B"
    readonly property color shadowGreen: "#A3C8BF"
    readonly property color red: "#E64646"

    readonly property QtObject tabbar: QtObject {
        readonly property color inactiveBorderColor: root.shadowGreen
        readonly property color activeBorderColor: root.teal
    }

    readonly property QtObject subtrack: QtObject {
        readonly property color backgroundColor: "#535353"
        readonly property real opacity: 0.71
    }

    readonly property QtObject background: QtObject {
        readonly property color color1: root.white
        readonly property color color2: "#E8E8E8"
    }

    readonly property QtObject textField: QtObject {
        readonly property color borderColor: "#D9D9D9"
        readonly property color placeholderTextColor: "#B8B8B8"
        readonly property color textColor: root.black
    }

    readonly property color textColor: "#676767"

    function getButtonBackground(baseColor, enabled, pressed) {
        if (!enabled) {
            if (baseColor === root.white)
                return "#E6E6E6" // disabled white
            if (baseColor === root.teal)
                return "#8FD9C7" // disabled teal
        }

        if (pressed) {
            if (baseColor === root.white)
                return "#F2F2F2" // pressed white
            if (baseColor === root.teal)
                return "#17A884" // pressed teal
        }

        return baseColor
    }
}
