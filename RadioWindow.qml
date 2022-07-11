import QtQuick 2.15
import QtQuick.Controls 2.15
//import QtQuick.Extras 1.4

Rectangle {
    border.width: 3
    border.color: "black"
    color: "steelblue"

    ListModel {
        id: listModel
        ListElement {
            name: "Русское Радио"
            icon: "https://online-red.com/images/radio-logo/RUS-radio.png"
            sourse: "https://rusradio.hostingradio.ru/rusradio96.aacp?0db3"
        }
        ListElement {
            name: "Авторадио"
            icon: "https://online-red.com/images/radio-logo/Avtoradio.png"
            source: "https://ic7.101.ru:8000/v3_1?7b76af0b"
        }
        ListElement {
            name: "Comedy Radio"
            icon: "https://online-red.com/images/radio-logo/comedy-radio.png"
            source: "https://ic6.101.ru:8000/stream/air/aac/64/202?c0172d37"
        }
        ListElement {
            name: "Europa plus"
            icon: "https://online-red.com/images/radio-logo/europa-plus.png"
            source: "https://europaplus.hostingradio.ru:8014/europaplus320.mp3?caffaf9f"
        }
        ListElement {
            name: "Ретро FM"
            icon: "https://online-red.com/images/radio-logo/Retro-FM.png"
            source: "https://hls-01-retro.emgsound.ru/12/96/playlist.m3u8?39d7"
        }
        ListElement {
            name: "DFM"
            icon: "https://online-red.com/images/radio-logo/DFM.png"
            source: "https://dfm.hostingradio.ru/dfm96.aacp?d9839e6f"
        }
        ListElement {
            name: "Юмор FM"
            icon: "https://online-red.com/images/radio-logo/Umor-FM.png"
            source: "https://pub0302.101.ru:8443/stream/air/aac/64/102?8343"
        }
        ListElement {
            name: "J-Rock Powerplay"
            icon: "https://images.radiovolna.net/_files/images/stations/30712/003d378fb2dbc3d5a5ccad2609028294_100x100.webp"
            source: "https://kathy.torontocast.com:3340/;"
        }
        ListElement {
            name: "HitsRadio 977 - Today's Hits"
            icon: "https://images.radiovolna.net/_files/images/stations/923/v6s258d39eb074b47690196685_100x100.webp"
            source: "https://24503.live.streamtheworld.com/977_HITSAAC_SC"
        }
    }

//    ListView {
//        model: listModel
//        anchors.fill: parent
//        delegate: Column {
//            Image { source: icon; anchors.horizontalCenter: parent.horizontalCenter; width: 100; height: 100 }
//            Text { text: name; anchors.horizontalCenter: parent.horizontalCenter }
//        }
//    }

    GridView {
        id: gridView

        model: listModel
        anchors.fill: parent
        cellWidth: 110
        cellHeight: 110
        topMargin: 5
        leftMargin: 5
        delegate: Item {
            width: gridView.cellWidth
            height: gridView.cellHeight
            Column {
                spacing: 5
                Image {
                    source: icon;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    width: gridView.cellWidth - 10
                    height: gridView.cellHeight - 10
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: cursorShape = Qt.PointingHandCursor
                        onExited: cursorShape = Qt.ArrowCursor
                        onClicked: dataModel.setMedia(source)
                    }
                }

                Item {
                    id: container
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: gridView.cellWidth - 10
                    height: text.height
                    clip: true

                    Text {
                        id: text
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter
                        text: name

                        NumberAnimation on x {
                            from: container.width
                            to: -text.width
                            duration: 10000
                            loops: Animation.Infinite
                            running: text.width > container.width
                        }
                    }
                }
            }
        }
    }

//    Row {
//        anchors.centerIn: parent
//        spacing: 5

//        Button {
//            width: 50
//            height: 50
//            text: "left"
//            onClicked: {
//                console.log("search backward")
//                dataModel.searchBackward()
//            }
//        }

//        Button {
//            width: 50
//            height: 50
//            text: "right"
//            onClicked: {
//                console.log("search forward")
//                dataModel.searchForward()
//            }
//        }
//    }

//    Slider {
//        id: seekSlider

//        anchors.centerIn: parent
//        from: 87.5
//        to: 108
//        value: 87.5
//        onMoved: {
////            console.log(value.toFixed(1), "<-- position")
//            console.log(valueAt(position), "value")
//            dataModel.playRadio(valueAt(position).toFixed(2))
//        }

//        ToolTip {
//            id: toolTip
//            parent: seekSlider.handle
//            visible: seekSlider.pressed
//            text: seekSlider.value.toFixed(0)
//            y: parent.height
//        }
//    }
}
