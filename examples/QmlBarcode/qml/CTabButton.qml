import QtQuick 2.15
import QtQuick.Controls 2.15

TabButton {
    id: root
    background: Item {
        anchors.fill: parent
        Rectangle {
            visible: root.checked
            anchors {
                left: parent.left
                leftMargin: 36
                right: parent.right
                rightMargin: 36
                bottom: parent.bottom
            }
            implicitHeight: 4
            color: Theme.teal
        }
    }

    contentItem: Text {
        text: root.text
        font.weight: root.checked ? 700 : 600
        font.bold: root.checked
        font.family: "Inter"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color: Theme.black
    }
}
