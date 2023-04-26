import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs

Page {
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias buttonText: navButton.text
    property var categories: []
    signal buttonClicked();


    background: Rectangle{
        id: backgroundRect
    }


        Button {
            id: addButton
            text: "Add Category"
            anchors.centerIn: parent
            onClicked: {
                categoryDialog.open()
            }
        }

        Dialog {
            id: categoryDialog
            title: "Enter Category Name"
            anchors.centerIn: parent
            standardButtons: Dialog.Ok | Dialog.Cancel
            TextField {
                id: categoryNameInput
                placeholderText: "Category Name"
            }
            onAccepted: {
                var categoryText = categoryNameInput.text.trim()
                if (categoryText !== "") {
                    var categoryRect = categoryRectComponent.createObject(parent, {"categoryText": categoryText})
                    categoryRect.x = Math.random() * (parent.width - categoryRect.width)
                    categoryRect.y = Math.random() * (parent.height - categoryRect.height)
                    categories.push({"text": categoryText, "x": categoryRect.x, "y": categoryRect.y})
                }
            }
        }

        Component {
            id: categoryRectComponent
            Rectangle {
                property string categoryText: ""
                property var toDoList

                width: categoryText.length * 10
                height: 50
                color: colorPurple
                radius: 10
                Text {
                    text: categoryText
                    color: colorYellow
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    drag.target: parent
                    drag.axis: Drag.XAndYAxis
                    drag.minimumX: 0
                    drag.maximumX: parent.parent.width - parent.width
                    drag.minimumY: 0
                    drag.maximumY: parent.parent.height - parent.height

                    property bool selected: false
                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onDoubleClicked: {
                        var toDoListInstance = Qt.createComponent("ToDoList.qml")
                        toDoListInstance.category = categoryText
                        stackView.push(toDoListInstance)
                    }

                    onPressed: {
                        selected = true
                        color = colorLightGray
                    }

                    onReleased: {
                        selected = false
                        color = colorPurple
                    }

                    onClicked: {
                        if (mouse.button === Qt.RightButton) {
                            menuPopUp.popup();
                        }
                    }
                    Menu{
                        id: menuPopUp
                        MenuItem{
                            text: "Delete"
                        }
                        MenuItem{
                            text: "Rename"
                        }
                    }
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
