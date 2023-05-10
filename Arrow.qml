import QtQuick 2.0

Item {
    id: root
    width: 0
    height: 0
    property real length: 0
    property real width: 0
    property real angle: 0
    property color color: "black"

    Rectangle {
        id: line
        x: -width / 2
        y: 0
        width: length
        height: width
        color: color
        transform: Rotation {
            origin.x: width / 2
            origin.y: width / 2
            angle: root.angle
        }
    }

    Rectangle {
        id: head
        x: length - width / 2
        y: -width / 2
        width: width
        height: width
        color: color
        transform: Rotation {
            origin.x: width / 2
            origin.y: width / 2
            angle: root.angle
        }
    }
}
