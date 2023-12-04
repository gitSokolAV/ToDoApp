import QtQuick

GridView{
    id: root

    model:  15
    cellWidth: width / 4
    cellHeight: height / 4
    delegate: Tile{
        width: root.cellWidth
        height: root.cellHeight
    }
}
