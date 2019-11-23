import QtQuick 2.12
import QtQuick.Controls 2.12

MenuBar {
	property ApplicationWindow mainWindow; 
        Menu {
	    title: qsTr("File")
	    MenuItem {
                text: qsTr("Dashboard")
		onTriggered: {
			mainWindow.showMainPage = true;
			mainWindow.showMountPage = false;
			mainWindow.showAboutPage = false;	
		}
	    }

	    MenuItem {
                text: qsTr("Mount Points")
		onTriggered: {
			mainWindow.showMainPage = false;
			mainWindow.showMountPage = true;
			mainWindow.showAboutPage = false;
		}
	    }
  
	    MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
	    }
        }
	Menu {
	    title: qsTr("Help")
	    MenuItem {
		text: qsTr("About")
		onTriggered: {
			mainWindow.showMainPage = false;
			mainWindow.showMountPage = false;
			mainWindow.showAboutPage = true;
		}
	    }
        }
}

