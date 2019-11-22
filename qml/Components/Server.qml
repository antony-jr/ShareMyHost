import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.1

import Core.MongooseBackend 1.0

MongooseBackend {
	property ApplicationWindow mainWindow;
	property Button controlButton;

	onServerStarted: {
	    // Set server address
	    mainWindow.serverIp = serverAddress

	    controlButton.text = qsTr("Stop Sharing")
	    controlButton.Material.background = Material.Red

	    // Change picture status
	    mainWindow.serverStatusImg = "qrc:/server_on.png"
       }

       onServerStopped: {
	    controlButton.text = controlButton.beforeText
	    controlButton.Material.background = Material.Teal

	    mainWindow.serverStatusImg = "qrc:/server_off.png"	    
       }

       onError: {
	    controlButton.text = controlButton.beforeText
	    controlButton.Material.background = Material.Teal
	    mainWindow.serverStatusImg = "qrc:/server_off.png"	    
	    mainWindow.errorTitle = "Server Error"
    	    mainWindow.errorMessage = "The server could not start because: " + errorMessage + "."
	    mainWindow.showErrorDialog= true
       }
}

