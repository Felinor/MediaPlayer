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

        return defaultGradient
    }

    height: delegateRow.hovered ? heightRows + 5 : heightRows
    clip: true
    hoverEnabled: true

    background: Rectangle {
        id: backgroundRect

        anchors.fill: delegateRow
//        gradient: styleData.row < tableView.rowCount ? setGradient() : null
        gradient: defaultGradient

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
//                console.log("Прокси индекс " + tableView.model.getIndex(styleData.row))
//                console.log("Индекс делегата " + styleData.row)
//                console.log(tableView.model.getIndex(styleData.row) === styleData.row)
//                console.log(dataModel.count)
//                console.log(tableView.model.get(styleData.row).keyRole)

                songNameLabel.text = model.artist
                dataModel.setCurrentMedia(model.index)
            }

            else {
                tableView.currentRow = styleData.row
            }
        }
    }
}

