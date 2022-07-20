import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3

Column {
    spacing: 30

    RoundButton {
        icon.name: "equalizer"
//        icon.width: 32
//        icon.height: 32
        Layout.preferredWidth: 32
        Layout.preferredHeight: 32
//        Layout.alignment: Qt.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: console.log("will open home")
    }
    RoundButton {
        icon.name: "favorite"
        Layout.preferredWidth: 32
        Layout.preferredHeight: 32
        icon.width: 32
        icon.height: 32
//        Layout.alignment: Qt.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: console.log("will open favorite")
    }
    RoundButton {
        icon.name: "music"
        Layout.preferredWidth: 32
        Layout.preferredHeight: 32
//        Layout.alignment: Qt.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: console.log("will open music")
    }
    RoundButton {
        icon.name: "settings"
        Layout.preferredWidth: 32
        Layout.preferredHeight: 32
//        Layout.alignment: Qt.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: console.log("will open cloud")
    }
    RoundButton {
        icon.name: "loadPlaylist"
        Layout.preferredWidth: 32
        Layout.preferredHeight: 32
        Layout.alignment: Qt.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: loadDialog.open()
        FileDialog {
            id: loadDialog
            folder: shortcuts.music
            nameFilters: [ "*.m3u", "*.m3u8", "*.pls" ]
            onAccepted: dataModel.loadPlaylist(fileUrl)
        }
        Connections {
            target: dataModel

            function onPathIsInvalid() {
                invalidPathDialog.open()
            }
        }
        MessageDialog {
            id: invalidPathDialog
            title: "Path is invalid"
            text: "Please check the path(s) in the playlist. \n (ｏ・_・)ノ”(ノ_<、)"
        }
    }
    RoundButton {
        icon.name: "savePlaylist"
        Layout.preferredWidth: 32
        Layout.preferredHeight: 32
        Layout.alignment: Qt.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: !dataModel.playListIsEmpty() ? saveDialog.open() : messageDialog.open()
        FileDialog {
            id: saveDialog
            folder: shortcuts.music
            selectExisting: false
            onAccepted: dataModel.savePlaylist(fileUrl)

        }
        MessageDialog {
            id: messageDialog
            title: "Playlist is empty"
            text: "Add something to the playlist. \n (* ^ ω ^)"
        }
    }    
    RoundButton {
        icon.name: loader.active ? "music" : "radio"
        Layout.preferredWidth: 32
        Layout.preferredHeight: 32
        Layout.alignment: Qt.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            loader.active = !loader.active
            loader.source = "RadioWindow.qml"
            console.log("will open radio")
        }
    }
}
