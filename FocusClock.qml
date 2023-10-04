import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
Page {
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias buttonText: textNavButton.text
    property int numberRectValue: 5
    signal buttonClicked();
    background: Rectangle{
        id: backgroundRect
    }
    ListModel{
        id: timeModel
    }

    Rectangle{
        id: menuClock
        width: parent.width * 0.2
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: mainClock.left
        anchors.topMargin:  100
        anchors.bottomMargin: 100
        anchors.leftMargin: 100
        anchors.rightMargin: 20
        radius: 50
        color: "Yellow"
        Label{
            id: menuLabel
            height: 100
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10
            Text{
                id:menuLabelText
                text: "Menu"
                anchors.centerIn: parent
                font.pixelSize: 80
            }            
        }
        Rectangle{
            id: addFocusTimerButton
            height: 60
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: menuLabel.bottom
            anchors.margins: 10
            radius: 10
            border.width: 1
            border.color: colorPurple
            color: "Yellow"
            Text{
                id:addFocusTimerButtonText
                anchors.centerIn: parent
                font.pixelSize: 20
                text: "Add your own focus timer."
            }
            MouseArea{
                id: addFocusTimerButtonMouseArea
                anchors.fill: parent
                onClicked: {
                    focusTimerWindow.visible = true
                }
            }
        }
        Rectangle{
            id: timeModelRectangle
            anchors.top: addFocusTimerButton.bottom
            anchors.bottom: quitButton.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            radius: 10
            border.width: 1
            border.color: colorPurple
            color: colorYellow
            ListView{
                id: timeModelView
                model: timeModel
                spacing: 10
                clip: true
                anchors.fill: parent
                anchors.margins: 10
                delegate: Rectangle{
                    id: viewTimeRectangel
                    property int clickedIndex: -1
                    width: parent.width
                    height: 50
                    anchors.margins: 10
                    border.width: 1
                    border.color: colorPurple
                    radius: 10
                    MouseArea{
                        id:mouseAreaVTR
                        anchors.fill: parent
                        onClicked: {
                            timerText.text = numberRectValue
                        }
                    }

                    Text{
                        text: numberRectValue
                        anchors.centerIn: parent
                        font.pixelSize: 25
                    }
                    Rectangle{
                        id: deleteButton
                        width: 20
                        height: 20
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.margins: 10
                        radius:10
                        color: "Red"
                        Text{
                            anchors.centerIn: parent
                            text: "X"
                        }
                        MouseArea{
                            id: mouseAreaDeleteButton
                            anchors.fill: parent
                            onClicked: {
                                timeModel.remove(index)
                            }
                        }
                    }
                }
            }
        }

        Rectangle{
            id: quitButton
            height: 60
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 10
            anchors.bottomMargin: 50
            radius: 10
            border.width: 1
            border.color: colorPurple
            color: colorLightGray
            Text{
                id:quitButtonText
                anchors.centerIn: parent
                font.pixelSize: 20
                text: "Quit"
                color: colorYellow
            }
            MouseArea{
                id:quitButtonMouseArea
                anchors.fill: parent
                onClicked: {
                    Qt.quit()
                }
            }
        }

    }
    Rectangle{
        id: focusTimerWindow
        width: parent.width / 2
        height: parent.height / 2
        color: colorDarkGray
        radius: 50
        anchors.centerIn: parent
        z: 1
        visible: false
        Rectangle{
            id: titleTimerWindow
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 30
            height: 50
            color: colorLightGray
            radius: 10

            Text{
                anchors.centerIn: parent
                font.pixelSize: 30
                color: "White"
                text: "Timer range"
            }
        }


        Rectangle{
            id: mainTimerWindow
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: focusTimerSaveButton.top
            anchors.top: titleTimerWindow.bottom
            anchors.margins: 30
            radius: 10
            color: colorLightGray
            border.width: 1
            border.color: colorPurple
            Rectangle{
                id: leftButton
                anchors.left: parent.left
                anchors.right: numberRect.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 20
                height: mainTimerWindow.height / 4
                radius: 30
                color: colorDarkGray
                Text{
                    id: leftButtonText
                    font.pixelSize: 40
                    color: colorYellow
                    anchors.centerIn: parent
                    text: "-"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(numberRectValue === 5){
                            numberRectValue = 5
                        }
                        else{
                            numberRectValue -= 5
                        }
                    }
                }
            }
            Rectangle{
                id: numberRect
                anchors.left: leftButton.right
                anchors.centerIn: parent
                height: mainTimerWindow.height / 2
                width: mainTimerWindow.width / 3
                radius: 30
                color: colorDarkGray
                Text{
                    id: numberRectText
                    font.pixelSize: 40
                    color: colorYellow
                    anchors.centerIn: parent
                    text: numberRectValue + " min"
                }
            }
            Rectangle{
                id: rightButton
                anchors.right: parent.right
                anchors.left: numberRect.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 20
                height: mainTimerWindow.height / 4
                radius: 30
                color: colorDarkGray
                Text{
                    id: rightButtonText
                    font.pixelSize: 40
                    color: colorYellow
                    anchors.centerIn: parent
                    text: "+"
                }
                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        numberRectValue += 5
                    }
                }
            }
        }

        Rectangle{
            id: focusTimerSaveButton
            height: 50
            width: 100
            anchors.right: focusTimerCanselButton.left
            anchors.bottom: parent.bottom
            anchors.margins: 10
            anchors.rightMargin: 50
            radius: 10
            color: colorLightGray
            border.width: 1
            border.color: colorPurple
            Text{
                id:focusTimerSaveButtonText
                anchors.centerIn: parent
                font.pixelSize: 20
                color: "White"
                text: "Save"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    timeModel.append({"numberRectValue": numberRectValue})
                    focusTimerWindow.visible = false
                }
            }
        }
        Rectangle{
            id: focusTimerCanselButton
            height: 50
            width: 100
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 10
            anchors.rightMargin: 50
            radius: 10
            color: colorLightGray
            border.width: 1
            border.color: colorPurple
            Text{
                id:focusTimerCanselButtonText
                anchors.centerIn: parent
                font.pixelSize: 20
                color: "White"
                text: "Cansel"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    focusTimerWindow.visible = false
                }
            }
        }
    }

    Rectangle{
        id: mainClock
        width: parent.width * 0.7
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        color: "Yellow"
        anchors.margins: 100
        radius: 50
        Label{
            id: titleLabel
            height: 100
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10
            Text{
                id:titleLabelText
                text: "Focus Timer"
                anchors.centerIn: parent
                font.pixelSize: 80
            }            
        }
        Text{
            id:timerText
            anchors.verticalCenter: mainClock.verticalCenter
            anchors.horizontalCenter: mainClock.horizontalCenter
            text: "00:00:00"
            font.pixelSize: mainClock.width * 0.2
        }
        Rectangle{
            id: startButton
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: mainClock.horizontalCenter
            anchors.margins: 20
            height: 50
            width: parent.width / 4
            radius: 10
            color: colorPurple
            Text{
                id: startButtonText
                anchors.centerIn: parent
                font.pixelSize: 20
                text: "START"
                color: colorYellow
            }
            MouseArea{
                id: startButtonMouseArea
                anchors.fill: parent
                onClicked: {
                    if(startButtonText.text === "START")
                    {
                    startButtonText.text = "STOP"
                    }
                    else{
                        startButtonText.text = "START"
                    }
                }
            }
        }
    }



    Rectangle{
        id: navButton
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.margins: 10
        color: "White"
        radius: 10
        height: 50
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
