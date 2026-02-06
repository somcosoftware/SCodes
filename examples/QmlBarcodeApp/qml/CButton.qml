import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Button {
    id: root

    required property color backgroundColor
    required property color textColor

    implicitHeight: 54
    icon.source: ""

    background: Rectangle {
        radius: 72
        color: Theme.getButtonBackground(root.backgroundColor, root.enabled,
                                         root.down)
    }

    font {
        family: Theme.fontFamily
        pixelSize: 16
        bold: true
    }

    contentItem: Item {
        anchors.fill: parent
        RowLayout {
            anchors.centerIn: parent
            spacing: 16

            implicitWidth: (img.visible ? 24 + 16 : 0) + txt.paintedWidth
            Text {
                id: txt
                Layout.preferredWidth: paintedWidth
                text: root.text
                color: root.textColor
                horizontalAlignment: Text.AlignHCenter
                font {
                    pixelSize: 16
                    family: Theme.fontFamily
                    bold: true
                }
            }

            Image {
                id: img
                visible: status == Image.Ready
                Layout.preferredHeight: 24
                Layout.preferredWidth: 24
                fillMode: Image.PreserveAspectFit
                source: root.icon.source
            }
        }
    }
}
