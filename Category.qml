import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs

Page {
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias buttonText: navButton.text

    signal buttonClicked();


    background: Rectangle{
        id: backgroundRect
    }
    Component {
            id: newRectComponent
            Rectangle {
                width: 50
                height: 50
                color: colorPurple
                property bool isDragging: false
                property string name: "Category"

                MouseArea {
                    anchors.fill: parent
                    onPressed: isDragging = true
                    onReleased: isDragging = false
                    onPositionChanged: {
                        if(isDragging) {
                            parent.x += mouse.x - width / 2;
                            parent.y += mouse.y - height / 2;
                        }
                    }
                }

                Text {
                    text: name
                    anchors.centerIn: parent
                }
            }
        }

        Button {
            text: "Add new category"
            onClicked: {
                var dialog = nameDialog.createObject(null);
                dialog.accepted.connect(function() {
                    var newRect = newRectComponent.createObject(container);
                    newRect.x = Math.random() * (container.width - newRect.width);
                    newRect.y = Math.random() * (container.height - newRect.height);
                    newRect.name = dialog.textInput.text;
                });
                dialog.open();
            }
        }

        Item {
            id: container
            anchors.fill: parent
        }

        Component {
            id: nameDialog
            Dialog {
                id: dialog
                parent: root
                title: "Enter name for new category"
                standardButtons: Dialog.Ok | Dialog.Cancel
                TextField {
                    id: textInput
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width * 0.8
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
