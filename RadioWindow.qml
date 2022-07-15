import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.XmlListModel 2.15

Rectangle {
    border.width: 3
    border.color: "yellow"
    color: "steelblue"

    XmlListModel {
        id: xmlModel

        source: "https://nl1.api.radio-browser.info/xml/stations/search?limit=10&countrycode=US&hidebroken=true&order=clickcount&reverse=true"
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
//        ListElement {
//            name: "101-smoothjazz.m3u"
//            icon: ""
//            source: "/home/felinor/Музыка/101-smoothjazz.m3u"
//        }
    }

    GridView {
        id: gridView

        model: listModel
//        model: xmlModel
        anchors.fill: parent
        cellWidth: 150
        cellHeight: 150
        topMargin: 10
        leftMargin: 10
        delegate: Item {
            width: gridView.cellWidth
            height: gridView.cellHeight

            Column {
                spacing: 5                

                Image {
                    id: image

                    source: icon;
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: gridView.cellWidth - 25
                    height: gridView.cellHeight - 25                    

                    property bool rounded: true
                    property bool adapt: true

                    layer.enabled: rounded
                    layer.effect: ShaderEffect {
                        property real adjustX: image.adapt ? Math.max(width / height, 1) : 1
                        property real adjustY: image.adapt ? Math.max(1 / (width / height), 1) : 1

                        fragmentShader: "
                            #ifdef GL_ES
                                precision lowp float;
                            #endif // GL_ES
                            varying highp vec2 qt_TexCoord0;
                            uniform highp float qt_Opacity;
                            uniform lowp sampler2D source;
                            uniform lowp float adjustX;
                            uniform lowp float adjustY;

                            void main(void) {
                                lowp float x, y;
                                x = (qt_TexCoord0.x - 0.5) * adjustX;
                                y = (qt_TexCoord0.y - 0.5) * adjustY;
                                float delta = adjustX != 1.0 ? fwidth(y) / 2.0 : fwidth(x) / 2.0;
                                gl_FragColor = texture2D(source, qt_TexCoord0).rgba
                                    * step(x * x + y * y, 0.25)
                                    * smoothstep((x * x + y * y) , 0.25 + delta, 0.25)
                                    * qt_Opacity;
                            }"
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: cursorShape = Qt.PointingHandCursor
                        onExited: cursorShape = Qt.ArrowCursor
                        onClicked: dataModel.playRadio(source)
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
}
