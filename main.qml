import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    color: '#040404'

    Page{
        id: page
        anchors.fill: parent

        Rectangle{
            id: menuPage
            radius: 10
            width: 300
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.margins: 40
            color: "darkgrey"
            Page{
                id:testMenu
                anchors.fill: menuPage
                header: AddCategoryBtn{
                    onNewCategory: {
                        var newCat = {};
                        newCat.text = category;
                        listModel.append(newCat)
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
                        width: listView.width
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


                }
            }
        }
    }
}



