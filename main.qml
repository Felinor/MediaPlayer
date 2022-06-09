import QtQuick 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3
import MediaModel 1.0
import QtQuick.Controls 1.4 as QQ1

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

//        Left panel
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
                onClicked: console.log("will open home")
            }
            RoundButton {
                icon.name: "favorite"
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
                icon.width: 32
                icon.height: 32
//                Layout.alignment: Qt.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: console.log("will open favorite")
            }           
            RoundButton {
                icon.name: "music"
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
//                Layout.alignment: Qt.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: console.log("will open music")
            }
            RoundButton {
                icon.name: "cloud"
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
//                Layout.alignment: Qt.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: console.log("will open cloud")
            }
            RoundButton {
                icon.name: "settings"
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
                Layout.alignment: Qt.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: console.log("will open settings")
            }
            RoundButton {
                icon.name: "equalizer"
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
                Layout.alignment: Qt.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: console.log("will open equalizer")
            }
        }
//    }

    MediaModel {
        id: dataModel
    }

//  Debug draw rect
    Rectangle {
        height: parent.height
        width: parent.width - 50
        anchors.right: parent.right
//        color: "skyblue"
        color: "#f4f4fe"
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

            QQ1.TableView {
                id: tableView
                clip: true
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height / 2
                model: dataModel
//                backgroundVisible: false

                QQ1.TableViewColumn {
                    id: column_0
                    width: 100
                    title: "#"
                    role: ""
                }

                QQ1.TableViewColumn {
                    id: column_1
                    width: 100
                    title: "TITLE"
                    role: "title"
                }

                QQ1.TableViewColumn {
                    id: column_2
                    width: 100
                    title: "ARTIST"
                    role: "artist"
                }

                QQ1.TableViewColumn {
                    id: column_3
                    width: 100
                    title: "TIME"
                    role: ""
                }

                QQ1.TableViewColumn {
                    id: column_4
                    width: 100
                    title: "ALBUM"
                    role: ""
                }
            }

//              List View
                ListView {
                    id: listView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: dataModel
                    spacing: 5
                    clip: true                   

                    highlight: Rectangle {
                        color: "green"
                    }
                    highlightFollowsCurrentItem: true                    

//                    Connections {
//                        target: dataModel

//                        function onPlayerStateChanged(state) {
//                            if (state === 1)
//                                songNameLabel.text = "1515151511"
//                            else
//                                songNameLabel.text = ""
//                        }
//                    }

                    delegate: Row {
                        width: parent.width
                        height: 50
                        spacing: 5                     

                        Image {
//                            fillMode: Image.PreserveAspectCrop
                            width: 50
                            height: 50
//                            source: "album-cover.jpg"
                            source: model.coverImage
                        }

                        Rectangle {
                            width: parent.width
                            height: parent.height
                            border.width: 1
                            border.color: "red"
                            color: "lightgray"

//                            RoundButton {
//                                icon.name: "favorite"
//                                icon.width: 32
//                                icon.height: 32
//                            }                            

                            Text {
                                anchors.fill: parent
                                text: model.artist
//                                text: model.artist + " - " + model.title
//                                Layout.alignment: Qt.AlignCenter
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    songNameLabel.text = model.artist
                                    dataModel.setCurrentMedia(model.index)
                                    ListView.currentIndex = model.index
//                                    console.log(model.index, "Model Index")
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



                Timer {
                    running: false
                    interval: 1000
                    repeat: true
                    onTriggered: console.log("Position =",dataModel.position())
//                    onTriggered: console.log("Position =",dataModel.positionReady())
                }

//              Debug draw rect
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height / 5
                    Layout.alignment: Qt.AlignBottom
                    color: "plum"
                    opacity: 0.8

                    ColumnLayout {
                        width: parent.width
                        height: parent.height
//                        spacing: 25

//                      songLabelContainer
                        Rectangle {
                            id: songLabelContainer
                            clip: true
                            border.color: "red"
//                            border.width: 2

//                            Layout.fillWidth: true
                            Layout.preferredWidth: songNameLabel.width / 2
                            Layout.preferredHeight: songNameLabel.implicitHeight
                            Layout.alignment: Qt.AlignCenter
                            Layout.topMargin: 10

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

                Slider {
                    id: seekSlider
                    Layout.preferredWidth: parent.width / 2
                    Layout.alignment: Qt.AlignCenter

                    from: 0
                    to: dataModel.duration
                    value: dataModel.position
                    onMoved: {
                        console.log(value, "Position")
//                        console.log(valueAt(position), "value")
                        dataModel.setMediaPosition(valueAt(position))
                    }

//                    MouseArea {
//                        anchors.fill: parent
//                        hoverEnabled: true
//                        onEntered: cursorShape = Qt.PointingHandCursor
//                    }                    

                    ToolTip {
                        id: toolTip
                        parent: seekSlider.handle
                        visible: seekSlider.pressed
                        text: pad(Math.floor(value / 60)) + ":" + pad(Math.floor(value % 60))
                        y: parent.height
//                        background: Item {
//                            width: 80
//                            height: 70
//                        }

                        readonly property int value: seekSlider.valueAt(seekSlider.position)

                        function pad(number) {
                            if (number <= 9)
                                return "0" + number;
                            return number;
                        }
                    }
                }

//          Bottom panel
            RowLayout {
                Layout.alignment: Qt.AlignCenter
                Layout.bottomMargin: 10
                spacing: 8

                Connections {
                    target: dataModel

                    function onPlayerStateChanged(state) {
                        console.log("State = " + state)
                        if (state === 1)
                            playButton.icon.name = "pause"
                        else
                            playButton.icon.name = "play"
                    }
                }

                RoundButton {
                    icon.name: "favorite"
                    icon.width: 32
                    icon.height: 32
                    onClicked: console.log("will open favorite")
                }
//                RoundButton {
//                    icon.name: "stop"
//                    icon.width: 32
//                    icon.height: 32
//                    onClicked: dataModel.stop()
//                }
                RoundButton {
                    icon.name: "shuffle"
                    icon.width: 32
                    icon.height: 32
                    onClicked: dataModel.random()
                }
                RoundButton {
                    icon.name: "previous"
                    icon.width: 32
                    icon.height: 32
                    onClicked: dataModel.previous()
                }
                RoundButton {
                    id: playButton
                    icon.name: "play"
                    icon.width: 32
                    icon.height: 32
                    onClicked: {
                        icon.name == "play" ? dataModel.play() : dataModel.pause()
                    }
                }
                RoundButton {
                    icon.name: "next"
                    icon.width: 32
                    icon.height: 32
                    onClicked: dataModel.next()
                }
                RoundButton {
                    icon.name: "repeat"
                    icon.width: 32
                    icon.height: 32
                    onClicked: dataModel.currentItemInLoop()
                }                
                RoundButton {
                    icon.name: "add"
                    icon.width: 32
                    icon.height: 32
                    onClicked: {
                        fileDialog.open()
                    }
                }
                RoundButton {
                    icon.name: ""
                    icon.width: 32
                    icon.height: 32
                    onClicked: {
                        seekSlider.to = Math.random() *100
                    }
                }
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
}

