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
    ListModel {
        id: categoriesModel
    }


    background: Rectangle{
        id: backgroundRect
    }
        Button {
            id: addButton
            text: "Add Category"
            anchors.right: navButton.left
            anchors.bottom: parent.bottom
            anchors.margins: 10
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
                    var categoryRect = categoryRectComponent.createObject(parent, {"categoryText": categoryText, "index": categories.length})
                    categoryRect.x = Math.random() * (parent.width - categoryRect.width)
                    categoryRect.y = Math.random() * (parent.height - categoryRect.height)
                    categories.push({"text": categoryText, "x": categoryRect.x, "y": categoryRect.y})
                    categoriesModel.append({"text": categoryText});
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
                    id: mouseArea
                    anchors.fill: parent
                    drag.target: parent
                    drag.axis: Drag.XAndYAxis
                    drag.minimumX: 0
                    drag.maximumX: parent.parent.width - parent.width
                    drag.minimumY: 0
                    drag.maximumY: parent.parent.height - parent.height

                    property bool selected: false
                    property int index: -1
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
                        selected = !selected;
                        if (selected) {
                            color = colorLightGray;
                        } else {
                            color = colorPurple;
                        }
                    }

                    Menu{
                        id: menuPopUp
                        MenuItem{
                            text: "Delete"
                            onTriggered: {
                                categories.splice(mouseArea.index, 1);
                                mouseArea.parent.destroy();
                            }
                        }
                        MenuItem{
                            text: "Rename"
                            onClicked: {
                                renameDialog.open();
                            }
                        }
                        MenuItem{
                            text: "Show Date"
                            onTriggered: {
                                dateDialog.open();
                            }
                        }
                        MenuItem {
                            text: "Connect"
                            onClicked: {
                                connectDialog.open()
                            }
                        }
                    }
                }
                Dialog {
                    id: connectDialog
                    title: "Connect to Category"
                    standardButtons: Dialog.Ok | Dialog.Cancel
                    ComboBox {
                        id: categoryComboBox
                        model: categoriesModel
                        textRole: "text"
                        anchors.fill: parent
                    }
                }
                Dialog {
                    id: dateDialog
                    title: "Category Creation Date"
                    standardButtons: Dialog.Ok
                    Text {
                        text: "Category \"" + categoryText + "\" was created on " + new Date().toLocaleDateString()
                        color: "black"
                        font.bold: true
                    }
                }

                Dialog {
                    id: renameDialog
                    title: "Rename Category"
                    anchors.centerIn: parent
                    standardButtons: Dialog.Ok | Dialog.Cancel
                    TextField {
                        id: categoryNameInput
                        text: categoryText
                        placeholderText: "Category Name"
                    }
                    onAccepted: {
                        var newCategoryText = categoryNameInput.text.trim();
                        if (newCategoryText !== "" && newCategoryText !== categoryText) {
                            categoryText = newCategoryText;
                            // Обновляем элементы в массиве категорий
                            for (var i = 0; i < categories.length; i++) {
                                if (categories[i].text === categoryText) {
                                    categories[i].text = newCategoryText;
                                    break;
                                }
                            }
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
