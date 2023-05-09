import QtQuick 2.0

Item{
    property int startX: 0
    property int startY: 0
    property int endX: 0
    property int endY: 0

    x: Math.min(startX, endX)
    y: Math.min(startY, endY)
    width: Math.abs(startX - endX)
    height: Math.abs(startY - endY)

    function angle() {
        return Math.atan2(endY - startY, endX - startX) * 180 / Math.PI;
    }

    rotation: angle()
    transformOrigin: Item.TopLeft

    Rectangle {
        anchors.fill: parent
        color: "red"
        border.width: 1
        border.color: "black"
        radius: 5
    }
}
