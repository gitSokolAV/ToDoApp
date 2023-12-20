import QtQuick

Rectangle{
    id: root
    property string displayText: ""
    property alias internalText: textTile

    color: colorYellow
    border.width: 1
    border.color: "Black"
    radius: width / 2

    Text{
        id: textTile
        anchors.centerIn: root
        text: root.displayText
        font.pixelSize: 26
        font.bold: true
    }
}
