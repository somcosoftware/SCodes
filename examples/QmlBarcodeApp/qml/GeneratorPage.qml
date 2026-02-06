import QtQuick 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12
import QtQuick.Layouts 1.12

import com.somcosoftware.scodes 1.0

Item {
    SBarcodeGenerator {
        id: barcodeGenerator

        onForegroundColorChanged: {
            barcodeGenerator.generate(textField.text)
        }

        onBackgroundColorChanged: {
            barcodeGenerator.generate(textField.text)
        }

        onGenerationFinished: function (error) {
            resultStack.currentIndex = 1
            if (error === "") {
                console.log(barcodeGenerator.filePath)
                resultImage.source = "file:///" + barcodeGenerator.filePath
            } else {
                errorLabel.text = error
            }
        }
    }

    StackLayout {
        id: resultStack
        anchors {
            fill: parent
            margins: 16
        }

        Item {
            ColumnLayout {
                anchors.fill: parent
                spacing: 32

                ColumnLayout {
                    Layout.fillWidth: true

                    spacing: 8
                    Text {
                        Layout.fillWidth: true
                        text: qsTr("Select format to generate")
                        color: Theme.textColor
                        font {
                            pixelSize: 14
                            family: Theme.fontFamily
                            bold: true
                        }
                    }

                    CComboBox {
                        id: formatDropDown
                        Layout.fillWidth: true
                        textRole: "text"

                        model: ListModel {
                            ListElement {
                                text: "Aztec"
                            }
                            ListElement {
                                text: "Codabar"
                            }
                            ListElement {
                                text: "Code39"
                            }
                            ListElement {
                                text: "Code93"
                            }
                            ListElement {
                                text: "Code128"
                            }
                            ListElement {
                                text: "DataMatrix"
                            }
                            ListElement {
                                text: "EAN-8"
                            }
                            ListElement {
                                text: "EAN-13"
                            }
                            ListElement {
                                text: "ITF"
                            }
                            ListElement {
                                text: "PDF417"
                            }
                            ListElement {
                                text: "QRCode"
                            }
                            ListElement {
                                text: "UPC-A"
                            }
                            ListElement {
                                text: "UPC-E"
                            }
                        }

                        onCurrentTextChanged: function () {
                            barcodeGenerator.setFormat(currentText)
                        }
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 8
                    Text {
                        Layout.fillWidth: true
                        text: qsTr("Enter text")
                        color: Theme.textColor
                        font {
                            pixelSize: 14
                            family: Theme.fontFamily
                            bold: true
                        }
                    }

                    CTextField {
                        id: textField
                        Layout.fillWidth: true
                        placeholderText: qsTr("Input")
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Image {
                        anchors {
                            fill: parent
                            margins: 16
                        }
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/icons/obraz.png"
                    }
                }

                CButton {
                    Layout.fillWidth: true
                    text: qsTr("Generate")
                    backgroundColor: Theme.teal
                    textColor: Theme.white
                    enabled: textField.text !== ""
                    onClicked: {
                        barcodeGenerator.generate(textField.text)
                    }
                }
            }
        }

        Item {
            ColumnLayout {
                anchors.fill: parent
                spacing: 32

                Text {
                    id: generateLabel
                    Layout.fillWidth: true
                    text: qsTr("Your code has been generated!")
                    font.family: Theme.fontFamily
                    font.pixelSize: 16
                    visible: !errorLabel.visible
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    id: errorLabel
                    Layout.fillWidth: true
                    Layout.topMargin: 40
                    color: Theme.red
                    visible: text !== ""
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                }

                Item {
                    Layout.fillHeight: true
                }

                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.leftMargin: 50
                    Layout.rightMargin: 50
                    Layout.preferredHeight: width
                    Image {
                        id: resultImage
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Item {
                    Layout.fillHeight: true
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    CButton {
                        Layout.fillWidth: true
                        text: qsTr("Clear")
                        backgroundColor: Theme.white
                        textColor: Theme.red
                        icon.source: "qrc:/icons/close.svg"
                        onClicked: {
                            errorLabel.text = ""
                            resultImage.source = ""
                            resultStack.currentIndex = 0
                        }
                    }

                    CButton {
                        Layout.fillWidth: true
                        enabled: !errorLabel.visible
                        text: qsTr("Download")
                        backgroundColor: Theme.teal
                        textColor: Theme.white
                        icon.source: "qrc:/icons/download.svg"
                        onClicked: {
                            if (barcodeGenerator.saveImage()) {
                                messagePopup.showMessage(
                                            qsTr("File successfully saved"))
                            } else {
                                messagePopup.showMessage(
                                            qsTr("There was an error while saving file"))
                            }
                        }
                    }
                }
            }
        }
    }

    Popup {
        id: messagePopup
        anchors.centerIn: parent

        function showMessage(message) {
            messagePopupLabel.text = message
            messagePopup.open()
        }

        dim: true
        modal: true

        implicitWidth: messagePopupLabel.paintedWidth + 40
        implicitHeight: messagePopupLabel.paintedHeight + 80

        background: Rectangle {
            color: Theme.white
            radius: 20
        }

        Label {
            id: messagePopupLabel
            anchors.centerIn: parent
        }
    }
}
