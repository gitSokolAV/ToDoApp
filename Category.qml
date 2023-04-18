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

    ListModel{
        id:pageListModel
    }

    Page{
        StackView{
            id: pageStackView
            anchors.fill: parent
        }

        Rectangle{
            id: leftRect
            width: parent.width / 2
            height: parent.height
            anchors.left: parent.left

            }

            ListView{
                id: pagelistView
                model: pageListModel
                anchors.fill: leftRect
                delegate: Text{
                    text: "Page" + (index + 1)
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            var page = stackView.push(Qt.resolvedUrl("ToDoList.qml"))
                            pageListModel.setProperty(index, "page", page)
                        }
                    }


                }

            }
        }
        Rectangle{
            width: parent.width / 2
            height: parent.height
            anchors.right: parent.right
            color: "green"

            Button{
                text: "AAD"
                onClicked: {
                    pageListModel.append({"page": null})
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
