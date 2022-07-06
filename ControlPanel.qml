import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

RowLayout {
    spacing: 8

    RoundButton {
        icon.name: "favorite"
        icon.width: 32
        icon.height: 32
        onClicked: console.log("will open favorite")
    }
    RoundButton {
        icon.name: "shuffle"
        icon.width: 32
        icon.height: 32
        onClicked: dataModel.random()
    }
    RoundButton {
        icon.name: "previous"
        icon.width: 32
        icon.height: 32
        onClicked: {
            dataModel.previous()
            tableView.selection.clear()
            tableView.currentRow = dataModel.currentMediaIndex
            tableView.selection.select(dataModel.currentMediaIndex)
        }
    }
    RoundButton {
        icon.name: dataModel.mediaPlayerState === 1 ? "pause" : "play"
        icon.width: 32
        icon.height: 32
        onClicked: { tableView.selection.clear()
            dataModel.mediaPlayerState === 1 ? tableView.selection.select(dataModel.currentMediaIndex)
                                             : tableView.selection.clear()
            icon.name == "play" ? dataModel.play() : dataModel.pause()
        }
    }
    RoundButton {
        icon.name: "next"
        icon.width: 32
        icon.height: 32
        onClicked: {
            dataModel.next()
            tableView.selection.clear()
            tableView.currentRow = dataModel.currentMediaIndex
            tableView.selection.select(dataModel.currentMediaIndex)
        }
    }
    RoundButton {
        icon.name: "repeat"
        icon.width: 32
        icon.height: 32
        onClicked: dataModel.loopCurrentItem()
    }
    RoundButton {
        icon.name: "add"
        icon.width: 32
        icon.height: 32
        onClicked: {
            fileDialog.open()
        }
    }
    RoundButton {
        icon.name: ""
        icon.width: 32
        icon.height: 32
        onClicked: {
            seekSlider.to = Math.random() *100
        }
    }
}
