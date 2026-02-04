// Subtrack.qml
import QtQuick 2.12

ShaderEffect {
    id: root

    anchors.fill: parent

    // Properties
    property color baseColor: "#535353"
    property real outerOpacity: 0.71
    property rect captureRect: Qt.rect(0, 0, 0, 0)

    // Shader uniforms - pass both captureRect and size
    property color uColor: baseColor
    property real uOpacity: outerOpacity
    property vector4d uCaptureRect: Qt.vector4d(captureRect.x, captureRect.y,
                                                captureRect.width,
                                                captureRect.height)
    property vector2d uSize: Qt.vector2d(width, height)

    // Update when size changes
    onWidthChanged: update()
    onHeightChanged: update()

    vertexShader: "qrc:/shaders/subtrack.vert"
    fragmentShader: "qrc:/shaders/subtrack.frag"
}
