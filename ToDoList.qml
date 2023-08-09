import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs



Page {
    id: toDoList
    signal todoListChanged(int indexCategory, string newColor)
    property string colorFromHeaderAndFooter: "white"
    property int redValue: 0
    property int greenValue: 0
    property int blueValue: 0
    property string category: ""
    property int indexCategory
    property var testColor:


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
            todoListChanged(indexCategory, newColor)
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
            //color: leftRectangle.color
            color: testColor
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
                    title: _title
                    description: _description

                    id: delegateRectangle
                    width: listView.width
                    height: descriptionText.contentHeight + titleText.contentHeight < 50 ?
                                listView.height * 0.3 : descriptionText.contentHeight + titleText.contentHeight
                    anchors.topMargin: 50

                    color: colorPurple
                    radius: 10
                    border.width: 1
                    border.color: colorYellow


                    Rectangle{

                        id: columnRectangle
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.right: deleteButton.left
                        anchors.left: parent.left
                        anchors.margins: 10
                        color: colorPurple
                        radius: 10
                        border.width: 1
                        border.color: colorYellow


                        Column{

                            anchors.margins: 10
                            spacing: 10
                            Text{
                                id:titleText
                                anchors.fill: parent
                                wrapMode: TextEdit.Wrap
                                clip: true
                                text: delegateRectangle.title
                                font.pixelSize: 20
                                color: colorYellow

                            }
                            Text{
                                id:descriptionText
                                anchors.fill: parent
                                anchors.topMargin: titleText.contentHeight
                                text: delegateRectangle.description
                                font.pixelSize: 16
                                color: colorDarkGray
                                wrapMode: TextEdit.Wrap
                                clip: true

                            }
                        }
                    }

                    Rectangle{
                        id: deleteButton
                        implicitWidth: 80
                        radius: 10
                        color: colorYellow
                        anchors.top: delegateRectangle.verticalCenter
                        anchors.bottom: delegateRectangle.bottom
                        anchors.right: parent.right
                        anchors.margins: 10

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
                                }
                            }

                    }
                    Rectangle{
                        id: doneButton
                        implicitWidth: 80
                        radius: 10
                        color: colorYellow
                        anchors.bottom: delegateRectangle.verticalCenter
                        anchors.top: delegateRectangle.top
                        anchors.right: parent.right
                        anchors.margins: 10

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
                    id: addBtn
                    height: 50
                    width: rightRectangle.width * 0.8
                    radius: 10
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
                            listModel.append({"_title": titleToDo.text, "_description": descriptionToDo.text})
                            titleToDo.text=""
                            descriptionToDo.text=""
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
