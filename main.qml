import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3
import MediaModel 1.0
import "helper.js" as Helper

ApplicationWindow {
    id: root
    width: 800
    height: 600
    visible: true
    minimumHeight: 600
    minimumWidth: 800
    title: qsTr("Hello World")
//    flags: Qt.FramelessWindowHint
//    color: "transparent"
//    Rectangle {
//        x: 10
//        y: 10
//        width: parent.width-20
//        height: parent.height-20
//        radius: 15
//    }

//    Rectangle {
//        color: "#3C096C"
//        opacity: 0.8
//        radius: 20
//        anchors.fill: parent
//    }
    background: Rectangle {
//        width: parent.width-20
//        height: parent.height-20
//        radius: 15
        gradient: Gradient {
            GradientStop { position: 0; color: "#ffffff" }
            GradientStop { position: 1; color: "#c1bbf9" }
        }
    }

    overlay.modal: Rectangle {
        color: "#8f28282a"
    }

    overlay.modeless: Rectangle {
        color: "#2f28282a"
    }

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
        width: 50
        height: parent.height
        anchors.left: parent.left
        topPadding: 20
    }

//    }

    MediaModel {
        id: dataModel
    }
    /*!
        \brief Debug draw rect
    */
    Rectangle {
        height: parent.height
        width: parent.width - leftPanel.width
        anchors.right: parent.right
//        color: "skyblue"
        color: "#f4f4fe"
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
                model: dataModel               
            }

//            Connections {
//                target: dataModel

//                function onPlayerStateChanged(state) {
//                    if (state === 1)
//                        songNameLabel.text = "1515151511"
//                    else
//                        songNameLabel.text = ""
//                }
//            }

//            Image {
//                fillMode: Image.PreserveAspectCrop
//                width: 50
//                height: 50
//                source: "album-cover.jpg"
//                source: model.coverImage
//            }


//                Connections {
//                    target: dataModel

//                    function onDurationReady() {
//                        seekSlider.to = dataModel.duration()
//                        console.log("Connect Duration = ", dataModel.duration())
//                    }

//                    function onPositionReady() {
//                        seekSlider.value = dataModel.position()
//                        console.log("Connect Position = ", dataModel.position())
//                    }
//                }

//            Timer {
//                running: false
//                interval: 1000
//                repeat: true
//                onTriggered: console.log("Position =",dataModel.position())
//                onTriggered: console.log("Position =",dataModel.positionReady())
//            }

            /*!
                \brief Debug draw rect
            */
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height / 5
                Layout.alignment: Qt.AlignBottom
                color: "plum"
                opacity: 0.8

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

