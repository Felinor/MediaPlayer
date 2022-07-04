import QtQuick 2.15
import QtQuick.Controls 2.15

ItemDelegate  {
    //    "#26B281"  красивый зеленый градиент  "#23B7B5" сине-зеленый градиент
    //    "#007D50"                             "#247489"

    Gradient {
        id: currentRowGradient
        GradientStop { position: 0; color: "#26B281" }
        GradientStop { position: 0.5; color: "#007D50" }
    }

    Gradient {
        id: headerGradient
        GradientStop { position: 0; color: "#23B7B5" }
        GradientStop { position: 0.5; color: "#247489" }
    }        

    height: textHeader.implicitHeight * 1.5
    clip: true

    background: Rectangle {
        id: backgroundRect
        gradient: styleData.containsMouse ? currentRowGradient : headerGradient
    }
    contentItem: Text {
        id: textHeader
        verticalAlignment: Text.AlignVCenter
        text: styleData.value
        elide: Text.ElideRight
        color: "white"
        renderType: Text.NativeRendering
        font {
            family : "Avenir Heavy"
            letterSpacing: 1
            preferShaping: false
            weight: Font.Medium
            pointSize: 17
        }
    }
}
