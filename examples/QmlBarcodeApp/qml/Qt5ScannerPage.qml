import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtMultimedia 5.12

import com.somcosoftware.scodes 1.0

Item {
    id: root

    property bool enableCamera: false

    onEnableCameraChanged: {
        if (enableCamera)
            camera.start()
        else
            camera.stop()
    }

    Camera {
        id: camera

        focus {
            focusMode: CameraFocus.FocusAuto
            focusPointMode: CameraFocus.FocusPointAuto
        }
    }

    VideoOutput {
        id: videoOutput

        anchors.fill: parent
        source: camera
        autoOrientation: true
        fillMode: VideoOutput.PreserveAspectCrop
        filters: [barcodeScanner]

        ScannerOverlay {
            id: scannerOverlay
            anchors.fill: parent

            captureRect: barcodeScanner.captureRect
        }

        // used to get camera focus on touched point
        MouseArea {
            id: focusTouchArea
            anchors.fill: parent
            enabled: camera.focus.isFocusPointModeSupported(Camera.FocusMacro)

            onClicked: {
                camera.focus.customFocusPoint = Qt.point(mouse.x / width,
                                                         mouse.y / height)
                camera.focus.focusMode = CameraFocus.FocusMacro
                camera.focus.focusPointMode = CameraFocus.FocusPointCustom
            }
        }
    }

    SBarcodeScanner {
        id: barcodeScanner

        captureRect: Qt.rect(0.25, 0.25, 0.5, 0.5)

        onCapturedChanged: captured => {
                               active = false
                               console.log("captured: " + captured)
                           }
    }

    Rectangle {
        id: resultScreen
        anchors.centerIn: parent

        visible: !barcodeScanner.active

        x: barcodeScanner.captureRect.x * parent.width
        y: barcodeScanner.captureRect.y * parent.height
        width: barcodeScanner.captureRect.width * parent.width
        height: Math.max(barcodeScanner.captureRect.height * parent.height,
                         popupLayout.implicitHeight + 64)

        color: Theme.white

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
