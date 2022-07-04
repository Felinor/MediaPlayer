import QtQuick 2.11
import QtQuick.Controls 2.4

ItemDelegate {
    id: delegateRow

    property int heightRows: 50

    Gradient {
        id: defaultGradient
        GradientStop { position: 0; color: "#75808A" }
        GradientStop { position: 0.5; color: "#52606D" }
    }

    Gradient {
        id: currentRowGradient
        GradientStop { position: 0; color: "#56789D" }
        GradientStop { position: 0.5; color: "#45607E" }
    }  

    Connections {
        target: dataModel

        function onCurrentMediaChanged(position) {
            currentMediaIndex = position
            tableView.currentRow = position
        }
    }

    function setGradient() {
        if (delegateRow.hovered)
            return currentRowGradient

        if (mediaStatus === "1" && currentMediaIndex === styleData.row) {
            return currentRowGradient
        }

//        if (tableView.selection.contains(styleData.row))
//            return currentRowGradient

        if (styleData.selected)
            return currentRowGradient

        return defaultGradient
    }

//    height: delegateRow.hovered ? heightRows + 5 : heightRows
    height: (mediaStatus === "1" && currentMediaIndex === styleData.row) ? heightRows + 5 : heightRows
    clip: true
    hoverEnabled: true

    background: Rectangle {
        id: backgroundRect

        anchors.fill: delegateRow
        gradient: styleData.row < tableView.rowCount ? setGradient() : null
    }

    Behavior on height { PropertyAnimation { duration: 100 } }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: styleData.row === undefined ? Qt.ArrowCursor : Qt.PointingHandCursor
        onDoubleClicked: dataModel.play()
        onClicked: {
            if (mouse.button === Qt.LeftButton && styleData.row !== undefined) {
//                console.log("Индекс делегата " + styleData.row)
//                songLabelContainer.songLabel.text = model.artist
//                dataModel.setCurrentMedia(model.index)

                if (mediaStatus === "1" && currentMediaIndex === styleData.row) {
                    dataModel.pause()
                }
                tableView.currentRow = styleData.row
                dataModel.setCurrentMedia(styleData.row)

                tableView.selection.clear()
                tableView.selection.select(styleData.row)
            }
        }        
    }
}

