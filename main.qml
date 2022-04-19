import QtQuick 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3
import MediaModel 1.0

ApplicationWindow {
    id: root
    width: 800
    height: 600
    visible: true
    minimumHeight: 240
    minimumWidth: 320
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

    property int itemAngle: 30
    property int itemSize: 150

//    header: ToolBar {
//        RowLayout {
//            id: headerRowLayout
//            anchors.fill: parent
//            spacing: 0

//            ToolButton {
//                icon.name: "grid"
//            }
//            ToolButton {
//                icon.name: "settings"
//            }
//            ToolButton {
//                icon.name: "filter"
//            }
//            ToolButton {
//                icon.name: "music"
//            }

//            Item {
//                Layout.fillWidth: true
//            }
//        }
//    }

//    Rectangle {
//        width: 50
//        height: parent.height
//        anchors.left: parent.left
//        color: "gray"
//        border {
//            color: "black"
//            width: 1
//        }

        Column {
//            anchors.fill: parent
            width: 50
            height: parent.height
            anchors.left: parent.left
            topPadding: 20
            spacing: 30

            RoundButton {
                icon.name: "home"
//                icon.width: 32
//                icon.height: 32
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
//                Layout.alignment: Qt.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            RoundButton {
                icon.name: "favorite"
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
//                Layout.alignment: Qt.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            RoundButton {
                icon.name: "music"
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
//                Layout.alignment: Qt.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            RoundButton {
                icon.name: "cloud"
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
//                Layout.alignment: Qt.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            RoundButton {
                icon.name: "settings"
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
                Layout.alignment: Qt.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
//    }




    MediaModel {
        id: dataModel
    }

    Rectangle {
        height: parent.height
        width: parent.width - 50
        anchors.right: parent.right
        color: "skyblue"
        border {
            color: "red"
            width: 1
        }

        ColumnLayout {
            width: parent.width
            height: parent.height
            Layout.margins: 20
            spacing: 10



//                Image {
//                    anchors.fill: parent
//                    fillMode: Image.PreserveAspectCrop
//                    source: "album-cover.jpg"
//                }

                ListView {
                    id: listView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: dataModel
//                    spacing: 5
                    clip: true

                    delegate: Row {
                        width: parent.width
                        height: 50
                        spacing: 5

                        RoundButton {
                            icon.name: "favorite"
                            icon.width: 32
                            icon.height: 32
                        }

                        Rectangle {
                            width: parent.width
                            height: parent.height
                            border.width: 1
                            border.color: "black"
                            color: "lightgray"
                            Text {
                                anchors.fill: parent
                                text: model.text
                                verticalAlignment: Text.AlignVCenter
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    songNameLabel.text = model.text
                                    dataModel.play()
                                }
                            }
                        }
                    }


//                    delegate: Rectangle {
//                        width: parent.width
//                        height: 50
//                        border.width: 1
//                        border.color: "black"
//                        color: "lightgray"
//                        Text {
//                            anchors.fill: parent
//                            text: model.text
//                            verticalAlignment: Text.AlignVCenter
//                         }
//                        MouseArea {
//                            anchors.fill: parent
//                            onClicked: {
//                                songNameLabel.text = model.text
//                                dataModel.play()
//                            }
//                        }
//                    }
                }



            Item {
                id: songLabelContainer
                clip: true
//                border.color: "red"
//                border.width: 2

//                Layout.fillWidth: true
                Layout.preferredWidth: songNameLabel.width / 2
                Layout.preferredHeight: songNameLabel.implicitHeight
                Layout.alignment: Qt.AlignHCenter

                SequentialAnimation {
                    id: songNameLabelAnimation
                    running: true
                    loops: Animation.Infinite

                    PauseAnimation {
                        duration: 2000
                    }
                    ParallelAnimation {
                        XAnimator {
                            target: songNameLabel
                            from: 0
                            to: songLabelContainer.width - songNameLabel.implicitWidth
                            duration: 5000
                        }
                        OpacityAnimator {
                            target: leftGradient
                            from: 0
                            to: 1
                        }
                    }
                    OpacityAnimator {
                        target: rightGradient
                        from: 1
                        to: 0
                    }
                    PauseAnimation {
                        duration: 1000
                    }
                    OpacityAnimator {
                        target: rightGradient
                        from: 0
                        to: 1
                    }
                    ParallelAnimation {
                        XAnimator {
                            target: songNameLabel
                            from: songLabelContainer.width - songNameLabel.implicitWidth
                            to: 0
                            duration: 5000
                        }
                        OpacityAnimator {
                            target: leftGradient
                            from: 0
                            to: 1
                        }
                    }
                    OpacityAnimator {
                        target: leftGradient
                        from: 1
                        to: 0
                    }
                }

                Rectangle {
                    id: leftGradient
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#dfe4ea"
                        }
                        GradientStop {
                            position: 1
                            color: "#00dfe4ea"
                        }
                    }

                    width: height
                    height: parent.height
                    anchors.left: parent.left
                    z: 1
                    rotation: -90
                    opacity: 0
                }

                Label {
                    id: songNameLabel
                    onTextChanged: songNameLabelAnimation.restart()
                    font.pixelSize: Qt.application.font.pixelSize * 1.4
                }

                Rectangle {
                    id: rightGradient
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#00dfe4ea"
                        }
                        GradientStop {
                            position: 1
                            color: "#dfe4ea"
                        }
                    }

                    width: height
                    height: parent.height
                    anchors.right: parent.right
                    rotation: -90
                }
            }

            RowLayout {
                spacing: 8
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 10

                RoundButton {
                    icon.name: "favorite"
                    icon.width: 32
                    icon.height: 32
                }
                RoundButton {
                    icon.name: "stop"
                    icon.width: 32
                    icon.height: 32
//                    onClicked:
                }
                RoundButton {
                    icon.name: "previous"
                    icon.width: 32
                    icon.height: 32
                }
                RoundButton {
                    icon.name: "play"
                    icon.width: 32
                    icon.height: 32
                    onClicked: {
                        icon.name == "play" ? icon.name = "pause" : icon.name = "play"
                        if (icon.name == "play")
                            dataModel.play()
                        else dataModel.stop()
                    }
                }
                RoundButton {
                    icon.name: "next"
                    icon.width: 32
                    icon.height: 32
                }
                RoundButton {
                    icon.name: "repeat"
                    icon.width: 32
                    icon.height: 32
                }
                RoundButton {
                    icon.name: "shuffle"
                    icon.width: 32
                    icon.height: 32
                }
                RoundButton {
                    icon.name: "add"
                    icon.width: 32
                    icon.height: 32
                    onClicked: {
                        fileDialog.open()
                    }
                }
            }
        }


        FileDialog {
            id: fileDialog
            folder: shortcuts.music
            nameFilters: [ "*.mp3", "*.mp4" ]
            selectMultiple: true
            onSelectionAccepted: {
//                console.log(fileUrls)
//                console.log(fileUrl)
                dataModel.createPlaylist(fileUrls)
            }
        }
    }

//    PathView {
//        id: view

//        anchors.fill: parent
//        model: dataModel
//        pathItemCount: 6

//        path: Path {
//            startX: 0
//            startY: height / 2

//            PathPercent { value: 0.0 }
//            PathAttribute { name: "z"; value: 0 }
//            PathAttribute { name: "angle"; value: itemAngle }
//            PathAttribute { name: "origin"; value: 0 }
//            PathLine {
//                x: (view.width - itemSize) / 2
//                y: view.height / 2
//            }
//            PathAttribute { name: "angle"; value: itemAngle }
//            PathAttribute { name: "origin"; value: 0 }
//            PathPercent { value: 0.49 }
//            PathAttribute { name: "z"; value: 10 }

//            PathLine { relativeX: 0; relativeY: 0 }

//            PathAttribute { name: "angle"; value: 0 }
//            PathLine {
//                x: (view.width - itemSize) / 2 + itemSize
//                y: view.height / 2
//            }
//            PathAttribute { name: "angle"; value: 0 }
//            PathPercent { value: 0.51 }

//            PathLine { relativeX: 0; relativeY: 0 }

//            PathAttribute { name: "z"; value: 10 }
//            PathAttribute { name: "angle"; value: -itemAngle }
//            PathAttribute { name: "origin"; value: itemSize }
//            PathLine {
//                x: view.width
//                y: view.height / 2
//            }
//            PathPercent { value: 1 }
//            PathAttribute { name: "z"; value: 0 }
//            PathAttribute { name: "angle"; value: -itemAngle }
//            PathAttribute { name: "origin"; value: itemSize }
//        }

//        delegate: Rectangle {
//            property real rotationAngle: PathView.angle
//            property real rotationOrigin: PathView.origin

//            width: itemSize
//            height: width
//            z: PathView.z
//            color: model.color
//            radius: 15
//            clip: true
//            border {
//                color: "black"
//                width: 1
//            }
//            transform: Rotation {
//                id: rotation
//                axis { x: 0; y: 1; z: 0 }
//                angle: rotationAngle
//                origin.x: rotationOrigin
//            }

//            Text {
//                anchors.fill: parent
//                font.pointSize: 16
//                wrapMode: Text.WordWrap
//                verticalAlignment: Text.AlignVCenter
//                horizontalAlignment: Text.AlignHCenter
//                text: model.text !== undefined ? model.text : model.name + "\n"+ model.track
//            }

//            MouseArea {
//                anchors.fill: parent
//                onClicked: console.log("Clicked", index)
//            }
//        }
//    }
}

