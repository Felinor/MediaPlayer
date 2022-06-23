import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id: delegateItem
    clip: true

    Item {
        anchors.fill: parent
        anchors.margins: 15

        Text {
            width: parent.width
            text: styleData.column === 0 ? styleData.row + 1 : styleData.value
            elide: Text.ElideRight
            color: "white"
            font {
                pointSize: delegateItem.height * 0.32
                family: "Avenir Heavy"
                wordSpacing: 1
            }
        }
    }
}

