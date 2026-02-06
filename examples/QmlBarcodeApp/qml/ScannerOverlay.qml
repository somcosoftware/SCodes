import QtQuick 2.12

Item {
    id: root

    property rect captureRect

    Subtrack {
        anchors.fill: parent
        captureRect: root.captureRect
    }

    Text {
        id: scanCapsuleText

        anchors {
            top: parent.top
            topMargin: 19
            left: parent.left
            leftMargin: 32
            right: parent.right
            rightMargin: 32
        }
        text: qsTr("Place the QR code to be scanned inside the frame")
        font.family: Theme.fontFamily
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
        color: Theme.white
        wrapMode: Text.WordWrap
    }
}
