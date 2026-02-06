import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

import com.somcosoftware.scodes 1.0


/*!
  Barcode scanner main page. All QML elements managing from here.
  */
Item {
    id: root

    property bool enableCamera: false

    SBarcodeScanner {
        id: barcodeScanner

        forwardVideoSink: videoOutput.videoSink
        scanning: !resultScreen.visible

        captureRect: Qt.rect(1 / 4, 1 / 4, 1 / 2, 1 / 2)

        onCapturedChanged: function (captured) {
            scanResultText.text = captured
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

    Qt6ScannerOverlay {
        id: scannerOverlay

        anchors.fill: parent

        captureRect: barcodeScanner.captureRect
    }

    Rectangle {
        id: resultScreen
        anchors.centerIn: parent

        visible: !barcodeScanner.active

        x: scannerOverlay.captureRect.x
        y: scannerOverlay.captureRect.y
        width: scannerOverlay.captureRect.width
        height: Math.max(scannerOverlay.captureRect.width,
                         popupLayout.implicitHeight + 64)

        ColumnLayout {
            id: popupLayout
            anchors {
                fill: parent
                margins: 32
            }
            spacing: 20

            Text {
                Layout.fillWidth: true
                Layout.fillHeight: true
                wrapMode: Text.WordWrap
                font {
                    family: Theme.fontFamily
                    pixelSize: 14
                }

                text: barcodeScanner.captured
            }

            CButton {
                Layout.fillWidth: true
                text: qsTr("Scan again")
                backgroundColor: Theme.teal
                textColor: Theme.white

                onClicked: {
                    barcodeScanner.active = true
                }
            }
        }
    }
}
