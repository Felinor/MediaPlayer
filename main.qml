import QtQuick 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.15
import MediaModel 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    property int itemAngle: 30
    property int itemSize: 150

    MediaModel {
        id: dataModel
    }

    Row {
        anchors.bottom: parent.bottom
        Image {
            id: playButton
            source: "qrc:/images/play.png"
            width: 50; height: width
            mipmap: true

            MouseArea {
                anchors.fill: parent
                onClicked: console.log("Play Button Clicked!")
            }
        }
        Image {
            source: "qrc:/images/stop.png"
            width: 50; height: width
            mipmap: true
        }
        Image {
            source: "qrc:/images/add.png"
            width: 50; height: width
            mipmap: true
        }
        RoundButton {
            icon.name: "favorite"
            icon.width: 32
            icon.height: 32
        }
        RoundButton {
            icon.name: "shuffle"
            icon.width: 32
            icon.height: 32
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height - 100
        border.color: "gray"
        border.width: 1

    PathView {
        id: view

        anchors.fill: parent
        model: dataModel
        pathItemCount: 6

        path: Path {
            startX: 0
            startY: height / 2

            PathPercent { value: 0.0 }
            PathAttribute { name: "z"; value: 0 }
            PathAttribute { name: "angle"; value: itemAngle }
            PathAttribute { name: "origin"; value: 0 }
            PathLine {
                x: (view.width - itemSize) / 2
                y: view.height / 2
            }
            PathAttribute { name: "angle"; value: itemAngle }
            PathAttribute { name: "origin"; value: 0 }
            PathPercent { value: 0.49 }
            PathAttribute { name: "z"; value: 10 }

            PathLine { relativeX: 0; relativeY: 0 }

            PathAttribute { name: "angle"; value: 0 }
            PathLine {
                x: (view.width - itemSize) / 2 + itemSize
                y: view.height / 2
            }
            PathAttribute { name: "angle"; value: 0 }
            PathPercent { value: 0.51 }

            PathLine { relativeX: 0; relativeY: 0 }

            PathAttribute { name: "z"; value: 10 }
            PathAttribute { name: "angle"; value: -itemAngle }
            PathAttribute { name: "origin"; value: itemSize }
            PathLine {
                x: view.width
                y: view.height / 2
            }
            PathPercent { value: 1 }
            PathAttribute { name: "z"; value: 0 }
            PathAttribute { name: "angle"; value: -itemAngle }
            PathAttribute { name: "origin"; value: itemSize }
        }

        delegate: Rectangle {
            property real rotationAngle: PathView.angle
            property real rotationOrigin: PathView.origin

            width: itemSize
            height: width
            z: PathView.z
            color: model.color
            radius: 15
            clip: true
            border {
                color: "black"
                width: 1
            }
            transform: Rotation {
                id: rotation
                axis { x: 0; y: 1; z: 0 }
                angle: rotationAngle
                origin.x: rotationOrigin
            }

            Text {
                anchors.fill: parent
                font.pointSize: 16
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: model.text !== undefined ? model.text : model.name + "\n"+ model.track
            }

            MouseArea {
                anchors.fill: parent
                onClicked: console.log("Clicked", index)
            }
        }
    }
}
}
