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
    property bool stopRepeater: false

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
            Popup {
                id: namePopup
                modal: true
                anchors.centerIn: parent

                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

                contentItem: Rectangle {
                    anchors.fill: parent
                    color: "red"
                    Text {
                        anchors.centerIn: parent
                        text: "There's already a category with that name. \nPlease create a category with a different name."
                        color: "white"
                        font.pixelSize: 24
                    }
                }
            }
            Popup {
                id: emptyNamePopup
                modal: true
                anchors.centerIn: parent

                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

                contentItem: Rectangle {
                    anchors.fill: parent
                    color: "red"
                    Text {
                        anchors.centerIn: parent
                        text: "Empty name. \nPlease create a category with a different name."
                        color: "white"
                        font.pixelSize: 24
                    }
                }
            }


            onAccepted: {                
                var temp = categoryNameInput.text.trim()
                var flag = true
                var flag2 = true
                for(var i = 0; i < categoriesModel.count; i++){
                    if(temp !== categoriesModel.get(i).categoryName){
                        flag = true
                    }
                    else{
                        flag = false
                        console.log("Name: " + temp + " " + " FIND : " + categoriesModel.get(i).categoryName)
                        break
                    }
                }

                var setCategoryName
                if(temp === ""){
                    flag2 = false
                }

                if(flag && flag2){
                    setCategoryName = temp
                }
                var setCategoryColor = newColorDialog.selectedColor                
                var setCategoryIndex = categoriesModel.count
                var setTextConnectLabel = ""
                var setBoolConnectLabel = false
                var setPositionX = Math.random() * (root.width)
                var setPositionY = Math.random() * (root.height)
                var setConnectedBool = false
                var setDataCellAccess = -1
                var setToDoListInstance = Qt.createComponent("ToDoList.qml")
                if(flag && flag2){
                    categoriesModel.append({
                                               "categoryName": setCategoryName,
                                               "categoryColor": setCategoryColor,
                                               "categoryIndex": setCategoryIndex,
                                               "textConnectLabel": setTextConnectLabel,
                                               "boolConnectLabel": setBoolConnectLabel,
                                               "positionX": setPositionX,
                                               "positionY": setPositionY,
                                               "connectedBool": setConnectedBool,
                                               "dataCellAccess": setDataCellAccess,
                                               "toDoListInstance": setToDoListInstance
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

                    if(setToDoListInstance.status === Component.Ready){
                        var properties = {
                            category : newCategory.categoryName,
                            indexCategory : newCategory.categoryIndex
                        }
                        var toDoListInstance = setToDoListInstance.createObject(categoryRectComponent, properties)
                        categoriesModel.setProperty(setCategoryIndex, "toDoListInstance", toDoListInstance)
                    }
                }
                else if (flag2 === false){
                    emptyNamePopup.open()
                }

                else{
                    namePopup.open()
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
                height: 200
                color: categoriesModel.get(categoryIndex).categoryColor
                radius: 10
                Rectangle{
                    id: nameRectangle
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 5
                    height: 25
                    radius: 5
                    color: categoriesModel.get(categoryIndex).categoryColor
                    border.color: colorYellow
                    border.width: 1


                    Text {
                        text: categoryName
                        font.pixelSize: 20
                        color: colorYellow
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.left: parent.left
                        anchors.margins: 5
                    }
                }
                Text{
                    id:dateTime
                    text: ""
                }

                Rectangle{
                    id: footerCategory
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 5
                    height: 40
                    radius: 5
                    color: categoriesModel.get(categoryIndex).categoryColor
                    border.color: colorYellow
                    border.width: 1

                    Rectangle{
                        id: overdueCounter
                        width: parent.width * 0.3
                        radius: 5
                        color: "Red"
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.margins: 5
                        Text{
                            text: "Deleted: " + categoriesModel.get(categoryIndex).toDoListInstance.counterDeleted
                            anchors.margins: 2
                            anchors.left: parent.left
                        }
                    }

                    Rectangle{
                        id: completedCounter
                        width: parent.width * 0.3
                        radius: 5
                        color: "Green"
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.margins: 5
                        Text{
                            text: "Completed: " + categoriesModel.get(categoryIndex).toDoListInstance.counterDone
                            anchors.margins: 2
                            anchors.left: parent.left
                        }
                    }
                    Rectangle{
                        id: сreatedCounter
                        width: parent.width * 0.3
                        radius: 5
                        color: "Yellow"
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: completedCounter.right
                        anchors.right: overdueCounter.left
                        anchors.margins: 5
                        Text{                            
                            text: "Created: " + categoriesModel.get(categoryIndex).toDoListInstance.counterCreated
                            anchors.margins: 2
                            anchors.left: parent.left
                        }
                    }
                }
                Label{
                    id: connectLabel
                    text: "Connected with " + categoriesModel.get(categoryIndex).textConnectLabel
                    anchors.bottom: parent.bottom
                    visible: categoriesModel.get(categoryIndex).boolConnectLabel
                    anchors.margins: 10
                }
                Rectangle{
                    id: priorityRect
                    height: parent.height / 2
                    width: parent.width / 2
                    color: "gray"
                    radius: 10
                    anchors.left: parent.left
                    anchors.top: nameRectangle.bottom
                    anchors.margins: 10
                    Rectangle{
                        id:priorityLabel
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.margins: 5
                        radius: 10
                        height: parent.height / 4
                        color: "DarkGray"
                        Text{
                            anchors.centerIn: parent
                            text: "Task priority"
                            font.pixelSize: 16
                        }
                    }
                    Rectangle{
                        id:lowLabel
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: priorityLabel.bottom
                        anchors.margins: 5
                        radius: 10
                        height: parent.height / 6
                        color: "Yellow"
                        Text{
                            text: "Low"
                            font.pixelSize: 16
                            anchors.left: parent.left
                            anchors.margins: 10
                        }
                    }
                    Rectangle{
                        id:averageLabel
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: lowLabel.bottom
                        anchors.margins: 5
                        radius: 10
                        height: parent.height / 6
                        color: "Green"
                        Text{
                            text: "Average"
                            font.pixelSize: 16
                            anchors.left: parent.left
                            anchors.margins: 10
                        }
                    }
                    Rectangle{
                        id:highLabel
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: averageLabel.bottom
                        anchors.margins: 5
                        radius: 10
                        height: parent.height / 6
                        color: "Red"
                        Text{
                            text: "High"
                            font.pixelSize: 16
                            anchors.left: parent.left
                            anchors.margins: 10
                        }
                    }
                }

                Rectangle{
                    id: editButton
                    height: 50
                    width: 50
                    radius: 10
                    color: "gray"
                    anchors.top: nameRectangle.bottom
                    anchors.right: parent.right
                    anchors.margins: 10
                    z: 1
                    visible: false
                    MouseArea{
                        Text{
                            text: "edit"
                            anchors.centerIn: parent
                        }

                        anchors.fill: parent
                        onClicked: stackView.push(categoriesModel.get(categoryIndex).toDoListInstance)
                    }
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
                    hoverEnabled: true
                    onEntered: {
                        editButton.visible = true

                    }
                    onExited: {
                        editButton.visible = false
                    }


                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onDoubleClicked: {
                        stackView.push(categoriesModel.get(categoryIndex).toDoListInstance)
                    }


                    onReleased: {
                        clickedIndex = categoryIndex
                        categoriesModel.setProperty(clickedIndex, "positionX", parent.x)
                        categoriesModel.setProperty(clickedIndex, "positionY", parent.y);


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
                                categoriesModel.remove(index);
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
                    anchors.centerIn: parent
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
                    anchors.centerIn: root
                    standardButtons: Dialog.Ok | Dialog.Cancel
                    TextField {
                        anchors.centerIn: parent
                        id: categoryNameInputRename
                        text: categoryName
                        placeholderText: "Category Name"
                    }
                    Popup {
                        id: emptyNamePopup
                        modal: true
                        anchors.centerIn: parent

                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

                        contentItem: Rectangle {
                            anchors.fill: parent
                            color: "red"
                            Text {
                                anchors.centerIn: parent
                                text: "Empty name. \nPlease create a category with a different name."
                                color: "white"
                                font.pixelSize: 24
                            }
                        }
                    }
                    Popup {
                        id: reusingAnExistingName
                        modal: true
                        anchors.centerIn: parent
                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

                        contentItem: Rectangle {
                            anchors.fill: parent
                            color: "red"
                            Text {
                                anchors.centerIn: parent
                                text: "A category with this name already exists. \nPlease select a new category name."
                                color: "white"
                                font.pixelSize: 24
                            }
                        }
                    }
                    onAccepted: {
                        var newCategoryText = categoryNameInputRename.text.trim();
                        var flag = true
                        for(var i = 0; i < categoriesModel.count; i++){
                            if(newCategoryText !== categoriesModel.get(i).categoryName){
                                flag = true
                            }
                            else{
                                flag = false
                                break
                            }
                        }
                        if (newCategoryText !== "" && newCategoryText !== categoryName && flag) {
                            // Обновляем элементы в массиве категорий
                            categoriesModel.setProperty(categoryIndex, "categoryName", newCategoryText)
                            var newName = categoriesModel.get(categoryIndex).toDoListInstance
                            newName.category = newCategoryText
                            categoriesModel.setProperty(categoryIndex, "toDoListInstance", newName)
                            categoryName = newCategoryText
                        }
                        else if(newCategoryText === ""){
                        emptyNamePopup.open()
                    }

                        else{
                            reusingAnExistingName.open()
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
        property string footerColor: "white"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        radius: 10
        height: 50
        color: footerColor
        opacity: 0.8

        Rectangle{
            id: dateTime
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: dateTimeText.width + 20
            anchors.margins: 10
            radius: 10
            color: footer.footerColor

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
            color: footer.footerColor
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
            color: footer.footerColor

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
            color: footer.footerColor
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
            color: footer.footerColor
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
