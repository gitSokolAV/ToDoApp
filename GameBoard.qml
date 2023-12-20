import QtQuick
import Game

GridView{
    id: root

    model:  GameBoardModel{

    }
    cellWidth: width / root.model.dimension
    cellHeight: height / root.model.dimension
    delegate: Item{
        id: backgroundDelegate
        width: root.cellWidth
        height: root.cellHeight
        visible: display != root.model.hiddenElementValue

        Tile{
            anchors.fill: backgroundDelegate
            anchors.margins: 5
            displayText: display
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    root.model.move(index)
                }
            }
        }
    }
}
