import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3
import MediaModel 1.0
import QtQuick.Window 2.15
import "helper.js" as Helper

ApplicationWindow {
    id: root
    width: 860
    height: 600
    visible: true
    minimumHeight: 600
    minimumWidth: 800
    title: qsTr("Hello World")

    onWidthChanged: console.log(width)
//    flags: Qt.FramelessWindowHint
//    color: "transparent"
//    Rectangle {
//        x: 10
//        y: 10
//        width: parent.width-20
//        height: parent.height-20
//        radius: 15
//    }
    background: Rectangle {
//        width: parent.width-20
//        height: parent.height-20
//        radius: 15

        gradient: Gradient {
            GradientStop { position: 0; color: "#70dfe8" }
            GradientStop { position: 1; color: "#1e62a0" }
        }
    }

//    overlay.modal: Rectangle {
//        color: "#8f28282a"
//    }

//    overlay.modeless: Rectangle {
//        color: "#2f28282a"
//    }

//    Left debug rect
//    Rectangle {
//        width: 50
//        height: parent.height
//        anchors.left: parent.left
//        color: "gray"
//        border {
//            color: "black"
//            width: 1
//        }

    /*!
        \brief Left panel
    */
    LeftPanel {
        id: leftPanel
        width: 100
        height: parent.height
        anchors.left: parent.left
        topPadding: 20
    }
//    }

    MediaModel {
        id: dataModel
    }

 menuBar: AppWindowButtons { }

    /*!
        \brief Debug draw rect
    */        
    Rectangle {
        height: parent.height - 50
        width: parent.width - leftPanel.width
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        radius: 20
//        color: "#f4f4fe"
        color: "transparent"
        border {
            color: "red"
            width: 3
        }        

        ColumnLayout {
            width: parent.width
            height: parent.height
//            Layout.margins: 20
//            spacing: 10

//                Image {
//                    anchors.fill: parent
//                    fillMode: Image.PreserveAspectCrop
//                    source: "album-cover.jpg"
//                }

            TableViewQQ1 {
                id: tableView
                Layout.fillWidth: true
                Layout.fillHeight: true
//                height: parent.height
                model: dataModel
                visible: !loader.active                
            }

            Loader {
                id: loader
                Layout.fillWidth: true
                Layout.fillHeight: true
                active: false
            }

            /*!
                \brief Debug draw rect
            */
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height / 5
                Layout.alignment: Qt.AlignBottom
                color: "plum"
                opacity: 0.8
                visible: !loader.active

                border {
                    color: "green"
                    width: 3
                }

                ColumnLayout {
                    width: parent.width
                    height: parent.height

                    /*!
                        \brief Debug draw rect
                    */
                    Rectangle {
                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredWidth: parent.width * 0.75
                        Layout.preferredHeight: 50
                        border {
                            color: "yellow"
                            width: 3
                        }

                        RowLayout {
                            width: parent.width
                            height: parent.height
                            Label {
                                Layout.alignment: Qt.AlignCenter
                                Layout.leftMargin: 5
                                font.pixelSize: 16
                                text: Helper.prependZero(Math.floor(dataModel.position / 1000 / 60)) + ":"
                                      + Helper.prependZero(Math.floor(dataModel.position / 1000 % 60))
                            }
                            CustomSlider {
                                id: seekSlider
                                Layout.preferredWidth: parent.width * 0.75
                                Layout.alignment: Qt.AlignCenter
                            }
                            Label {
                                Layout.alignment: Qt.AlignCenter
                                Layout.rightMargin: 5
                                font.pixelSize: 16
                                text: Helper.prependZero(Math.floor(dataModel.duration / 1000 / 60)) + ":"
                                      + Helper.prependZero(Math.floor(dataModel.duration / 1000 % 60))
                            }
                        }
                    }
                    /*!
                        \brief Bottom panel
                    */
                    ControlPanel {
                        Layout.alignment: Qt.AlignCenter
                        Layout.bottomMargin: 10
                    }
                }
            }
        }

        FileDialog {
            id: fileDialog
            folder: shortcuts.music
            nameFilters: [ "*.mp3", "*.mp4", "*.webm" ]
            selectMultiple: true
            onSelectionAccepted: {
//                console.log(fileUrls)
//                console.log(fileUrl)
                dataModel.createPlaylist(fileUrls)
            }
        }
    }
}

