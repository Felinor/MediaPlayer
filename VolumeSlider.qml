import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.settings 1.0
import "helper.js" as Helper

Slider {
    id: seekSlider

//    Settings {
//        category: "Volume"
//        property alias volume: seekSlider.value
//    }
//    Component.onCompleted: dataModel.applyVolume(seekSlider.valueAt(position))

    from: 0
    to: 100
    value: 100
    onMoved: {
        console.log(value, "<-- Volume position")
//        console.log(valueAt(position), "value")
//        dataModel.applyVolume(valueAt(position))
        dataModel.applyVolume(value)
    }

    ToolTip {
        id: toolTip
        parent: seekSlider.handle
        visible: seekSlider.pressed
        text: seekSlider.value.toFixed(0)
        y: parent.height
    }
}
