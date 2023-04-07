import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    id:root
    color: "#8f43ee"
    height: 60

    signal newCategory(string nameCategory);

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
            color: "#000000"
        }
        Button{
            id:btnAdd
            text: "AddCategory"
            onClicked: {
                newCategory(catName.text)
                catName.clear();
            }
        }
    }
}


