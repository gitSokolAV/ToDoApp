import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import QtQml

Page {
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias buttonText: textNavButton.text

    signal buttonClicked();

    background: Rectangle{
        id: backgroundRect
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
