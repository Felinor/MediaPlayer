import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id: delegateItem
    clip: true

    Item {
        id: container
        anchors.fill: parent
        anchors.margins: 15

        Image {
            visible: mediaStatus === "1" && currentMediaIndex === styleData.row && styleData.column === 0
            width: 25
            height: width
            fillMode: Image.PreserveAspectFit
            source: "sound.png"
        }

        Text {
            id: textRow            
            width: parent.width
//            text: styleData.column === 0 ? styleData.row + 1 : styleData.value
            text: styleData.column === 0 ? (mediaStatus === "1" && currentMediaIndex === styleData.row)
                                         ? ""
                                         : styleData.row + 1
                                         : styleData.value
            elide: Text.ElideRight
            color: "white"
            font {
                pointSize: delegateItem.height * 0.32
                family: "Avenir Heavy"
                wordSpacing: 1
            }

            Connections {
                target: dataModel

                function onCurrentMediaChanged(position) {
                    currentMediaIndex = position
                }
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

