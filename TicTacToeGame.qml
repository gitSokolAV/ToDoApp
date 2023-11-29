import QtQuick
import QtQuick.Controls
import TicTacToeGame


Page {
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias buttonText: textNavButton.text

    signal buttonClicked();   

    background: Rectangle{
        id: backgroundRect
    }
    TicTacToe {
        id: gameModel
        onGameEnded: {
            if (winner === "")
                statusLabel.text = "It's a draw!";
            else
                statusLabel.text = "Player " + winner + " wins!";
        }
    }
    Rectangle{
        id: mainRectangle
        width: parent.width / 3
        height: parent.height / 2
        anchors.centerIn: parent

        Grid{
            id: gameGrid
            columns: 3
            rows: 3
            anchors.centerIn: parent
            Repeater{
                model: 9
                Rectangle {
                    width: gameGrid.width / 3
                    height: gameGrid.height / 3
                    color: "red"
                    border.width: 2
                    border.color: "black"

                    Text {
                        id: cellText
                        anchors.centerIn: parent
                        font.pixelSize: 24
                        text: gameModel.getCellValue(Math.floor(index / 3), index % 3)

                        MouseArea {
                            anchors.fill: parent
                            onClicked: gameModel.makeMove(Math.floor(index / 3), index % 3)
                        }
                    }
                }
            }
        }


    }



    Rectangle{
        id: navButton
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.margins: 10
        color: "White"
        radius: 10
        height: 50
        width: textNavButton.width + 20

        TextArea{
            id: textNavButton
            text: ""
            anchors.centerIn: parent
            font.pixelSize: 16
            color: backgroundColor
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                root.buttonClicked();
            }
        }
    }
}