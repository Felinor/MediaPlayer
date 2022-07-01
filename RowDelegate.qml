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

    function setGradient() {
        if (delegateRow.hovered)
            return currentRowGradient

        if (mediaStatus === "1" && dataModel.getCurrentIndex() === styleData.row)
            return currentRowGradient

        if (tableView.selection.contains(styleData.row))
            return currentRowGradient

        return defaultGradient
    }

//    Timer {
//        running: true
//        repeat: true
//        interval: 500
//        onTriggered: backgroundRect.gradient = setGradient()
//    }

//    height: delegateRow.hovered ? heightRows + 5 : heightRows
    height: (mediaStatus === "1" && dataModel.getCurrentIndex() === styleData.row) ? heightRows + 5 : heightRows
    clip: true
    hoverEnabled: true

    background: Rectangle {
        id: backgroundRect

        anchors.fill: delegateRow
        gradient: styleData.row < tableView.rowCount ? setGradient() : null
//        gradient: defaultGradient

//        Image {
//            visible: true
//            width: 20
//            height: 20
//            anchors.centerIn: parent
//            anchors.left: parent.left
//            verticalAlignment: Image.AlignVCenter
//            horizontalAlignment: Image.AlignHCenter
//            source: "sound.png"
//        }
    }

    Behavior on height { PropertyAnimation { duration: 100 } }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: styleData.row === undefined ? Qt.ArrowCursor : Qt.PointingHandCursor
        onClicked: {
            if (mouse.button === Qt.LeftButton && styleData.row !== undefined) {
//                console.log("Индекс делегата " + styleData.row)

//                songLabelContainer.songLabel.text = model.artist
//                dataModel.setCurrentMedia(model.index)
                dataModel.pause()
                dataModel.setCurrentMedia(styleData.row)

//                delegateRow.height = heightRows + 5
//                backgroundRect.gradient = setGradient()
//                console.log(mediaStatus, "<-- STATUS")
                tableView.selection.clear()
                tableView.selection.select(styleData.row)
//                console.log(tableView.selection.count)
                tableView.selection.forEach( function(rowIndex) {console.log(rowIndex)} )

            }

            else {
                tableView.currentRow = styleData.row
            }
        }
    }
}

