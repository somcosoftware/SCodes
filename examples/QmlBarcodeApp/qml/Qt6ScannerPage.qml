import QtQuick
import QtQuick.Layouts
import QtMultimedia

import com.somcosoftware.scodes 1.0

Item {
    id: root

    property bool enableCamera: false

    onEnableCameraChanged: {
        barcodeScanner.camera.active = enableCamera
    }

    SBarcodeScanner {
        id: barcodeScanner

        forwardVideoSink: videoOutput.videoSink

        captureRect: Qt.rect(0.25, 0.25, 0.5, 0.5)

        onCapturedChanged: function (captured) {
            scanning = false
            capturedText.text = captured
            resultScreen.visible = true
        }
    }

    VideoOutput {
        id: videoOutput

        anchors.fill: parent

        width: root.width

        focus: visible
        fillMode: VideoOutput.PreserveAspectCrop
    }

    ScannerOverlay {
        id: scannerOverlay

        anchors.fill: parent
        captureRect: barcodeScanner.captureRect
    }

    Rectangle {
        id: resultScreen
        anchors.centerIn: parent

        visible: false

        x: barcodeScanner.captureRect.x * parent.width
        y: barcodeScanner.captureRect.y * parent.height
        width: barcodeScanner.captureRect.width * parent.width
        height: Math.max(barcodeScanner.captureRect.height * parent.height,
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
