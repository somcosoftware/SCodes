import QtQuick
import QtQuick.Layouts
import QtMultimedia
import QtCore

import com.somcosoftware.scodes 1.0

Item {
    id: root

    readonly property rect captureRect: Qt.rect(0.25, 0.25, 0.5, 0.5)

    CameraPermission {
        id: cameraPermission
    }

    Component.onCompleted: {
        if (cameraPermission.status !== Qt.PermissionStatus.Granted)
            cameraPermission.request()
    }

    Loader {
        anchors.fill: parent
        active: cameraPermission.status === Qt.PermissionStatus.Granted
        sourceComponent: Item {

            SBarcodeScanner {
                id: barcodeScanner

                forwardVideoSink: videoOutput.videoSink

                captureRect: root.captureRect

                onCapturedChanged: function (captured) {
                    scanning = false
                    capturedText.text = captured
                    resultScreen.visible = true
                }
            }

            VideoOutput {
                id: videoOutput

                anchors.fill: parent

                width: parent.width

                focus: visible
                fillMode: VideoOutput.PreserveAspectCrop
            }

            ScannerOverlay {
                anchors.fill: parent
                captureRect: root.captureRect
            }

            Rectangle {
                id: resultScreen
                anchors.centerIn: parent

                visible: false

                x: root.captureRect.x * parent.width
                y: root.captureRect.y * parent.height
                width: root.captureRect.width * parent.width
                height: Math.max(root.captureRect.height * parent.height,
                                 popupLayout.implicitHeight + 64)

                ColumnLayout {
                    id: popupLayout
                    anchors {
                        fill: parent
                        margins: 32
                    }
                    spacing: 20

                    Text {
                        id: capturedText
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        wrapMode: Text.WordWrap
                        font {
                            family: Theme.fontFamily
                            pixelSize: 14
                        }
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    CButton {
                        Layout.fillWidth: true
                        text: qsTr("Scan again")
                        backgroundColor: Theme.teal
                        textColor: Theme.white

                        onClicked: {
                            resultScreen.visible = false
                            capturedText.text = ""
                            barcodeScanner.scanning = true
                        }
                    }
                }
            }
        }
    }

    Text {
        anchors.centerIn: parent
        visible: cameraPermission.status === Qt.PermissionStatus.Denied
        text: qsTr("Camera permission is required to scan barcodes.")
        color: "black"
        wrapMode: Text.WordWrap
        width: parent.width * 0.8
        horizontalAlignment: Text.AlignHCenter
    }
}
