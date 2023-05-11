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
        Button {
            id: colorButton
            text: "Change Color"
            anchors.right: addButton.left
            anchors.bottom: parent.bottom
            anchors.margins: 10
            onClicked: {
                colorDialog.open()
            }
            ColorDialog{
                id: colorDialog
                title: "please choose a color"
                onAccepted: {
                    backgroundColor = colorDialog.selectedColor
                }
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
                    categories.push({"text": categoryText, "x": categoryRect.x, "y": categoryRect.y, })
                    categoriesModel.append({"text": categoryText});
                    console.log(categories.length)
                }
            }
        }


        Component {
            id: categoryRectComponent
            Rectangle {
                property string categoryText: ""
                property var toDoList
                property int index

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
                    property int index: categories.indexOf(objectName)
                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onDoubleClicked: {
                        var toDoListInstance = Qt.createComponent("ToDoList.qml")
                        toDoListInstance.category = categoryText
                        stackView.push(toDoListInstance)
                    }

                    onPressed: {
                        color = colorLightGray
                    }

                    onReleased: {
                        color = colorPurple
                    }

                    onClicked: {
                        if (mouse.button === Qt.RightButton) {
                            console.log(index)
                            menuPopUp.popup();                            
                        }
                    }

                    Menu{
                        id: menuPopUp
                        MenuItem{
                            text: "Delete"
                            onTriggered: {
                                var index = mouseArea.index;
                                console.log(index)
                                categoriesModel.remove(index, 1);
                                categories.splice(index, 1);
                                mouseArea.parent.destroy();
                                categoryComboBox.model = categoriesModel;
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
                    onAccepted: {
                        var rect1 = categories.indexOf(objectName)
                        var rect2 = categoryComboBox.currentText
                        console.log(rect1)
                        console.log(rect2)
                        //colorDialog.open();
                    }

                }
                //Dialog {
                //    id: colorDialog
                //    title: "Select Color"
                //    standardButtons: Dialog.Ok | Dialog.Cancel
                //    Button {
                //        text: "Color"
                //        onClicked: {
                //            colorDialogOpen.open();
                //        }
                //    }
                //    ColorDialog{
                //        id: colorDialogOpen
                //        onAccepted: {
                //        }
                //    }
                //}

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
                        id: categoryNameInputRename
                        text: categoryText
                        placeholderText: "Category Name"
                    }
                    onAccepted: {
                        var newCategoryText = categoryNameInputRename.text.trim();
                        if (newCategoryText !== "" && newCategoryText !== categoryText) {
                            // Обновляем элементы в массиве категорий
                            categoriesModel.setProperty(index, "text", newCategoryText);
                            categoryText = newCategoryText;
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
