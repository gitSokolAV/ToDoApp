import QtQuick
import QtQuick.Shapes

Item {
    property point startPoint
    property point endPoint
    property color lineColor: "black"

    Shape {
        ShapePath {
            strokeWidth: 2
            strokeColor: lineColor

            PathMove {
                x: startPoint.x
                y: startPoint.y
            }

            PathLine {
                x: endPoint.x
                y: endPoint.y
            }
        }
    }
}
