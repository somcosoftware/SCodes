import QtQuick 2.15
import QtQuick.Controls 2.15

TabButton {
    id: root
    implicitHeight: 59
    background: Item {
        anchors.fill: parent
        Rectangle {
            anchors {
                left: parent.left
                leftMargin: 36
                right: parent.right
                rightMargin: 36
                bottom: parent.bottom
            }
            implicitHeight: 4
            visible: root.checked
            color: Theme.tabbar.activeBorderColor
        }
    }

    contentItem: Text {
        text: root.text
        font.bold: root.checked
        font.family: Theme.fontFamily
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color: Theme.black
    }
}
