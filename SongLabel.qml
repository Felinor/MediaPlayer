import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: songLabelContainer

    property alias songLabel: songNameLabel

    clip: true
    border.color: "red"
//                            border.width: 2

//                            Layout.fillWidth: true
//    Layout.preferredWidth: songNameLabel.width / 2
//    Layout.preferredHeight: songNameLabel.implicitHeight
//    Layout.alignment: Qt.AlignCenter
//    Layout.topMargin: 10

    SequentialAnimation {
        id: songNameLabelAnimation
        running: true
        loops: Animation.Infinite

        PauseAnimation {
            duration: 2000
        }
        ParallelAnimation {
            XAnimator {
                target: songNameLabel
                from: 0
                to: songLabelContainer.width - songNameLabel.implicitWidth
                duration: 5000
            }
            OpacityAnimator {
                target: leftGradient
                from: 0
                to: 1
            }
        }
        OpacityAnimator {
            target: rightGradient
            from: 1
            to: 0
        }
        PauseAnimation {
            duration: 1000
        }
        OpacityAnimator {
            target: rightGradient
            from: 0
            to: 1
        }
        ParallelAnimation {
            XAnimator {
                target: songNameLabel
                from: songLabelContainer.width - songNameLabel.implicitWidth
                to: 0
                duration: 5000
            }
            OpacityAnimator {
                target: leftGradient
                from: 0
                to: 1
            }
        }
        OpacityAnimator {
            target: leftGradient
            from: 1
            to: 0
        }
    }

    Rectangle {
        id: leftGradient
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#dfe4ea"
            }
            GradientStop {
                position: 1
                color: "#00dfe4ea"
            }
        }

        width: height
        height: parent.height
        anchors.left: parent.left
        z: 1
        rotation: -90
        opacity: 0
    }

    Label {
        id: songNameLabel
        onTextChanged: songNameLabelAnimation.restart()
        font.pixelSize: Qt.application.font.pixelSize * 1.4
    }

    Rectangle {
        id: rightGradient
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#00dfe4ea"
            }
            GradientStop {
                position: 1
                color: "#dfe4ea"
            }
        }

        width: height
        height: parent.height
        anchors.right: parent.right
        rotation: -90
    }
}
