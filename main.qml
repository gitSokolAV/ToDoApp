import QtQuick
import QtQuick.Window
import QtQuick.Controls
Window{
    width: 1000
    height: 700
    visible: true
    title: "Hello"
    property color colorDarkGray: "#2D2727"
    property color colorLightGray: "#413543"
    property color colorPurple: "#8F43EE"
    property color colorYellow: "#F0EB8D"

    StackView{
        id: stackView
        anchors.fill: parent
        initialItem: mainWindow
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
                        stackView.push(pageToDoList)
                    }
                }
            }
        }
        //Return to menu
        ToDoList{
            id: pageToDoList
            backgroundColor: colorDarkGray
            visible: false
            buttonText: "Back"
            onButtonClicked: {
                stackView.pop()
            }
        }
    }
}

