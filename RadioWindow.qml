import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    border.width: 3
    border.color: "black"
    color: "steelblue"

    ListModel {
        id: listModel
        ListElement {
            name: "Русское Радио"
            icon: "radioIcons/RussianRadio.png"
            sourse: " http://icecast.russkoeradio.cdnvideo.ru/rr.mp3"
        }
        ListElement {
            name: "Авторадио"
            icon: "radioIcons/autoRadio.png"
            source: "https://ic7.101.ru:8000/v3_1?7b76af0b"
        }
        ListElement {
            name: "Comedy Radio"
            icon: "radioIcons/comedyRadio.png"
            source: "https://ic6.101.ru:8000/202?a76f8351"
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
        model: listModel
        anchors.fill: parent
        cellWidth: 110
        cellHeight: 110
        delegate: Item {
            Column {
                Image {
                    source: icon;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    width: 100; height: 100
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: cursorShape = Qt.PointingHandCursor
                        onExited: cursorShape = Qt.ArrowCursor
                        onClicked: dataModel.setMedia(source)
                    }
                }
                Text { text: name; anchors.horizontalCenter: parent.horizontalCenter }
            }
        }
    }
}
