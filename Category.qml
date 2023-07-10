import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Shapes

Page {
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias buttonText: textNavButton.text
    signal buttonClicked();
    property var categoryConnectIndex : []

        ListModel {
            id: categoriesModel
            dynamicRoles: true
        }

        background: Rectangle{
            id: backgroundRect
        }
        Dialog {
            id: categoryDialog
            title: "Enter Category Name"
            anchors.centerIn: parent
            standardButtons: Dialog.Ok | Dialog.Cancel
            TextField {
                id: categoryNameInput
                width: categoryDialog.width - 14
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
                var setConnectedBool = false
                var setDataCellAccess = -1

                if(setCategoryName !== ""){
                    categoriesModel.append({
                                               "categoryName": setCategoryName,
                                               "categoryColor": setCategoryColor,
                                               "categoryIndex": setCategoryIndex,
                                               "textConnectLabel": setTextConnectLabel,
                                               "boolConnectLabel": setBoolConnectLabel,
                                               "positionX": setPositionX,
                                               "positionY": setPositionY,
                                               "connectedBool": setConnectedBool,
                                               "dataCellAccess": setDataCellAccess
                                           })
                var newCategory =  categoryRectComponent.createObject(root);
                    newCategory.categoryName = categoriesModel.get(setCategoryIndex).categoryName
                    newCategory.categoryColor = categoriesModel.get(setCategoryIndex).categoryColor
                    newCategory.categoryIndex = categoriesModel.get(setCategoryIndex).categoryIndex
                    newCategory.textConnectLabel = categoriesModel.get(setCategoryIndex).textConnectLabel
                    newCategory.boolConnectLabel = categoriesModel.get(setCategoryIndex).boolConnectLabel
                    newCategory.x = categoriesModel.get(setCategoryIndex).positionX
                    newCategory.y = categoriesModel.get(setCategoryIndex).positionY
                    newCategory.connectedBool = categoriesModel.get(setCategoryIndex).connectedBool
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
          property var clickedCategory
          property var selectedCategory
          property var tempCategory
          property int  indexStartPosition: -1
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

        Binding{
            target: connectLineShape
            property: "startX"
            value: connectLine.startPositionLineX
        }
        Binding{
            target: connectLineShape
            property: "startY"
            value: connectLine.startPositionLineY
        }
        Binding{
            target: pathLine
            property: "x"
            value: connectLine.endPositionLineX
        }
        Binding{
            target: pathLine
            property: "y"
            value: connectLine.endPositionLineY
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
                property var connectedBool
                property var dataCellAccess
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
                    anchors.margins: 10
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
                        clickedIndex = categoryIndex
                        categoriesModel.setProperty(clickedIndex, "positionX", parent.x)
                        categoriesModel.setProperty(clickedIndex, "positionY", parent.y)
                        console.log("\n################################### " +
                                    "\nClicked Index: " + clickedIndex +
                                    "\nCategory Name : " + categoriesModel.get(clickedIndex).categoryName +
                                    "\nPosition X : " + categoriesModel.get(clickedIndex).positionX +
                                    "\nPosition Y : " + categoriesModel.get(clickedIndex).positionY +
                                    "\n###################################")

                        if(connectLine.visible){
                            var index = categoriesModel.get(categoryIndex).dataCellAccess
                            var firstIndexCategory = categoriesModel.get(categoryConnectIndex[index][0]).categoryIndex
                            var secondIndexCategory = categoriesModel.get(categoryConnectIndex[index][1]).categoryIndex

                            if(categoriesModel.get(firstIndexCategory).connectedBool
                                    && categoriesModel.get(secondIndexCategory).connectedBool){
                                categoriesModel.setProperty(firstIndexCategory, "positionX", parent.x)
                                categoriesModel.setProperty(firstIndexCategory, "positionY", parent.y)

                                var clickedCategory = categoriesModel.get(categoryConnectIndex[index][0])
                                var startCategory = categoriesModel.get(categoryConnectIndex[index][1])

                                connectLine.startPositionLineX = clickedCategory.positionX + 150
                                connectLine.startPositionLineY = clickedCategory.positionY + 25
                                connectLine.endPositionLineX = startCategory.positionX + 150
                                connectLine.endPositionLineY = startCategory.positionY + 25
                                console.log("Position ONE : NO Change")
                                console.log("Clicked Caterogry name : " + connectLine.selectedCategory.categoryName)
                                console.log("Start Category name : " + connectLine.clickedCategory.categoryName)
                                console.log("ConnectLine start X : " + connectLine.startPositionLineX)
                                console.log("ConnectLine start Y : " + connectLine.startPositionLineY)
                                console.log("ConnectLine end X : " + connectLine.endPositionLineX)
                                console.log("ConnectLine end Y : " + connectLine.endPositionLineY)
                                connectLine.tempCategory = connectLine.selectedCategory
                                var deltaX = connectLine.endPositionLineX - connectLine.startPositionLineX;
                                var deltaY = connectLine.endPositionLineY - connectLine.startPositionLineY;
                                var angle = Math.atan2(deltaY, deltaX) * 180 / Math.PI;
                                centerText.rotation = angle;
                            }
                            categoriesModel.setProperty(secondIndexCategory, "positionX", parent.x)
                            categoriesModel.setProperty(secondIndexCategory, "positionY", parent.y)
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
                                if(categoriesModel.get(index).connectedBool){
                                    categoriesModel.setProperty(index, "connectedBool", false)
                                    connectLine.visible = false
                                    centerText.visible = false
                                }
                                categoriesModel.remove(index, 1);
                                mouseArea.parent.destroy(categoryIndex);
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
                    height: 120
                    title: "Select Color"
                    standardButtons: Dialog.Ok | Dialog.Cancel
                    Button {
                        id: btnColor
                        width: 160
                        height: 50
                        text: "Color"
                        onClicked: {
                            colorDialogOpen.open();
                        }
                    }                    

                    ColorDialog{
                        id: colorDialogOpen
                        onAccepted: {
                            var newCategoryColor = colorDialogOpen.selectedColor;
                            var clickedObjectIndex = mouseArea.clickedIndex;
                            var selectedObjectIndex = categoryComboBox.currentIndex
                            //connectLine.indexStartPosition = clickedObjectIndex
                            connectLine.indexStartPosition = selectedObjectIndex
                            // Обновляем цвет выбранного объекта в модели
                            categoriesModel.setProperty(clickedObjectIndex, "categoryColor", newCategoryColor);
                            categoriesModel.setProperty(clickedObjectIndex, "textConnectLabel", categoriesModel.get(selectedObjectIndex).categoryName);
                            categoriesModel.setProperty(clickedObjectIndex, "boolConnectLabel", true);

                            // Если выбран объект из выпадающего списка, обновляем его цвет
                            if (selectedObjectIndex >= 0) {
                                var selectedCategory = categoriesModel.get(selectedObjectIndex);
                                var clickedCategory = categoriesModel.get(clickedObjectIndex);
                                categoriesModel.setProperty(clickedObjectIndex, "dataCellAccess", categoryConnectIndex.length)
                                categoriesModel.setProperty(selectedObjectIndex, "dataCellAccess", categoryConnectIndex.length)
                                connectLine.selectedCategory = selectedCategory
                                connectLine.clickedCategory = clickedCategory
                                selectedCategory.categoryColor = newCategoryColor;
                                selectedCategory.textConnectLabel = categoriesModel.get(clickedObjectIndex).categoryName;
                                selectedCategory.boolConnectLabel = true;
                                selectedCategory.connectedBool = true;
                                clickedCategory.connectedBool = true;
                                connectLine.startPositionLineX = clickedCategory.positionX + 150
                                connectLine.startPositionLineY = clickedCategory.positionY + 25
                                connectLineShape.startX = connectLine.startPositionLineX
                                connectLineShape.startY = connectLine.startPositionLineY
                                connectLine.endPositionLineX = selectedCategory.positionX + 150
                                connectLine.endPositionLineY = selectedCategory.positionY + 25
                                connectLineShape.strokeColor = newCategoryColor
                                connectLine.lineAngle = Math.atan2(connectLine.endPositionLineY - connectLine.startPositionLineY, connectLine.endPositionLineX - connectLine.startPositionLineX) * 180 / Math.PI
                                connectLine.visible = true;
                                textLineDialog.open();
                                categoryConnectIndex.push([clickedCategory.categoryIndex, selectedCategory.categoryIndex])
                                console.log(categoryConnectIndex.length)
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
            anchors.centerIn: parent
            width: 300
            height: 300

            TextField {
                id: centerTextLineName
                text: centerText.text
                anchors.left: parent.left
                placeholderText: "Line Name"
                width: textLineDialog.width - 14
            }

            onAccepted: {
                var newNameLine = centerTextLineName.text.trim();
                if(newNameLine !== "" && newNameLine !== centerText.text){
                    centerText.text = newNameLine
                }
            }
        }

    Rectangle{
        id: footer
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        radius: 10
        height: 50
        color: backgroundColor - 10
        opacity: 0.8

        Rectangle{
            id: dateTime
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: dateTimeText.width + 20
            anchors.margins: 10
            radius: 10
            color: backgroundColor - 10

            Text {
                id: dateTimeText
                text: Qt.formatDateTime(new Date(), "hh:mm:ss dd.MM.yyyy")
                color: backgroundColor
                font.pixelSize: 16
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.margins: 10
            }

            Timer {
                id: timer
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    dateTimeText.text = Qt.formatDateTime(new Date(), "hh:mm:ss dd.MM.yyyy")
                }
            }
        }


        Rectangle{
            id: centerTextButton
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: dateTime.right
            anchors.right: backgroundChangeColorButton2.left
            anchors.margins: 10
            radius: 10
            color: backgroundColor - 10
            Rectangle {
                id: quitButton
                width: centerTextButton.width * 0.2
                height: parent
                color: "red"
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                radius: 10
                visible: false
                z: 1
                Text {
                    text: "QUIT"
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: Qt.quit()
                }
            }

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    quitButton.visible = true

                }
                onExited: {
                    quitButton.visible = false
                }
            }


            Text{
                anchors.centerIn: parent
                text: "Bubble app"
                font.pixelSize: 20
                color: backgroundColor

            }
        }

        Rectangle{
            id: backgroundChangeColorButton2
            height: footer.height
            width: textAreaBackgroundChangeColor.width + 20
            anchors.right: addCategoryButton.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.margins: 10
            radius: 10
            color: backgroundColor - 10

            TextArea{
                id: textAreaBackgroundChangeColor
                text: "Change Color"
                font.pixelSize: 16
                color: backgroundColor
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
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
        }

        Rectangle {
            id: addCategoryButton
            height: footer.height
            width: textAreaBackgroundChangeColor.width + 20
            anchors.right: navButton.left
            anchors.bottom: parent.bottom
            anchors.top:parent.top
            anchors.margins: 10
            radius: 10
            color: backgroundColor - 10
            TextArea{
            text: "Add Category"
            anchors.centerIn: parent
            font.pixelSize: 16
            color: backgroundColor
            }
            MouseArea{
            anchors.fill: parent

                onClicked: {
                    newColorDialog.open()
                    categoryDialog.open()
                }
            }
        }
        Rectangle{
            id: navButton
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.margins: 10
            color: backgroundColor - 10
            radius: 10
            height: footer.height
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
}
