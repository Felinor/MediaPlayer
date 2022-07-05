import QtQuick 2.15
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

TableView {
    id: tableView
    clip: true
    alternatingRowColors: false
    backgroundVisible: false
//    verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
//    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

    TableViewColumn {
        id: column_0
        width: tableView.viewport.width / (tableView.columnCount * 2)
        movable: false
        title: "#"
        role: ""
    }

    TableViewColumn {
        id: column_1
        width: tableView.viewport.width / tableView.columnCount
        title: "TITLE"
        role: "title"
    }

    TableViewColumn {
        id: column_2
        width: tableView.viewport.width / tableView.columnCount
        title: "ARTIST"
        role: "artist"
    }

    TableViewColumn {
        id: column_3
        width: tableView.viewport.width / tableView.columnCount
        title: "TIME"
        role: "time"
    }

    TableViewColumn {
        id: column_4
        width: tableView.viewport.width - column_0.width - column_1.width - column_2.width - column_3.width
        title: "ALBUM"
        role: "album"
    }

    style: TableViewStyle {
        headerDelegate: HeaderDelegateCustom {}
        itemDelegate: ItemDelegateCustom {}
        rowDelegate: RowDelegateCustom {}

//        handle: Rectangle {
//            implicitWidth: 14
//            implicitHeight: 26
//            Rectangle {
//                color: "red"
//                anchors.fill: parent
//                anchors.topMargin: 6
//                anchors.leftMargin: 4
//                anchors.rightMargin: 4
//                anchors.bottomMargin: 6
//                radius: 5
//            }
//        }
//        scrollBarBackground: Item {
//            implicitWidth: 14
//            implicitHeight: 26
//        }
    }
}
