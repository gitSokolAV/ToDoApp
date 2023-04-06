import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    id:root
    color: "lightGreen"
    height: 60

    signal newCategory(string category)

    RowLayout{
        anchors.fill: parent
        anchors.margins: 10

        TextField{
            id: catName
            selectByMouse: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter
            placeholderText: "New category name.."
            font.pointSize: 10
            color: "lightblue"
        }
        Button{
            id:btnAdd

            text: "Add Category"
            onClicked: {
                newCategory(catName.text);
                catName.clear();
            }
        }
    }


}


