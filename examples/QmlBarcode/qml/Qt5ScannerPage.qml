import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtMultimedia 5.12

import com.somcosoftware.scodes 1.0

Rectangle {
    id: root

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

        property rect normalizedScanZone: Qt.rect(0.25, 0.25, 0.5, 0.5)

        captureRect: {
            if (videoOutput.sourceRect.width < 1
                    || videoOutput.contentRect.width < 1)
                return Qt.rect(0, 0, 0, 0)

            return videoOutput.mapRectToSource(
                        videoOutput.mapNormalizedRectToItem(normalizedScanZone))
        }
    }

    Rectangle {
        id: resultScreen

        anchors.fill: parent

        visible: !barcodeScanner.active

        Column {
            anchors.centerIn: parent
            spacing: 20

            Text {
                id: scanResultText

                anchors.horizontalCenter: parent.horizontalCenter

                text: barcodeScanner.captured
            }

            Button {
                id: scanButton

                anchors.horizontalCenter: parent.horizontalCenter

                text: qsTr("Scan again")

                onClicked: {
                    barcodeScanner.active = true
                }
            }
        }
    }
}
