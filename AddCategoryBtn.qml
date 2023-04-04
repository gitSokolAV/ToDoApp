import QtQuick

Rectangle{
    color: "Red"
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 50
    height: 50
    radius: 10
    width: setMinimumWidth(350)

    Text{
        anchors.centerIn: parent
        text: "Add Category"
        font.pixelSize: 36
    }
}
