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
    Rectangle{
        id: mainRectangle
        width: parent.width /2
        height: parent.height /2
        anchors.centerIn: parent
        color: colorYellow
        TicTacToeGame{
            id: game
            onGameEnded: {
                if(winner != ""){
                    console.log("Player" + winner + " wins!")
                }
                else{
                    console.log("It's a draw.")
                }
            }

        }
        Grid{
            rows: 3
            columns: 3
            anchors.left: mainRectangle.left
            anchors.top: mainRectangle.top
            anchors.right: mainRectangle.right
            anchors.bottom: mainRectangle.bottom

            Repeater{
                model: 3 * 3

                Button{
                    text: game.getCellValue(index / 3, index % 3)
                    onClicked: game.makeMove(index /3, index % 3)
                }
            }
        }
        Button{
            text: "Reset Game"
            onClicked: game.resetGame()
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
