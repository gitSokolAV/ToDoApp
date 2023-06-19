import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Shapes

Page {
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias buttonText: navButton.text
    signal buttonClicked();        

        ListModel {
            id: categoriesModel
            dynamicRoles: true
        }
        background: Rectangle{
            id: backgroundRect
        }
        Button {
            id: addCategoryButton
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
            id: backgroundChangeColorButton
            text: "Change Color"
            anchors.right: addCategoryButton.left
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
                var setCategoryColor = newColorDialog.selectedColor
                var setCategoryName = categoryNameInput.text.trim()
                var setCategoryIndex = categoriesModel.count
                var setTextConnectLabel = ""
                var setBoolConnectLabel = false
                var setPositionX = Math.random() * (root.width)
                var setPositionY = Math.random() * (root.height)

                if(setCategoryName !== ""){
                    categoriesModel.append({
                                               "categoryName": setCategoryName,
                                               "categoryColor": setCategoryColor,
                                               "categoryIndex": setCategoryIndex,
                                               "textConnectLabel": setTextConnectLabel,
                                               "boolConnectLabel": setBoolConnectLabel,
                                               "positionX": setPositionX,
                                               "positionY": setPositionY
                                           })
                var newCategory =  categoryRectComponent.createObject(root);
                    newCategory.categoryName = categoriesModel.get(setCategoryIndex).categoryName
                    newCategory.categoryColor = categoriesModel.get(setCategoryIndex).categoryColor
                    newCategory.categoryIndex = categoriesModel.get(setCategoryIndex).categoryIndex
                    newCategory.textConnectLabel = categoriesModel.get(setCategoryIndex).textConnectLabel
                    newCategory.boolConnectLabel = categoriesModel.get(setCategoryIndex).boolConnectLabel
                    newCategory.x = categoriesModel.get(setCategoryIndex).positionX
                    newCategory.y = categoriesModel.get(setCategoryIndex).positionY

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
        Shape{
          id: connectLine
          width: root.width
          height: root.height
          property double startPositionLineX: 0
          property double startPositionLineY: 0
          property double endPositionLineX: 0
          property double endPositionLineY: 0
          property real lineAngle: 0

          anchors.centerIn: parent
          visible: false
          ShapePath{
                id: connectLineShape
                strokeColor: "black"
                strokeWidth: 4
                strokeStyle: ShapePath.SolidLine
                startX: connectLine.startPositionLineX
                startY: connectLine.startPositionLineY
                PathLine {
                    id: pathLine
                    x: connectLine.endPositionLineX
                    y: connectLine.endPositionLineY
                }
            }
          Text {
              id: centerText
              text: "Enter name line"
              color: "black"
              font.bold: true
              font.pixelSize: 26
              anchors.bottom: connectLineShape.top
              rotation: connectLine.lineAngle
              x: (connectLine.startPositionLineX + connectLine.endPositionLineX) / 2 - width / 2
              y: (connectLine.startPositionLineY + connectLine.endPositionLineY) / 2 - height / 2
              z: 1
              MouseArea{
                  id: centerTextMouseArea
                  anchors.fill: parent
                  onDoubleClicked: {
                      textLineDialog.open()
                  }
              }
          }

            onWidthChanged: {
                connectLineShape.startX = width / 2;
            }

            onHeightChanged: {
                connectLineShape.startY = height / 2;
            }
        }


        Component {
            id: categoryRectComponent            
            Rectangle {
                property string categoryName: ""
                property color categoryColor
                property var toDoList
                property int categoryIndex
                property var textConnectLabel
                property var boolConnectLabel
                property var positionX
                property var positionY
                //width: categoryName.length * 20
                width: 300
                height: 50
                color: categoriesModel.get(categoryIndex).categoryColor
                radius: 10

                Text {                    
                    text: categoryName
                    font.pixelSize: 20
                    color: colorYellow
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Label{
                    id: connectLabel
                    text: "Connected with " + categoriesModel.get(categoryIndex).textConnectLabel
                    anchors.bottom: parent.bottom
                    visible: categoriesModel.get(categoryIndex).boolConnectLabel
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
                        toDoListInstance.category = categoryName
                        stackView.push(toDoListInstance)
                    }
                    onReleased: {
                        categoriesModel.setProperty(categoryIndex, "positionX", parent.x);
                        categoriesModel.setProperty(categoryIndex, "positionY", parent.y);
                        if(connectLine.visible){
                            var clickedCategory = categoriesModel.get(categoryIndex);
                            connectLine.endPositionLineX = clickedCategory.positionX + 150;
                            connectLine.endPositionLineY = clickedCategory.positionY + 25;
                            var deltaX = connectLine.endPositionLineX - connectLine.startPositionLineX;
                            var deltaY = connectLine.endPositionLineY - connectLine.startPositionLineY;
                            var angle = Math.atan2(deltaY, deltaX) * 180 / Math.PI;
                            centerText.rotation = angle;
                        }


                    }
                    onClicked: {
                        if (mouse.button === Qt.RightButton) {
                            clickedIndex = categoryIndex
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
                        textRole: "categoryName"
                        anchors.fill: parent
                    }
                    onAccepted: {

                        colorDialog2.open();
                    }
                }
                Dialog {
                    id: colorDialog2
                    width: 180
                    height: 100
                    title: "Select Color"
                    standardButtons: Dialog.Ok | Dialog.Cancel
                    Button {
                        id: btnColor
                        text: "Color"
                        onClicked: {
                            colorDialogOpen.open();
                        }
                    }
                    Button{
                        id: btnLine
                        anchors.left: btnColor.right
                        anchors.leftMargin: 7
                        text: "Line"

                        onClicked: {
                            connectLine.visible = true
                        }

                    }

                    ColorDialog{
                        id: colorDialogOpen
                        onAccepted: {
                            var newCategoryColor = colorDialogOpen.selectedColor;
                            var clickedObjectIndex = mouseArea.clickedIndex;
                            var selectedObjectIndex = categoryComboBox.currentIndex

                            // Обновляем цвет выбранного объекта в модели
                            categoriesModel.setProperty(clickedObjectIndex, "categoryColor", newCategoryColor);
                            categoriesModel.setProperty(clickedObjectIndex, "textConnectLabel", categoriesModel.get(selectedObjectIndex).categoryName);
                            categoriesModel.setProperty(clickedObjectIndex, "boolConnectLabel", true);
                            // Если выбран объект из выпадающего списка, обновляем его цвет
                            if (selectedObjectIndex >= 0) {
                                var selectedCategory = categoriesModel.get(selectedObjectIndex);
                                var clickedCategory = categoriesModel.get(clickedObjectIndex);
                                selectedCategory.categoryColor = newCategoryColor;
                                selectedCategory.textConnectLabel = categoriesModel.get(clickedObjectIndex).categoryName;
                                selectedCategory.boolConnectLabel = true;
                                connectLine.startPositionLineX = clickedCategory.positionX + 150
                                connectLine.startPositionLineY = clickedCategory.positionY + 25
                                connectLineShape.startX = connectLine.startPositionLineX
                                connectLineShape.startY = connectLine.startPositionLineY
                                //connectLine.lineX = selectedCategory.positionX / 2
                                //connectLine.lineY = selectedCategory.positionY / 2
                                console.log(connectLineShape.startX)
                                console.log(connectLineShape.startY)
                                connectLine.endPositionLineX = selectedCategory.positionX + 150
                                connectLine.endPositionLineY = selectedCategory.positionY + 25
                                console.log(connectLine.endPositionLineX)
                                console.log(connectLine.endPositionLineY)
                                connectLineShape.strokeColor = newCategoryColor
                                connectLine.lineAngle = Math.atan2(connectLine.endPositionLineY - connectLine.startPositionLineY, connectLine.endPositionLineX - connectLine.startPositionLineX) * 180 / Math.PI
                                connectLine.visible = true;
                                textLineDialog.open();


                            }

                        }
                    }
                }

                Dialog {
                    id: dateDialog
                    title: "Category Creation Date"
                    standardButtons: Dialog.Ok
                    Text {
                        text: "Category \"" + categoryName + "\" was created on " + new Date().toLocaleDateString()
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
                        text: categoryName
                        placeholderText: "Category Name"
                    }
                    onAccepted: {
                        var newCategoryText = categoryNameInputRename.text.trim();
                        if (newCategoryText !== "" && newCategoryText !== categoryName) {
                            // Обновляем элементы в массиве категорий
                            categoriesModel.setProperty(categoryIndex, "categoryName", newCategoryText);
                            categoryName = newCategoryText;
                        }
                    }
                }

            }
        }
        Dialog{
            id: textLineDialog
            title: "Enter name Line"
            standardButtons: Dialog.Ok
            anchors.centerIn: parent.Center
            TextField {
                id: centerTextLineName
                text: centerText.text
                placeholderText: "Line Name"
            }
            onAccepted: {
                var newNameLine = centerTextLineName.text.trim();
                if(newNameLine !== "" && newNameLine !== centerText.text){
                    centerText.text = newNameLine
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
