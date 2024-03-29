import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQml


Window{
    //width: 1000
    //height: 700
    visibility: Window.FullScreen
    visible: true
    title: "Bubble app"
    property color colorDarkGray: "#2D2727"
    property color colorLightGray: "#413543"
    property color colorPurple: "#8F43EE"
    property color colorYellow: "#F0EB8D"

    StackView{
        id: stackView
        anchors.fill: parent
        initialItem: mainWindow
    }
    ListModel{
        id: categoryListModel
    }    


    Rectangle {
        id: mainWindow
        anchors.fill: parent
        color: colorDarkGray
        Rectangle{
            id: appMenu
            anchors.fill: parent
            anchors.margins: 15
            color: colorLightGray
            border.color: colorPurple
            border.width: 1

            Rectangle{
                id: buttonTodo
                height: 50
                width: 300
                color: colorPurple
                border.width: 1
                anchors.centerIn: parent

                Text{
                    text: "To Do App"
                    color: colorLightGray
                    font.pixelSize: 20
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        stackView.push(pageCategory)
                    }
                }
            }
            Rectangle{
                id: buttonFocusClock
                height: 50
                width: 300
                color: colorPurple
                border.width: 1

                anchors.top: buttonTodo.bottom
                anchors.left: buttonTodo.left
                anchors.right: buttonTodo.right
                anchors.topMargin: 50                

                Text{
                    text: "Focus Clock"
                    color: colorLightGray
                    font.pixelSize: 20
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        stackView.push(pageFoculClock)
                    }
                }
            }
            Rectangle{
                id: buttonTiles
                height: 50
                width: 300
                color: colorPurple
                border.width: 1

                anchors.top: buttonFocusClock.bottom
                anchors.left: buttonFocusClock.left
                anchors.right: buttonFocusClock.right
                anchors.topMargin: 50

                Text{
                    text: "Tiles"
                    color: colorLightGray
                    font.pixelSize: 20
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        stackView.push(pageTiles)
                    }
                }
            }
        }
        Category{
            id: pageCategory
            backgroundColor: colorPurple
            visible: false
            buttonText: "Back"
            onButtonClicked: {
                stackView.pop()
            }
        }
        FocusClock{
            id: pageFoculClock
            backgroundColor: colorPurple
            visible: false
            buttonText: "Back"
            onButtonClicked: {
                stackView.pop()
            }
        }
        Tiles{
            id: pageTiles
            backgroundColor: colorPurple
            visible: false
            buttonText: "Back"
            onButtonClicked: {
                stackView.pop()
            }
        }


    }
}

