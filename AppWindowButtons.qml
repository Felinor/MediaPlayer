import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

/*!
    \brief Debug draw rect
*/
Rectangle {
    width: parent.width
    height: 50
    color: "skyblue"
    border.color: "darkred"
    border.width: 3

    MouseArea {
        id:dragparentwindow
        anchors.fill: parent
        property real lastMouseX: 0
        property real lastMouseY: 0
        onPressed: {
            lastMouseX = mouseX
            lastMouseY = mouseY
        }
        onMouseXChanged: root.x += (mouseX - lastMouseX)
        onMouseYChanged: root.y += (mouseY - lastMouseY)
    }

    Row {
        anchors.fill: parent
        spacing: 5
        layoutDirection: Qt.RightToLeft
        rightPadding: 10

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 30
            height: 30
            border.color: "white"
            border.width: 2
            color: "transparent"

            Rectangle {
                width: 15
                height: 2
                anchors.centerIn: parent
                color: "black"
                rotation: 45
            }
            Rectangle {
                width: 15
                height: 2
                anchors.centerIn: parent
                color: "black"
                rotation: -45
            }
            MouseArea {
                anchors.fill: parent
                onClicked: Qt.quit()
            }
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 30
            height: 30
            border.color: "white"
            border.width: 2
            color: "transparent"

            Rectangle {
                width: 15
                height: 15
                anchors.centerIn: parent
                border.color: "black"
                border.width: 2
                color: "transparent"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: root.visibility = Window.FullScreen
            }
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 30
            height: 30
            border.color: "white"
            border.width: 2
            color: "transparent"

            Rectangle {
                width: 15
                height: 2
                anchors.centerIn: parent
                color: "black"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root.visibility = Window.Minimized
            }
        }

        Button {
            anchors.verticalCenter: parent.verticalCenter
            text: "test"
        }
    }
}
