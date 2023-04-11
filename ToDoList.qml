import QtQuick
import QtQuick.Window
import QtQuick.Controls

Page {
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias buttonText: navButton.text
    signal buttonClicked();

    background: Rectangle{
        id: backgroundRect
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
            text: "Bubble To Do List"
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
        anchors.bottom: parent.bottom

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
                width: parent.width * 0.7
                height: parent.height * 0.8
                anchors.centerIn: parent
                delegate: Rectangle{
                    property string title
                    property string description
                    title: _title
                    description: _description

                    id: delegateRectangle
                    width: listView.width
                    height: 100
                    color: colorPurple
                    radius: 10

                    Column{
                        anchors.fill: parent
                        anchors.margins: 10

                        Text {
                            text: delegateRectangle.title
                            font.pixelSize: 20
                            color: "green"
                        }
                        Text{
                            text: delegateRectangle.description
                            font.pixelSize: 16
                            color: "black"
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


                TextArea{
                    id: descriptionToDo
                    placeholderText: "Enter the To Do item description"
                    anchors.fill: parent
                    color: colorYellow
                    background: colorYellow

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

        //return Button
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



}
