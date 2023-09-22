import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
Page {
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias buttonText: textNavButton.text
    signal buttonClicked();
    background: Rectangle{
        id: backgroundRect
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
