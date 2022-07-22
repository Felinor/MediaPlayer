import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.XmlListModel 2.15
import QtGraphicalEffects 1.15
import QtWebView 1.15

Rectangle {
    border.width: 3
    border.color: "yellow"
    color: "steelblue"
    clip: true

//    WebView {
//        id: webView
//        url: "https://www.radio-browser.info/search?page=1&hidebroken=true&order=votes&reverse=true"
//        anchors.fill: parent
//    }

    XmlListModel {
        id: xmlModel

//        source: "https://nl1.api.radio-browser.info/xml/stations/search?offset=10&limit=10&countrycode=US&hidebroken=true&order=clickcount&reverse=true"
        source: "radiolist.xml"
        query: "/result/station"

        XmlRole {
            name: "name"
            query: "@name/string()"
        }
        XmlRole {
            name: "source"
            query: "@url/string()"
        }
        XmlRole {
            name: "icon"
            query: "@favicon/string()"
        }
        XmlRole {
            name: "votes"
            query: "@votes/string()"
        }
    }

    ListModel {
        id: listModel
        ListElement {
            name: "BBC Radio 4"
            icon: "http://api.my-radios.com/images/thumb.php?countryCode=GB&name=14984-8914715.png&size=200"
            source: "http://stream.live.vc.bbcmedia.co.uk/bbc_radio_fourfm"
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
            name: "Дорожное радио"
            icon: "https://online-red.com/images/radio-logo/dor.png"
            source: "https://dorognoe.hostingradio.ru:8000/dorognoe?561f39d2"
        }
        ListElement {
            name: "ТНТ Music Radio"
            icon: "https://online-red.com/images/radio-logo/tnt-music-radio.png"
            source: "https://tntradio.hostingradio.ru:8027/tntradio128.mp3?c890"
        }
        ListElement {
            name: "BBC Radio 1"
            icon: "http://api.my-radios.com/images/thumb.php?countryCode=GB&name=14985-2143609.png&size=200"
            source: "http://stream.live.vc.bbcmedia.co.uk/bbc_radio_one"
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
        ListElement {
            name: "Radio Paradise"
            icon: "https://www.radioparadise.com/favicon.ico"
            source: "http://stream-uk1.radioparadise.com/aac-320"
        }
    }

    GridView {
        id: gridView
        property string stationName: ""
//        visible: false

//        model: listModel
        model: xmlModel
//        anchors.fill: parent
        width: parent.width
        height: parent.height -100
        clip: true
        cellWidth: 150
        cellHeight: 150
        topMargin: 10
        leftMargin: 10
        delegate: Item {
            width: gridView.cellWidth
            height: gridView.cellHeight

            Column {
                spacing: 5

                Rectangle {
                    id: overlap
                    visible: false
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: gridView.cellWidth - 25
                    height: gridView.cellHeight - 25
                    color: "white"
                    radius: 15

                    Image {
                        id: image1

                        source: "https://cdn-icons-png.flaticon.com/128/3308/3308709.png"
                        anchors.centerIn: parent
                        width: 50
                        height: 50
                    }

                    Label {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Votes: " + votes
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            cursorShape = Qt.PointingHandCursor
                        }
                        onExited: {
                            cursorShape = Qt.ArrowCursor
                            overlap.visible = !overlap.visible
                            image.visible = !image.visible
                        }
                        onClicked: {
                            dataModel.playRadio(source)
                            gridView.stationName = name
                        }
                    }
                }

                Image {
                    id: image

                    source: icon === "" ? "radio.png" : icon
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: gridView.cellWidth - 25
                    height: gridView.cellHeight - 25
                    Component.onCompleted: {
                        console.log(image.source, "<-- Icon source")
                    }

                    property bool rounded: true
                    property bool adapt: true

                    layer.enabled: rounded
                    layer.effect: OpacityMask {
                        maskSource: Item {
                            width: image.width
                            height: image.height
                            Rectangle {
                                anchors.centerIn: parent
                                width: image.adapt ? image.width : Math.min(image.width, image.height)
                                height: image.adapt ? image.height : width
                                radius: 15
                            }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            cursorShape = Qt.PointingHandCursor
                            overlap.visible = !overlap.visible
                            image.visible = !image.visible
                        }
                        onExited: {
                            cursorShape = Qt.ArrowCursor
//                            overlap.visible = !overlap.visible
//                            image.visible = !image.visible
                        }
                        onClicked: {
                            dataModel.playRadio(source)
                            gridView.stationName = name
                        }
                    }
                }

                Item {
                    id: container

                    anchors.horizontalCenter: parent.horizontalCenter
                    width: gridView.cellWidth - 50
                    height: radioStationName.height
                    clip: true

                    Text {
                        id: radioStationName
                        horizontalAlignment: Qt.AlignHCenter
                        text: name
                        color: "white"

                        NumberAnimation on x {
                            from: container.width
                            to: -radioStationName.width
                            duration: 10000
                            loops: Animation.Infinite
                            running: radioStationName.width > container.width
                        }
                    }
                }
            }
        }
    }

    Label {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 50
        anchors.top: gridView.bottom
        text: gridView.stationName + '\n' + "Position: "
              + (dataModel.position / 1000).toFixed(0)
        color: "white"
    }
}
