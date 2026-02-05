import QtQuick 2.15
import QtQuick.Controls 2.15


/*!
  Field for setting width, height, margin & error correction code level parameters.
  */
TextField {
    id: root

    background: Item {
        anchors.fill: parent

        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: 2
            color: Theme.textField.borderColor
        }
    }

    font.pixelSize: 16
    font.family: Theme.fontFamily

    placeholderTextColor: Theme.textField.placeholderTextColor
    color: Theme.textField.textColor
}
