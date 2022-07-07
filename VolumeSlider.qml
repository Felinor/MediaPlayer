import QtQuick 2.15
import QtQuick.Controls 2.15
import "helper.js" as Helper

Slider {
    id: seekSlider

    from: 0
    to: 100
    value: 100
    onMoved: {
        console.log(value, "<-- Volume position")
//        console.log(valueAt(position), "value")
        dataModel.applyVolume(valueAt(position))
    }

    ToolTip {
        id: toolTip
        parent: seekSlider.handle
        visible: seekSlider.pressed
        text: seekSlider.value.toFixed(0)
        y: parent.height
    }
}
