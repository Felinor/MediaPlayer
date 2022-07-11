import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Column {
    spacing: 30

    RoundButton {
        icon.name: "home"
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
        icon.name: "cloud"
        Layout.preferredWidth: 32
        Layout.preferredHeight: 32
//        Layout.alignment: Qt.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: console.log("will open cloud")
    }
    RoundButton {
        icon.name: "settings"
        Layout.preferredWidth: 32
        Layout.preferredHeight: 32
        Layout.alignment: Qt.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: console.log("will open settings")
    }
    RoundButton {
        icon.name: "equalizer"
        Layout.preferredWidth: 32
        Layout.preferredHeight: 32
        Layout.alignment: Qt.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            console.log("will open equalizer")
            dataModel.playRadio()
        }
    }
    RoundButton {
        icon.name: "radio"
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
