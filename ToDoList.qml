import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs


Page {
    id: toDoList    

    Rectangle{
        id: backgroundRect
        color: purpleColor
    }
    ListModel{
        id: listModel
    }

    Rectangle{
        id: topRectangle
        height: 50
        width: parent.width
        color: colorPurple
        anchors.top: parent.top

        Text{
            //text: "Bubble To Do List"
            text: "To Do List from : " + categoryName
            font.bold: true
            font.pixelSize: 40
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 50
            color: colorYellow
        }
    }
    Item{
        width: parent.width
        anchors.top: topRectangle.bottom
        anchors.bottom: bottomRectangle.top

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
                            //anchors.fill: columnRectangle
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
    }
    Item{
        id: rightItem
        width: parent.width / 2
        height: parent.height
        anchors.right: parent.right
        Column{
            anchors.top: parent.top
            anchors.topMargin: 100
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                id: textFieldRectangle
                width: rightItem.width * 0.8
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
                width: rightItem.width * 0.8
                height: rightItem.height * 0.6
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
            Button{
                text: "Add"
                height: 50
                width: rightItem.width * 0.5
                onClicked: {
                    listModel.append({"_title": titleToDo.text, "_description": descriptionToDo.text})
                    titleToDo.text=""
                    descriptionToDo.text=""
                }
            }
        }
    }
    Rectangle{
        id: bottomRectangle
        height: 50
        width: parent.width
        color: colorPurple
        anchors.bottom: parent.bottom
        Button {
            id: colorButton
            text: "Change Color"
            anchors.right:  addCategoryButton.left
            anchors.bottom: parent.bottom
            anchors.margins: 10
            onClicked: {
                colorDialog.open()
            }
            ColorDialog{
                id: colorDialog
                title: "please choose a color"
                onAccepted: {
                    topRectangle.color = colorDialog.selectedColor
                    bottomRectangle.color = colorDialog.selectedColor
                }
            }
        }
        //return Button
        Button{
            id: navButton
            text: "Back"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 10
            onClicked: {
                stackView.pop()
            }
        }
    }
}
