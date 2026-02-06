// Subtrack.qml
import QtQuick 2.15

import com.somcosoftware.scodes 1.0

Canvas {
    id: root
    anchors.fill: parent
    antialiasing: true

    property color baseColor: Theme.subtrack.backgroundColor
    property real outerOpacity: Theme.subtrack.opacity
    property rect captureRect: Qt.rect(0.25, 0.25, 0.5, 0.5)

    onPaint: {
        var ctx = getContext("2d")
        ctx.reset()

        // Background overlay
        ctx.fillStyle = Qt.rgba(root.baseColor.r, root.baseColor.g,
                                root.baseColor.b, root.outerOpacity)

        ctx.fillRect(0, 0, width, height)

        var rx = root.captureRect.x * width
        var ry = root.captureRect.y * height
        var rw = root.captureRect.width * width
        var rh = root.captureRect.height * height

        ctx.clearRect(rx, ry, rw, rh)
    }

    onWidthChanged: requestPaint()
    onHeightChanged: requestPaint()
    onCaptureRectChanged: requestPaint()
    onBaseColorChanged: requestPaint()
    onOuterOpacityChanged: requestPaint()
}
