import QtQuick 2.15
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

TableView {
    id: tableView
    clip: true
    alternatingRowColors: false
    backgroundVisible: false
    onWidthChanged: resizeColumns()

    function resizeColumns() {
        tableView.resizeColumnsToContents()
        column_4.width = tableView.contentItem.width -
                (column_1.width + column_2.width + column_3.width)
    }

    TableViewColumn {
        id: column_0
        width: tableView.contentItem.width / (tableView.columnCount * 2)
        title: "#"
        role: ""
    }

    TableViewColumn {
        id: column_1
        width: tableView.contentItem.width / (tableView.columnCount -1)
        title: "TITLE"
        role: "title"
    }

    TableViewColumn {
        id: column_2
        width: tableView.contentItem.width / (tableView.columnCount -1)
        title: "ARTIST"
        role: "artist"
    }

    TableViewColumn {
        id: column_3
        width: tableView.contentItem.width / (tableView.columnCount +2)
        title: "TIME"
        role: "time"
    }

    TableViewColumn {
        id: column_4
        title: "ALBUM"
        role: "album"
    }

    style: TableViewStyle {
        headerDelegate: HeaderDelegateCustom {}
        itemDelegate: ItemDelegateCustom {}
        rowDelegate: RowDelegateCustom {}
    }
}
