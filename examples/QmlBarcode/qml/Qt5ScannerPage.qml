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

        onSourceRectChanged: {
            barcodeScanner.captureRect = videoOutput.mapRectToSource(
                        videoOutput.mapNormalizedRectToItem(Qt.rect(0.25, 0.25,
                                                                    0.5, 0.5)))
        }

        Qt5ScannerOverlay {
            id: scannerOverlay
            anchors.fill: parent

            captureRect: videoOutput.mapRectToItem(barcodeScanner.captureRect)
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

        captureRect: videoOutput.mapRectToSource(
                         videoOutput.mapNormalizedRectToItem(Qt.rect(0.25,
                                                                     0.25, 0.5,
                                                                     0.5)))

        onCapturedChanged: {
            active = false
            console.log("captured: " + captured)
        }
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
