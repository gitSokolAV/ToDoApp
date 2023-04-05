import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    color: '#040404'
    Rectangle{
        width: 500
        height: 500
        ListModel{
            id: theModel
        }
        GridView{
            anchors.fill: parent
            anchors.margins: 50
            anchors.bottomMargin: 50
            clip: true
            cellWidth: 60
            cellHeight: 60
            model: theModel
            delegate: componentRectangle
        }
        Component{
            id: componentRectangle
            Rectangle{
                id: rectangleModel
                required property int index
                required property int number
                color: "White"
                Text{
                    width: 50
                    height: 50
                    anchors.centerIn: parent
                    text: rectangleModel.number
                }
            }
        }
        AddCategoryBtn{
            property int count: 1
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    theModel.append({"number": ++parent.count})
                }
            }
        }
    }
}
