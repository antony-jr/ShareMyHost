import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12

import Core.MongooseBackend 1.0

MongooseBackend {
	property Button controlButton;
	onServerStarted: {
	    controlButton.text = qsTr("Stop Sharing")
	    controlButton.Material.background = Material.Red
       }

       onServerStopped: {
	    controlButton.text = btn.beforeText
	    controlButton.Material.background = Material.Teal	
       }

       onError: {
	    console.log("Cannot start server")
       }
}

