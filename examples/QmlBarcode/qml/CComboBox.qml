import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ComboBox {
    id: root
    implicitHeight: 44

    implicitWidth: leftPadding + contentItem.implicitWidth + 6 + indicator.width + rightPadding

    topPadding: 12
    bottomPadding: 12
    leftPadding: 12
    rightPadding: 16
    editable: false

    background: Rectangle {
        radius: 72
        color: Theme.white
    }

    contentItem: Text {
        anchors {
            fill: parent
            rightMargin: root.rightPadding + 6 + root.indicator.width
        }
        text: root.displayText
        color: Theme.black
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        leftPadding: 10
        font.pixelSize: 16
    }

    indicator: Item {
        x: root.width - width - root.rightPadding
        y: root.topPadding + (root.availableHeight - height) / 2
        width: 32
        height: 32

        Image {
            anchors.fill: parent

            fillMode: Image.PreserveAspectFit
            source: "qrc:/icons/arrow_drop_down.svg"
            rotation: root.down ? 180 : 0

            Behavior on rotation {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.Linear
                }
            }
        }
    }

    popup: Popup {
        id: popup
        y: root.height
        width: root.width
        implicitHeight: Math.min(contentItem.implicitHeight + 24, 272)

        contentItem: ListView {
            id: listView
            clip: true
            implicitHeight: contentHeight
            model: root.visible ? root.delegateModel : null
            currentIndex: root.highlightedIndex
            boundsBehavior: Flickable.StopAtBounds
            highlightMoveDuration: 0
            snapMode: ListView.SnapToItem
            spacing: 8

            ScrollBar.vertical: ScrollBar {
                id: scrollBar
                active: listView.contentHeight > popup.implicitHeight
            }
        }

        background: Rectangle {
            color: Theme.white
            radius: 22
        }
    }

    delegate: Rectangle {
        id: comboBoxDelegate
        required property var model
        required property int index

        property bool isCurrentItem: ListView.view.currentIndex === index

        height: 36
        width: ListView.view.width - scrollBar.width
        color: Theme.white
        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: 1
            color: Theme.shadowGreen
            opacity: 0.2
        }

        RowLayout {
            spacing: 16
            anchors {
                fill: parent
                leftMargin: root.leftPadding
                rightMargin: root.rightPadding
            }

            Text {
                Layout.fillWidth: true
                text: comboBoxDelegate.model[root.textRole]
                font.pixelSize: 16
                font.bold: comboBoxDelegate.isCurrentItem
                color: Theme.black
            }

            Image {
                Layout.preferredHeight: 32
                Layout.preferredWidth: 32
                fillMode: Image.PreserveAspectFit
                source: "qrc:/icons/check.svg"
                visible: comboBoxDelegate.isCurrentItem
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.currentIndex = index
                root.popup.close()
            }
        }
    }
}
