import QtQuick
import QtQuick.Window
import QtQuick.Controls
Window{
    width: 1000
    height: 700
    visible: true
    title: "Hello"
    StackView{
        id: stackView
        anchors.fill: parent
        initialItem: mainWindow
    }

    Rectangle {
        id: mainWindow
        anchors.fill: parent
        color: "#2D2727"
        Rectangle{
            id: appMenu
            anchors.fill: parent
            anchors.margins: 15
            color: "#413543"
            border.color: "#8F43EE"
            border.width: 1

            Rectangle{
                id: buttonTodo
                height: 50
                width: 300
                color: "#8F43EE"
                border.width: 1
                anchors.centerIn: parent
                Text{
                    text: "To Do App"
                    color: "#413543"
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

        ToDoList{
            id: pageToDoList
            backgroundColor: "#2D2727"
            visible: false
            buttonText: "Back"
            onButtonClicked: {
                stackView.pop()
            }
        }
    }
}

