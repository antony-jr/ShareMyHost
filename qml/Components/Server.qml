import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.1

import Core.MongooseBackend 1.0

MongooseBackend {
	property ApplicationWindow mainWindow;
	property Button controlButton;
	property ListModel listModel;

	onServerStarted: {
	    // Set server address
	    mainWindow.serverIp = "http://" + serverAddress

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

       onMountPoint: {
	       listModel.append({ "name": mountPoint})
       }

       onMountPointAdded: {
	       listModel.append({ "name": mountPoint })
       }

       onMountPointRemoved: {
	       var iter = 0;
	       while(iter < listModel.count){
		       if(listModel.get(iter).name == mountPoint){
			       listModel.remove(iter)
		       }
		       ++iter;
	       }
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

