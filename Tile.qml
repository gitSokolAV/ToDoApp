import QtQuick

Rectangle{
    id: root
    color: "Yellow"
    border.width: 1
    border.color: "Black"
    radius:10

    Text{
        id: textTile
        anchors.centerIn: root
        text: "1"
        font.pixelSize: 26
        font.bold: true
    }
}
