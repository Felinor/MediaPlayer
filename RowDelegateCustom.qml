import QtQuick 2.15
import QtQuick.Controls 2.15

ItemDelegate {
    id: delegateRow

    property int heightRows: 50
    property bool isCurrentMediaPlaying: dataModel.mediaPlayerState === 1
                                         && dataModel.currentMediaIndex === styleData.row

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
        if (delegateRow.hovered || styleData.selected
                || (isCurrentMediaPlaying))
            return currentRowGradient

        return defaultGradient
    }

    height: isCurrentMediaPlaying ? heightRows + 5 : heightRows
    hoverEnabled: true

    background: Rectangle {
        anchors.fill: delegateRow
        gradient: styleData.row < tableView.rowCount ? setGradient() : null
    }

    Behavior on height { PropertyAnimation { duration: 100 } }

    Menu {
//        id: hideMenu
        visible: true
        MenuItem {
            text: "Удалить"
            //                iconSource: "cart"
            onTriggered: dataModel.removeRow(styleData.row)
            visible: tableView.currentRow === -1 ? false : true
        }
    }

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

                if (isCurrentMediaPlaying) {
                    dataModel.pause()
                }
                tableView.currentRow = styleData.row
                dataModel.setCurrentMedia(styleData.row)

                tableView.selection.clear()
                tableView.selection.select(styleData.row)
            }
            else if (mouse.button === Qt.RightButton && styleData.row !== undefined) {
                console.log("CLICKED")
                hideMenu.popup()
            }
        }
        Menu {
            id: hideMenu
            MenuItem {
                text: "Удалить"
                onTriggered: dataModel.removeRow(styleData.row)
            }
        }
    }
}
