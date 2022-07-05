import QtQuick 2.15
import QtQuick.Controls 2.15
import "helper.js" as Helper

Slider {
    id: seekSlider

    from: 0
    to: dataModel.duration
    value: dataModel.position
    onMoved: {
        console.log(value, "Position")
//        console.log(valueAt(position), "value")
        dataModel.setMediaPosition(valueAt(position))
    }

    ToolTip {
        id: toolTip
        parent: seekSlider.handle
        visible: seekSlider.pressed
        text: Helper.prependZero(Math.floor(value / 60)) + ":" + Helper.prependZero(Math.floor(value % 60))
        y: parent.height

        readonly property int value: seekSlider.valueAt(seekSlider.position)
    }
}
