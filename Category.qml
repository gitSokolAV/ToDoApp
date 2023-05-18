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
            dynamicRoles: true
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
                newColorDialog.open()
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
                title: "Please choose a color"
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

                var newColor = newColorDialog.selectedColor
                var categoryText = categoryNameInput.text.trim()
                if (categoryText !== "") {

                    var categoryRect = categoryRectComponent.createObject(parent, {"categoryText": categoryText, "index": categories.length, "colorRect": newColor})
                    categoryRect.x = Math.random() * (parent.width - categoryRect.width)
                    categoryRect.y = Math.random() * (parent.height - categoryRect.height)
                    categories.push({"text": categoryText, "x": categoryRect.x, "y": categoryRect.y, "color": newColor})
                    categoriesModel.append({"text": categoryText});

                }

            }
            ColorDialog{
                id: newColorDialog
                title: "Select a color for the category"
                onAccepted: {
                    return newColorDialog.selectedColor
                }
            }
        }


        Component {
            id: categoryRectComponent
            Rectangle {
                property string categoryText: ""
                property var toDoList
                property int index
                property color colorRect

                width: categoryText.length * 10
                height: 50
                color: colorRect
                radius: 10
                Text {
                    text: categoryText
                    color: colorYellow
                    anchors.centerIn: parent
                }
                MouseArea {
                    property int clickedIndex: -1
                    id: mouseArea
                    anchors.fill: parent
                    drag.target: parent
                    drag.axis: Drag.XAndYAxis
                    drag.minimumX: 0
                    drag.maximumX: parent.parent.width - parent.width
                    drag.minimumY: 0
                    drag.maximumY: parent.parent.height - parent.height

                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onDoubleClicked: {
                        var toDoListInstance = Qt.createComponent("ToDoList.qml")
                        toDoListInstance.category = categoryText
                        stackView.push(toDoListInstance)
                    }

                    //onPressed: {
                    //    color = colorLightGray
                    //}
//
                    //onReleased: {
                    //    color = colorPurple
                    //}

                    onClicked: {
                        if (mouse.button === Qt.RightButton) {
                            clickedIndex = index
                            menuPopUp.popup();
                        }
                    }

                    Menu{
                        id: menuPopUp
                        MenuItem{
                            text: "Delete"
                            onTriggered: {
                                var index = mouseArea.clickedIndex;
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
                        colorDialog2.open();
                    }
                }
                Dialog {
                    id: colorDialog2

                    title: "Select Color"
                    standardButtons: Dialog.Ok | Dialog.Cancel
                    Button {
                        text: "Color"
                        onClicked: {
                            colorDialogOpen.open();
                        }
                    }
                    ColorDialog{
                        id: colorDialogOpen
                        onAccepted: {
                            var rect1 = mouseArea.clickedIndex;
                            var rect2 = categoryComboBox.currentIndex;
                            var newColor = colorDialogOpen.selectedColor
                            //categoriesModel.setProperty(rect1, "colorRect", newColor);
                            //categoriesModel.setProperty(rect2, "colorRect", newColor);
                            //categories[rect2].colorRect = newColor
                            //colorRect = newColor
                            console.log("color categories rect1 " + " name "+ categories[rect1].text + ": "  + categories[rect1].color.toString())
                            console.log("color categories rect2 " + " name "+ categories[rect2].text + ": "  + categories[rect2].color.toString())
                            categoryRectComponent[rect1].colorRect = newColor
                            categoryRectComponent[rect2].colorRect = newColor
                            categories[rect2].color = newColor
                            categoriesModel.modelReset()

                            console.log("color categories rect1 " + " name "+ categories[rect1].text + ": "  + categories[rect1].color.toString())
                            console.log("color categories rect2 " + " name "+ categories[rect2].text + ": "  + categories[rect2].color.toString())
                            colorRect = newColor

                        }
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
