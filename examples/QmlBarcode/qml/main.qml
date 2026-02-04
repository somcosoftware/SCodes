import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import com.somcosoftware.scodes 1.0

ApplicationWindow {
    id: appWindow

    visible: true

    width: Qt.platform.os === "android"
           || Qt.platform.os === "ios" ? Screen.width : 1280
    height: Qt.platform.os === "android"
            || Qt.platform.os === "ios" ? Screen.height : 720

    background: Rectangle {
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: Theme.background.color1
            }
            GradientStop {
                position: 1.0
                color: Theme.background.color2
            }
        }
    }

    MouseArea {
        id: hideKeyboard
        anchors.fill: parent
        onClicked: {
            Qt.inputMethod.hide()
        }
    }

    ColumnLayout {
        anchors.fill: parent

        Image {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 28
            Layout.topMargin: 16
            Layout.bottomMargin: 16
            fillMode: Image.PreserveAspectFit
            source: "qrc:/icons/logo.png"
        }

        TabBar {
            id: tabBar
            Layout.fillWidth: true

            background: Item {
                anchors.fill: parent
                Rectangle {
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }
                    implicitHeight: 1
                    color: "#A3C8BF"
                }
            }

            CTabButton {
                text: qsTr("Scan")
            }

            CTabButton {
                text: qsTr("Generate")
            }
        }

        StackLayout {
            currentIndex: tabBar.currentIndex
            Layout.fillWidth: true
            Layout.fillHeight: true

            Loader {
                source: VersionHelper.isQt6 ? "Qt6ScannerPage.qml" : "Qt5ScannerPage.qml"
            }

            Loader {
                source: "GeneratorPage.qml"
            }
        }
    }
}
