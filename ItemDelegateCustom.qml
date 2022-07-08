import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: delegateItem

    property bool isCurrentMediaPlaying: dataModel.mediaPlayerState === 1
                                         && dataModel.currentMediaIndex === styleData.row

    Item {
        id: container
        anchors.fill: parent
        anchors.margins: 15

        Image {
            visible: isCurrentMediaPlaying && styleData.column === 0
            width: 25
            height: width
            fillMode: Image.PreserveAspectFit
            source: dataModel.volume !== 0 ? "qrc:/icons/mediaplayer/32x32@2/volume.png"
                                                : "qrc:/icons/mediaplayer/32x32@2/mute.png"
        }

        Text {
            id: textRow            
            width: parent.width
            text: styleData.column === 0 ? (isCurrentMediaPlaying ? "" : styleData.row + 1) : styleData.value
            elide: Text.ElideRight
            color: "white"
            font {
                pointSize: delegateItem.height * 0.32
                family: "Avenir Heavy"
                wordSpacing: 1
            }

//            NumberAnimation on x {
//                from: container.width
//                to: -textRow.width
//                duration: 10000
//                loops: Animation.Infinite
//                running: textRow.width > container.width
//            }
        }        
    }
}
