import QtQuick

Item {
    property alias sourceItem: source
    property alias targetItem: target

    property color lineColor: "black"
    property int lineWidth: 2

    Rectangle {
        id: line
        width: Math.sqrt(Math.pow(target.x - source.x, 2) + Math.pow(target.y - source.y, 2))
        height: lineWidth
        color: lineColor
        rotation: Math.atan2(target.y - source.y, target.x - source.x) * 180 / Math.PI
        anchors {
            left: source.right
            top: source.bottom
        }
    }

    Item {
        id: source
        anchors.fill: sourceItem
    }

    Item {
        id: target
        anchors.fill: targetItem
    }
}
