import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs




Page {
    id: toDoList    
    property string colorFromHeaderAndFooter: "white"
    property int currentYear: Qt.formatDate(new Date(), "yyyy")
    property int currentMonth: Qt.formatDate(new Date(), "MM")
    property int redValue: 0
    property int greenValue: 0
    property int blueValue: 0
    property string category
    property int indexCategory
    property int counterCreated: 0
    property int counterDone: 0
    property int counterDeleted: 0
    property int counterLow: 0
    property int counterAverage: 0
    property int counterHigh: 0
    property int deadLineDay
    property int deadLineMonth

    ListModel{
        id: listModel
    }

    ColorDialog{
        id: colorDialog
        onAccepted: {
            var newColor = colorDialog.selectedColor
            redValue = newColor.r * 255;
            greenValue = newColor.g * 255;
            blueValue = newColor.b * 255;
            leftRectangle.color = applyColorChanges(5,5,5)
            rightRectangle.color = applyColorChanges(10,10,10)
            headerToDoList.color = applyColorChanges(50,50,50)
            footerToDoList.color = headerToDoList.color
            backButton.color = applyColorChanges(15,20,25)
            changeColorButton.color = backButton.color
            quitButtonToDoList.color = backButton.color
            dateTimeToDoList.color = backButton.color
            textBackButton.color = applyColorChanges(100,100,100)
            textChangeColorButton.color = textBackButton.color
            textQuitButton.color = textBackButton.color
            textDateTime.color = textBackButton.color
            headerToDoListText.color = textBackButton.color
        }
    }
    function  applyColorChanges(r, g, b) {
            redValue   = Math.max(0, Math.min(255, redValue));
            greenValue = Math.max(0, Math.min(255, greenValue));
            blueValue  = Math.max(0, Math.min(255, blueValue));
            redValue += r;
            greenValue += g;
            blueValue += b;
            return Qt.rgba(redValue / 255, greenValue / 255, blueValue / 255, 1)
        }
    function generateCalendarDates(year, month) {
        calendarModel.clear()
        var startDate = new Date(year, month - 1, 1);
        var endDate = new Date(year, month, 0)
        for (var date = startDate; date <= endDate; date.setDate(date.getDate() + 1)) {
            calendarModel.append({ day: date.getDate(), month: date.getMonth() + 1 });
        }

    }
    Dialog{
        id: changeColorDialog
        anchors.centerIn: parent

        width: standardButton.width
        height: 150
        title: "Select place"
        standardButtons: Dialog.Ok | Dialog.Cancel
        Rectangle{
            id: headerFooter
            height: 50
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            color: "blue"
            Text{
                text: "Сhoose a color"
                anchors.centerIn: parent
                font.pixelSize: 16
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    colorDialog.open()
                }
            }
        }
    }

    Rectangle{
        id: headerToDoList
        height: 50
        width: parent.width
        color: footerToDoList.color
        anchors.top: parent.top

        Text{
            id: headerToDoListText
            text: "To Do List from : " + category
            font.pixelSize: 40
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 50
            color: leftRectangle.color
        }
    }
    Rectangle{
        id:editWindow
        height: 500
        width: 500
        color: "Yellow"
        radius: 10
        property int index
        property string title: ""
        property string description: ""

        anchors.centerIn: parent
        z: 1
        visible: false
        Rectangle{
            id: titleRect
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            height: 50
            radius: 10
            color: colorLightGray
            TextInput{
                id: editTitleWindowText
                text: ""
                anchors.centerIn: parent
                selectByMouse: true
                wrapMode: TextInput.Wrap
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: TextInput.AlignVCenter
                font.pointSize: 16
                cursorVisible: true
                onEditingFinished: {
                    editTitleWindowText.focus = false;
                }
            }
            MouseArea {
                id: editTitleMouseArea
                anchors.fill: parent
                onClicked: {
                    editTitleWindowText.focus = true;
                }
            }
        }
        Rectangle{
            property int currentIndex
            id:viewLeftRect
            height: editWindow.height
            width: 200
            radius: 10
            anchors.right: editWindow.left
            anchors.margins: 10
            color: "Yellow"
            ListView{
                id: viewLeftRectListView
                model: listModel
                spacing: 10
                clip: true
                anchors.fill: parent
                anchors.margins: 10
                delegate: Rectangle{
                    property string title
                    title: _title
                    width: viewLeftRect.width - 20
                    height: viewLeftRect.height / 10
                    border.width: 1
                    border.color: colorPurple
                    radius: 10
                    Text{
                        text: title
                        anchors.centerIn: parent
                        font.pixelSize: 25
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            editWindow.visible = true
                            editWindow.index = index
                            editTitleWindowText.text = listModel.get(editWindow.index)._title
                            editDescriptionWindowText.text = listModel.get(editWindow.index)._description
                        }
                    }
                }
            }

        }

        Rectangle{
            id: descriptionRect
            anchors.top: titleRect.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: editCanselButton.top
            anchors.margins: 10
            height: 50
            radius: 10
            color: colorLightGray
            TextArea{
                id: editDescriptionWindowText
                text: ""
                anchors.fill: parent
                anchors.margins: 10
                color: colorYellow
                selectByMouse: true
                wrapMode: TextInput.Wrap                
                font.pointSize: 16
                cursorVisible: true
                clip: true

                onEditingFinished: {
                    editDescriptionWindowText.focus = false;
                }
            }
            MouseArea {
                id: editDescriptionMouseArea
                anchors.fill: parent
                onClicked: {
                    editDescriptionWindowText.focus = true;
                }
            }
        }
        Rectangle{
            id: editCanselButton
            height: 50
            width: 100
            color: colorPurple
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            radius: 10
            anchors.margins: 10
            Text{
                anchors.centerIn: parent
                text: "Cansel"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    editWindow.visible = false
                }
            }
        }
        Rectangle{
            id: editSaveButton
            height: 50
            width: 100
            color: colorPurple
            anchors.bottom: parent.bottom
            anchors.right: editCanselButton.left
            radius: 10
            anchors.margins: 10
            Text{
                anchors.centerIn: parent
                text: "Save"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    listModel.setProperty(editWindow.index, "_title",  editTitleWindowText.text)
                    listModel.setProperty(editWindow.index, "_description", editDescriptionWindowText.text)
                }
            }
        }
    }
    Item{
        width: parent.width
        anchors.top: headerToDoList.bottom
        anchors.bottom: footerToDoList.top

        Rectangle{
            id: leftRectangle
            width: parent.width / 2
            height: parent.height
            anchors.left: parent.left
            color: colorLightGray
            ListView{
                id: listView
                model: listModel
                spacing: 10
                clip: true
                anchors.fill: parent
                anchors.margins: 50
                delegate: Rectangle{
                    property string title
                    property string description
                    property string colorPriority
                    property string date
                    property int currentIndex: -1
                    title: _title
                    description: _description
                    colorPriority: _priority
                    date: _date

                    id: delegateRectangle

                    width: listView.width
                    height: descriptionText.contentHeight + titleText.contentHeight < 50 ?
                                listView.height * 0.3 : (descriptionText.contentHeight + titleText.contentHeight) * 1.2
                    anchors.topMargin: 50

                    color: colorPriority
                    radius: 10
                    border.width: 1
                    border.color: colorYellow

                    Rectangle{

                        id: columnRectangle
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.right: buttonArea.left
                        anchors.left: parent.left
                        anchors.margins: 10
                        color: colorPurple
                        radius: 10
                        border.width: 1
                        border.color: colorYellow

                            Rectangle{
                                id: titleTextRect
                                width: columnRectangle.width / 2
                                height: 30
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.topMargin: 10
                                anchors.leftMargin: 10
                                anchors.bottomMargin: 10
                                anchors.rightMargin: 5
                                radius: 10
                                color: "Yellow"
                                Rectangle{
                                    id: deadLineButton                                    
                                    height: parent.height
                                    anchors.margins: 10
                                    width: 70
                                    radius: 10
                                    color: "Gray"
                                    anchors.left: parent.left
                                    Text {
                                        id: deadLineText
                                        anchors.centerIn: parent
                                        text: "DeadLine"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            deadLineDialog.open()
                                        }
                                    }
                                }
                                Dialog {
                                    id: deadLineDialog
                                    title: "DeadLine"

                                    standardButtons: Dialog.Ok
                                    Text {
                                        id: deadLineDialogText
                                        text: "DeadLine: Day :" + deadLineDay + " month : " + deadLineMonth
                                        color: "White"
                                        font.bold: true
                                    }
                                }

                                Text{
                                    id:titleText
                                    anchors.centerIn: parent
                                    wrapMode: TextEdit.Wrap
                                    clip: true
                                    text: delegateRectangle.title
                                    font.pixelSize: 16
                                    color: colorDarkGray
                                }
                            }

                            Rectangle{
                                id: descriptionTextRect
                                width: columnRectangle.width / 2
                                height: 30
                                anchors.left: parent.left
                                anchors.top: titleTextRect.bottom
                                anchors.bottom: parent.bottom
                                anchors.right: parent.right
                                anchors.margins: 10
                                radius: 10
                                color: "Yellow"

                                Text{
                                    id:descriptionText
                                    anchors.top: titleTextRect.bottom
                                    anchors.left: parent.left
                                    anchors.margins: 10
                                    text: delegateRectangle.description
                                    font.pixelSize: 16
                                    color: colorDarkGray
                                    wrapMode: TextEdit.Wrap
                                    clip: true
                                }
                            }
                            Rectangle{
                                id: dateTextRect
                                width: columnRectangle.width / 2
                                height: 30
                                anchors.top: parent.top
                                anchors.right: parent.right
                                anchors.left: titleRect.right
                                anchors.topMargin: 10
                                anchors.leftMargin: 5
                                anchors.bottomMargin: 10
                                anchors.rightMargin: 10
                                radius: 10
                                color: "Yellow"
                                Text{
                                    id: dateText
                                    anchors.centerIn: parent
                                    anchors.margins: 10
                                    text: "Created: " + date
                                    font.pixelSize: 16
                                    color: colorDarkGray
                                }
                            }



                    }


                    Rectangle{
                        id: buttonArea
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.margins: 10
                        radius: 10
                        border.width: 1
                        border.color: colorYellow
                        width: 100
                        color: colorPurple

                        Rectangle{
                            id: doneButton
                            radius: 10
                            color: colorYellow
                            anchors.top: parent.top
                            anchors.right: parent.right
                            anchors.left: parent.left
                            anchors.margins: 5
                            height: parent.height / 3.33

                            Text{
                                text: "Done"
                                anchors.centerIn: parent
                                color: colorPurple
                                font.bold: true
                                font.pixelSize: 20
                            }
                            MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        columnRectangle.color = "green"
                                        counterDone += 1
                                }
                            }
                        }
                        Rectangle{
                            id: editButton
                            anchors.top: doneButton.bottom
                            anchors.right: parent.right
                            anchors.left: parent.left
                            anchors.margins: 5
                            radius: 10
                            color: colorYellow
                            height: parent.height / 3.33
                            Text{
                                text: "Edit"
                                anchors.centerIn: parent
                                color: colorPurple
                                font.bold: true
                                font.pixelSize: 20
                            }
                            MouseArea{
                                id: editButtonMouseArea
                                property var clickedIndexEtid
                                anchors.fill: parent
                                onClicked: {
                                    currentIndex = index
                                    editWindow.visible = true
                                    editWindow.index = currentIndex
                                    editTitleWindowText.text = listModel.get(currentIndex)._title
                                    editDescriptionWindowText.text = listModel.get(currentIndex)._description
                                }
                            }

                        }
                        Rectangle{
                            id: deleteButton
                            radius: 10
                            color: colorYellow
                            anchors.top: editButton.bottom
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            anchors.left: parent.left
                            anchors.margins: 5
                            height: parent.height / 3.33

                            Text{
                                text: "Delete"
                                anchors.centerIn: parent
                                color: colorPurple
                                font.bold: true
                                font.pixelSize: 20
                            }
                            MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        listModel.remove(index)
                                        counterDeleted += 1
                                        counterCreated -= 1
                                    }
                                }

                        }

                    }
                }

            }
        }
        Rectangle{
            id: rightRectangle
            width: parent.width / 2
            height: parent.height
            anchors.right: parent.right
            color: colorLightGray

            Column{
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: 100
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter


                Rectangle{
                    id: textFieldRectangle
                    width: rightRectangle.width * 0.8
                    height: 50
                    radius: 10
                    color: colorLightGray
                    border.color: colorPurple
                    border.width: 1

                    TextField{
                        id: titleToDo
                        anchors.fill: parent
                        anchors.margins: 10
                        placeholderText: "Enter To Do Title"
                        color: colorPurple
                    }
                }
                Rectangle{
                    id: textDescritionRectangle
                    width: rightRectangle.width * 0.8
                    height: rightRectangle.height * 0.6
                    color: colorLightGray
                    border.color: colorPurple
                    border.width: 1
                    radius: 10
                    clip: true

                    TextArea{
                        id: descriptionToDo
                        placeholderText: "Enter the To Do item description"
                        clip: true
                        wrapMode: TextEdit.Wrap
                        anchors.fill: parent
                        color: colorYellow
                    }
                }
                Rectangle{
                    id: priorityRect
                    height: 50
                    width: rightRectangle.width * 0.8
                    radius: 10
                    color: colorYellow

                    Rectangle{
                        id: labelPriorityText
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: lowPriority.left
                        width: priorityRectText.width
                        radius: 10
                        color: colorYellow
                        Text{
                            id: priorityRectText
                            text: "Priority: "
                            font.pixelSize: 20
                            anchors.centerIn: parent
                            anchors.margins: 10
                        }
                    }
                    Rectangle{
                        id: priorityOptions
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: labelPriorityText.right
                        color: colorYellow
                        radius: 10
                        Rectangle{
                            id: lowPriority
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            width: (priorityOptions.width / 3) - 10
                            anchors.margins: 5
                            color: "Yellow"
                            radius: 10
                            Text{
                                text: "Low"
                                anchors.centerIn: parent
                                font.pixelSize: 20
                            }
                            MouseArea{
                                id: mouseAreaLowPriority
                                anchors.fill: parent
                                onClicked: {
                                    addBtn.priorityTask = "Yellow"
                                    counterLow += 1
                                }
                            }
                        }
                    }


                    Rectangle{
                        id: averagePriority
                        anchors.left: lowPriority.right
                        anchors.right: highPriority.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: (priorityOptions.width / 3) - 10
                        anchors.margins: 5
                        color: "Green"
                        radius: 10
                        Text{
                            text: "Average"
                            anchors.centerIn: parent
                            font.pixelSize: 20
                        }
                        MouseArea{
                            id: mouseAreaAveragePriority
                            anchors.fill: parent
                            onClicked: {
                                addBtn.priorityTask = "Green"
                                counterAverage += 1
                            }
                        }
                    }
                    Rectangle{
                        id: highPriority
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: priorityOptions.width / 3
                        anchors.margins: 5
                        color: "red"
                        radius: 10
                        Text{
                            text: "High"
                            anchors.centerIn: parent
                            font.pixelSize: 20
                            anchors.margins: 5
                        }
                        MouseArea{
                            id: mouseAreaHighPriority
                            anchors.fill: parent
                            onClicked: {
                                addBtn.priorityTask = "Red"
                                counterHigh += 1
                            }
                        }
                    }
                }

                Rectangle{
                    id: deadLine
                    height: 50
                    width: rightRectangle.width * 0.8
                    radius: 10                    

                    ListModel{
                        id: calendarModel
                    }

                    Text{
                        text: "Select dead line"
                        anchors.centerIn: parent
                        font.pixelSize: 20
                        color: colorPurple
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                           generateCalendarDates()
                           deadLineCalendar.visible = true
                        }
                    }                    
                }
                Row {
                            spacing: 10
                            anchors.horizontalCenter: parent.horizontalCenter

                            Button {
                                text: "<"
                                onClicked: {
                                    currentMonth--;
                                    if (currentMonth < 1) {
                                        currentYear--;
                                        currentMonth = 12;
                                    }
                                    generateCalendarDates(currentYear, currentMonth);
                                }
                            }

                            Text {
                                text: currentYear + " year, " + currentMonth + " month"
                            }

                            Button {
                                text: ">"
                                onClicked: {
                                    currentMonth++;
                                    if (currentMonth > 12) {
                                        currentYear++;
                                        currentMonth = 1;
                                    }
                                    generateCalendarDates(currentYear, currentMonth);
                                }
                            }
                        }
                Rectangle {
                            id: deadLineCalendar
                            width: 300
                            height: 300
                            color: "white"
                            visible: false
                            anchors.centerIn: textDescritionRectangle


                            GridView {
                                id: calendarGrid
                                anchors.fill: parent
                                cellWidth: 50
                                cellHeight: 50
                                model: calendarModel

                                delegate: Item {
                                    width: calendarGrid.cellWidth
                                    height: calendarGrid.cellHeight
                                    Rectangle{
                                        id: monthRectangle
                                        width: parent.width
                                        height: 50
                                        color: colorPurple
                                        Text{
                                            id: textModelMonth
                                            text: model.month
                                            anchors.top: parent
                                        }

                                    }
                                    Rectangle {
                                        width: parent.width
                                        height: parent.height                                        
                                        color: "transparent"
                                        border.color: "lightgray"
                                        Text {

                                            text: model.day
                                            anchors.centerIn: parent
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                // Обработка выбора даты
                                                console.log("Selected day: " + model.day + " Selected month: " + model.month);
                                                deadLineDay = model.day
                                                deadLineMonth = model.month
                                                deadLineCalendar.visible = false;
                                            }
                                        }
                                    }
                                }
                            }
                        }

                Rectangle{
                    id: addBtn
                    height: 50
                    width: rightRectangle.width * 0.8
                    radius: 10
                    property string priorityTask: colorPurple
                    Text{
                        id: textAddBtn
                        anchors.centerIn: parent
                        text: "Add"
                        font.pixelSize: 20
                        color: colorPurple
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            listModel.append({"_title": titleToDo.text,
                                              "_description": descriptionToDo.text,
                                             "_priority" : addBtn.priorityTask,
                                             "_date": new Date().toLocaleDateString()})
                            titleToDo.text=""
                            descriptionToDo.text=""
                            counterCreated += 1
                        }
                    }


                }
            }
        }
    }

    Rectangle{
        id: footerToDoList
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 50
        color: colorFromHeaderAndFooter
        Rectangle {
            id: quitButtonToDoList

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.margins: 10
            color: footerToDoList.color
            radius: 10
            height: footerToDoList.height
            width: textQuitButton.width + 20

            Text {
                id: textQuitButton
                anchors.centerIn: parent
                text: "Quit"
                font.pixelSize: 16
                color: backgroundColor
            }
            MouseArea{
                anchors.fill: parent
                onClicked: Qt.quit()
            }
        }
        Rectangle{
            id: dateTimeToDoList
            anchors.centerIn: parent
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            width: dateTimeText.width + 20
            anchors.margins: 10
            radius: 10
            color: footerToDoList.color

            Text {
                id: textDateTime
                text: Qt.formatDateTime(new Date(), "hh:mm:ss dd.MM.yyyy")
                color: backgroundColor
                font.pixelSize: 20
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
                    textDateTime.text = Qt.formatDateTime(new Date(), "hh:mm:ss dd.MM.yyyy")
                }
            }
        }
        Rectangle{
            id: changeColorButton
            anchors.right: backButton.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.margins: 10
            color: footerToDoList.color
            radius: 10
            height: footerToDoList.height
            width: textChangeColorButton.width + 20
            TextArea{
                id: textChangeColorButton
                anchors.centerIn: parent
                text: "Change Color"
                font.pixelSize: 16
                color: backgroundColor
            }
            MouseArea{
                id: mouseChangeColorButton
                anchors.fill: parent
                onClicked: {
                    changeColorDialog.open()
                    console.log(categoriesModel.count)
                }
            }
        }


        Rectangle{
            id: backButton
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.margins: 10
            color: footerToDoList.color
            radius: 10
            height: footerToDoList.height
            width: textBackButton.width + 20

            TextArea{
                id: textBackButton
                text: "Back"
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
