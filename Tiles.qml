import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import QtQml
import Game
Page {
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias buttonText: textNavButton.text
    property int sizeBoard: 2

    signal buttonClicked();

    background: Rectangle{
        id: backgroundRect
    }    

    Rectangle{
        id: gameBoard
        width: root.width / 3
        height: root.height / 2
        visible: true
        anchors.centerIn: parent
        clip: true
        GameBoard{
            anchors.fill: parent

        }
    }

    Rectangle{
        id: navButton
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.margins: 10
        color: "Red"
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
