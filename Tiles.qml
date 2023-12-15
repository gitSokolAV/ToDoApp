import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import QtQml

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
        id: gameBoardSize
        width: root.width / 3
        height: root.height / 2
        visible: true
        anchors.centerIn: parent
        Text{
            id: titleText
            font.pixelSize: parent.width / 8
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            text: "Board Size"
        }
        Rectangle{
            id: positiveBtn
            anchors.left: sizeLabel.right
            anchors.verticalCenter: parent.verticalCenter
            width: 100
            height: 100
            color: colorYellow
            radius: 50
            Text{
                font.pixelSize: parent.width / 4
                font.bold: true
                text: "+"
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    sizeBoard += 1
                }
            }
        }
        Rectangle{
            id: sizeLabel
            width: 200
            height: 200
            color: colorYellow
            radius: 50
            anchors.centerIn: parent
            Text{
                font.pixelSize: parent.width / 4
                font.bold: true
                text: sizeBoard
                anchors.centerIn: parent
            }
        }
        Rectangle{
            id: negativeBtn
            anchors.right: sizeLabel.left
            anchors.verticalCenter: parent.verticalCenter
            width: 100
            height: 100
            color: colorYellow
            radius: 50
            Text{
                font.pixelSize: parent.width / 4
                font.bold: true
                text: "-"
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(sizeBoard >= 2){
                        sizeBoard -= 1
                    }

                }
            }
        }


    }

    Rectangle{
        id: gameBoard
        width: root.width / 3
        height: root.height / 2
        visible: false
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
