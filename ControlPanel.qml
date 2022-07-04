import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

RowLayout {
    Layout.alignment: Qt.AlignCenter
    Layout.bottomMargin: 10
    spacing: 8

    Connections {
        target: dataModel

        function onPlayerStateChanged(state) {
            console.log(state, "<-- State")
            mediaStatus = state
            if (state === 1)
                playButton.icon.name = "pause"
            else
                playButton.icon.name = "play"
        }
    }

    RoundButton {
        icon.name: "favorite"
        icon.width: 32
        icon.height: 32
        onClicked: console.log("will open favorite")
    }
//                RoundButton {
//                    icon.name: "stop"
//                    icon.width: 32
//                    icon.height: 32
//                    onClicked: dataModel.stop()
//                }
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
            tableView.currentRow = currentMediaIndex
            tableView.selection.select(currentMediaIndex)
        }
    }
    RoundButton {
        id: playButton
        icon.name: "play"
        icon.width: 32
        icon.height: 32
        onClicked: {
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
            tableView.currentRow = currentMediaIndex
            tableView.selection.select(currentMediaIndex)
        }
    }
    RoundButton {
        icon.name: "repeat"
        icon.width: 32
        icon.height: 32
        onClicked: dataModel.currentItemInLoop()
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
