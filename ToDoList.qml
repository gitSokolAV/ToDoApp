import QtQuick
import QtQuick.Window
import QtQuick.Controls

Page {
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias buttonText: navButton.text
    signal buttonClicked();

    background: Rectangle{
        id: backgroundRect
    }
    Rectangle{
        id: leftMenu
        width: 300
        color: "#413543"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        border.color: "#8F43EE"
        border.width: 1
        Rectangle{
            id: menuPage
            radius: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10
            Page{
                id:testMenu
                anchors.fill: menuPage

                header: AddCategoryBtn{
                    onNewCategory: {
                        //var newCat = {};
                        //newCat.text = nameCategory;
                        //listModel.append(newCat);
                        var addCat = nameCategory
                        listModel.append(addCat)
                    }
                }
                ListView{
                    id: listView
                    anchors.fill: parent
                    spacing: 10
                    model: listModel
                    clip: true
                    delegate: Rectangle{

                        radius: 10
                        height: 50
                        width: ListView.view.width
                        color: "lightgray"
                        border.color: "black"
                        Text{
                            anchors.centerIn: parent
                            text: modelData
                        }
                    }
                }
                ListModel{
                    id: listModel
                    ListElement{
                        text: "aaa"
                    }
                }
            }
        }
    }

    Button{
        id: navButton
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        onClicked: {
            root.buttonClicked();
        }
    }
}
