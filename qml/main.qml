//import related modules
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

//window containing the application
ApplicationWindow {

    title: qsTr("Share My Host")
    width: 800
    height: 500
    visible: true

    Material.theme: Material.Dark

    //menu containing two menu items
    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: console.log("Open action triggered");
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    //Content Area

    //a button in the middle of the content area
    Button {
        text: qsTr("Hello World")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}
