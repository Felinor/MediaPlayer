import QtQuick 2.15
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

TableView {
    id: tableView
    clip: true
    alternatingRowColors: false
    backgroundVisible: false

    TableViewColumn {
        id: column_0
        width: tableView.viewport.width / (tableView.columnCount * 2)
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
    }
}
