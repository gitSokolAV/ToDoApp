import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import QtQml
import BackEnd
import QtMultimedia
Page {
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias buttonText: textNavButton.text
    property int numberRectValue: 0
    property int timerMinutesRemaining: 5 * 60
    property string viewTimeRectangleColor: colorDarkGray
    property bool ticking: false
    property string firstColor: colorPurple
    property string secondColor: colorYellow
    signal buttonClicked();
    SoundEffect{
        id: endTime
        source: "audio/sound.wav"
    }
    SoundEffect{
        id: secondsTime
        source: "audio/sound2.wav"
    }

    background: Rectangle{
        id: backgroundRect
    }
    ListModel{
        id: timeModel
    }
    BackEnd{
        id: backend
    }
    Timer {        
        running: ticking
        repeat: true
        interval: 1000
        onTriggered: {
            if(timerMinutesRemaining === 0) {
                timerText.text = "00:00:00";
                ticking = false;
                startButtonText.text = "START";
                endTime.play();
            } else {
                if(textStopSoundBtn.text === "Sound Off"){
                    secondsTime.play();
                    timerMinutesRemaining -= 1;
                    backend.timeFromInt = timerMinutesRemaining.toString();
                    timerText.text = backend.timeFromInt;
                }
                else{
                    secondsTime.stop();
                    timerMinutesRemaining -= 1;
                    backend.timeFromInt = timerMinutesRemaining.toString();
                    timerText.text = backend.timeFromInt;
                }
            }
        }
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
        color: secondColor
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
            border.color: firstColor
            color: secondColor
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
            border.color: firstColor
            color: secondColor
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
                    border.color: firstColor
                    color: viewTimeRectangleColor
                    radius: 10
                    MouseArea{
                        id:mouseAreaVTR
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: {
                            if (mouse.button === Qt.RightButton) {

                                menuPopUp.popup();
                            }
                            else{
                                timerMinutesRemaining = numberRectValue * 60;
                                backend.timeFromInt = timerMinutesRemaining.toString();
                                timerText.text = (timerMinutesRemaining / 60).toString() + " min";
                            }
                        }
                    }
                    Menu{
                        id:menuPopUp
                        MenuItem{
                            text: "Change color"
                            onClicked: {
                                colorDialog.open();
                            }
                        }
                    }
                    Dialog{
                        id: colorDialog
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
                                var newColor = colorDialogOpen.selectedColor;
                                var clickedObjectIndex = mouseAreaVTR.clickedIndex;

                                timeModel.setProperty(clickedObjectIndex, "viewTimeRectangeColor", newColor)
                            }
                        }
                    }

                    Text{
                        text: numberRectValue + " min"
                        anchors.centerIn: parent
                        font.pixelSize: 25
                        color: "red"
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
            border.color: firstColor
            color: secondColor
            Text{
                id:quitButtonText
                anchors.centerIn: parent
                font.pixelSize: 20
                text: "Quit"
                color: firstColor
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
            border.color: firstColor

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
                    color: secondColor
                    anchors.centerIn: parent
                    text: "-"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(timerMinutesRemaining >= 5){
                            timerMinutesRemaining -= 5 * 60
                        }
                        else{
                            numberRectValue = 5
                        }
                        backend.timeFromInt = timerMinutesRemaining.toString();
                        timerText.text = backend.timeFromInt;
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
                    color: secondColor
                    anchors.centerIn: parent
                    text: timerMinutesRemaining / 60 + " min"
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
                    color: secondColor
                    anchors.centerIn: parent
                    text: "+"
                }
                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        timerMinutesRemaining += 5 * 60 ;
                        backend.timeFromInt = (timerMinutesRemaining).toString();
                        timerText.text = backend.timeFromInt;
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
            border.color: firstColor
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
                    timeModel.append({"numberRectValue": timerMinutesRemaining / 60,
                                      "viewTimeRectangleColor": colorDarkGray})
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
            border.color: firstColor
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
        color: secondColor
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
            color: firstColor
            visible: true
        }
        Rectangle{
            id: pauseButton
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: stopButton.left
            anchors.margins: 20
            height: 50
            width: parent.width / 3
            radius: 10
            color: firstColor
            visible: false
            Text{
                id: pauseButtonText
                anchors.centerIn: parent
                font.pixelSize: 20
                text: "PAUSE"
                color: secondColor
            }
            MouseArea{
                id: pauseButtonMouseArea
                anchors.fill: parent
                onClicked: {
                    if(timerMinutesRemaining !== 0 && pauseButtonText.text === "PAUSE"){
                        ticking = false;                        
                        pauseButtonText.text = "START";
                    }
                    else if(timerMinutesRemaining !== 0 && pauseButtonText.text === "START"){
                        ticking = true;
                        pauseButtonText.text = "PAUSE";
                    }

                }
            }
        }
        Rectangle{
            id: stopButton
            anchors.bottom: parent.bottom
            anchors.left: parent.Center
            anchors.right: parent.right
            anchors.margins: 20
            height: 50
            width: parent.width / 3
            radius: 10
            color: firstColor
            visible: false
            Text{
                id: stopButtonText
                anchors.centerIn: parent
                font.pixelSize: 20
                text: "STOP"
                color: secondColor
            }
            MouseArea{
                id: stopButtonMouseArea
                anchors.fill: parent
                onClicked: {
                    timerMinutesRemaining = 0;
                    ticking = true;
                    pauseButton.visible = false;
                    stopButton.visible = false;
                    startButton.visible = true;
                }
            }
        }

        Rectangle{
            id: startButton
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: mainClock.horizontalCenter
            anchors.margins: 20
            height: 50
            width: parent.width / 4
            radius: 10
            color: firstColor
            visible: true
            Text{
                id: startButtonText
                anchors.centerIn: parent
                font.pixelSize: 20
                text: "START"
                color: secondColor
            }
            MouseArea{
                id: startButtonMouseArea
                anchors.fill: parent

                onClicked: {
                    if(timerMinutesRemaining === 0){
                        startButtonText.text = "START";
                        ticking = false;
                    }
                    else if(timerMinutesRemaining !== 0){
                        ticking = true;
                        startButton.visible = false;
                        pauseButton.visible = true;
                        stopButton.visible = true;
                    }
                }
            }
        }
    }

    Rectangle{
            id: fullScreenRect
            anchors.top: parent.top
            anchors.bottom: fullScreenBtn.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            radius: 10
            color: firstColor

            visible: false
            Label{
                id: fullScreenLabel
                text: timerText.text
                font.pixelSize: parent.width * 0.2
                anchors.centerIn: parent
                color: secondColor
                visible: true
            }
        }
    Dialog{
        id: changeColorDialog
        width: 180
        height: 170
        title: "Select Color"
        standardButtons: Dialog.Ok | Dialog.Cancel
        Button {
            id: firstColorBtn
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 5
            height: 50
            text: "First Color"
            onClicked: {
                firstChangeColorDialogOpen.open();
            }
        }
        Button {
            id: secondColorBtn
            anchors.top: firstColorBtn.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 5
            height: 50
            text: "Second Color"
            onClicked: {
                secondChangeColorDialogOpen.open();
            }
        }
        ColorDialog{
            id: firstChangeColorDialogOpen
            onAccepted: {
                var newColor = firstChangeColorDialogOpen.selectedColor;
                firstColor = newColor;
            }
        }
        ColorDialog{
            id: secondChangeColorDialogOpen
            onAccepted: {
                var newColor = secondChangeColorDialogOpen.selectedColor;
                secondColor = newColor;
            }
        }
    }
    Rectangle{
        id: stopSoundBtn
        anchors.right: colorBtn.left
        anchors.bottom: parent.bottom
        anchors.margins: 10
        color: "White"
        radius: 10
        height: 50
        width: textStopSoundBtn.width + 20
        visible: true
        TextArea{
            id: textStopSoundBtn
            text: "Sound Off"
            anchors.centerIn: parent
            font.pixelSize: 16
            color: backgroundColor
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(timerMinutesRemaining !== 0 && textStopSoundBtn.text === "Sound Off"){
                    textStopSoundBtn.text = "Sound On";
                }
                else{
                    textStopSoundBtn.text = "Sound Off";
                }
            }
        }
    }

    Rectangle{
        id: colorBtn
        anchors.right: fullScreenBtn.left
        anchors.bottom: parent.bottom
        anchors.margins: 10
        color: "White"
        radius: 10
        height: 50
        width: textColorBtn.width + 20
        visible: true
        TextArea{
            id: textColorBtn
            text: "Change color"
            anchors.centerIn: parent
            font.pixelSize: 16
            color: backgroundColor
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                changeColorDialog.open();
            }
        }

    }
    Rectangle{
        id: visibleTextLabelBtn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.margins: 10
        color: "White"
        radius: 10
        height: 50
        width: textVisibleTextLabelBtn.width + 20
        visible: false
        TextArea{
           id: textVisibleTextLabelBtn
           text: "Hide Timer"
           anchors.centerIn: parent
           font.pixelSize: 16
           color: "RED"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(textVisibleTextLabelBtn.text === "Hide Timer"){
                    textVisibleTextLabelBtn.text = "Show Timer";
                   fullScreenLabel.visible = false;
                }
                else if(textVisibleTextLabelBtn.text === "Show Timer"){
                    textVisibleTextLabelBtn.text = "Hide Timer";
                    fullScreenLabel.visible = true;
                }
            }
        }
    }

    Rectangle{
        id: fullScreenBtn
        anchors.right: navButton.left
        anchors.bottom: parent.bottom
        anchors.margins: 10
        color: "White"
        radius: 10
        height: 50
        width: textFullScreenBtn.width + 20
        TextArea{
            id: textFullScreenBtn
            text: "Full Screen"
            anchors.centerIn: parent
            font.pixelSize: 16
            color: backgroundColor
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(timerMinutesRemaining !== 0 && textFullScreenBtn.text === "Full Screen"){
                    fullScreenRect.visible = true;
                    visibleTextLabelBtn.visible = true;
                    textFullScreenBtn.text = "Exit full screen mode";
                    colorBtn.visible = false
                }
                else if(timerMinutesRemaining !== 0 && textFullScreenBtn.text === "Exit full screen mode"){
                    fullScreenRect.visible = false;
                    visibleTextLabelBtn.visible = false;
                    colorBtn.visible = true;
                    textFullScreenBtn.text = "Full Screen"
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
