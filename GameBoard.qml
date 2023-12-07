import QtQuick
import Game

GridView{
    id: root

    model:  GameBoardModel{

    }

    cellWidth: width / 4
    cellHeight: height / 4
    delegate: Item{
        id: backgroundDelegate
        width: root.cellWidth
        height: root.cellHeight
        visible: display != 16
        Tile{
            anchors.fill: backgroundDelegate
            anchors.margins: 5
            displayText: display
        }
    }
}
