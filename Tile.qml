import QtQuick

Rectangle{
    id: root
    property string displayText: ""
    property alias internalText: textTile

    color: "Yellow"
    border.width: 1
    border.color: "Black"
    radius:10

    Text{
        id: textTile
        anchors.centerIn: root
        text: root.displayText
        font.pixelSize: 26
        font.bold: true
    }
}
