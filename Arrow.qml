import QtQuick

Item {
    property var sourceCategory
    property var targetCategory

    width: Math.abs(targetCategory.x - sourceCategory.x)
    height: Math.abs(targetCategory.y - sourceCategory.y)
    anchors {
        left: Math.min(sourceCategory.x, targetCategory.x)
        top: Math.min(sourceCategory.y, targetCategory.y)
    }
    rotation: Math.atan2(targetCategory.y - sourceCategory.y, targetCategory.x - sourceCategory.x) * 180 / Math.PI

    Canvas {
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            ctx.lineWidth = 2;
            ctx.strokeStyle = "black";
            ctx.beginPath();
            ctx.moveTo(0, height / 2);
            ctx.lineTo(width, height / 2);
            ctx.stroke();

            // Draw arrowhead
            var arrowSize = 10;
            var arrowWidth = 6;
            var arrowHeight = 10;
            ctx.beginPath();
            ctx.moveTo(width - arrowSize, height / 2 - arrowWidth / 2);
            ctx.lineTo(width - arrowSize, height / 2 + arrowWidth / 2);
            ctx.lineTo(width - arrowSize - arrowHeight, height / 2);
            ctx.closePath();
            ctx.fillStyle = "black";
            ctx.fill();
        }
    }
}
