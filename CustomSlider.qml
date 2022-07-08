import QtQuick 2.15
import QtQuick.Controls 2.15
import "helper.js" as Helper

Slider {
    id: seekSlider

    from: 0
    to: dataModel.duration / 1000
    value: dataModel.position / 1000
    snapMode: Slider.SnapOnRelease
    onMoved: {
        dataModel.setMediaPosition(valueAt(position*1000))
        console.log(value, "<-- Slider position")
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
