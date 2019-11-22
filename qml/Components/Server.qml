import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12

import Core.MongooseBackend 1.0

MongooseBackend {
	property ApplicationWindow mainWindow;
	property Button controlButton;
	onServerStarted: {
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
	    mainWindow.serverStatusImg = "qrc:/server_off.png"
	    console.log("Cannot start server")

       }
}

