import QtQuick
import QtQuick.Window
import QtQuick.Controls

Page {
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias buttonText: navButton.text

    signal buttonClicked();


    background: Rectangle{
        id: backgroundRect
    }

    ListModel{
        id:listModel
    }

    Item{
        StackView{
            id: stackView
            anchors.fill: parent
            initialItem: mainWindow
        }
        anchors.fill: parent
        Rectangle{
            id: leftRect
            width: parent.width / 2
            height: parent.height
            anchors.left: parent.left

            }

            ListView{

                id: listView
                model: listModel
                spacing: 10
                anchors.fill: leftRect
                delegate: Rectangle{
                    id:delegateRect
                    width: 100
                    height: 100
                    color: "red"


                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            Loader.source = "ToDoList.qml"
                        }
                    }
                }

            }
        }
        Rectangle{
            width: parent.width / 2
            height: parent.height
            anchors.right: parent.right
            color: "green"

            Button{
                text: "AAD"
                onClicked: {
                    listModel.append(ToDoList)
                }
        }
    }


    Button{
        id: navButton
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        onClicked: {
            root.buttonClicked();
        }
    }

}
