import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: control
    width: 80
    height: 40

//    icon.source: "qrc:/appLogo.ico"
//    icon.name: "edit-undo"
//    icon.width: 30
//    icon.height: 30

    onClicked: console.log("CLICKED")

    contentItem:
        Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.down ? "black" : "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        color: control.down ? "white" : "transparent"
        opacity: control.down ? 0.3 : 0.5
        border.color: "white"
        border.width: 1
        radius: 5
    }
}
