import QtQuick 2.12
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import Core.MongooseBackend 1.0

Dialog {
    property FileDialog fileDialog;
    property string location: "";
    property TextField mountPointTextField: mountPointTxt;
    property MongooseBackend server;

    visible: false;
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    title: "Add Mount Point"
    contentItem: GridLayout {
		id: addMountPointDialogContent
		anchors.fill: parent
		ColumnLayout {
			Layout.alignment: Qt.AlignHCenter
			TextField {
				validator: RegExpValidator { regExp: /^\w+$/ }
				id: mountPointTxt
				Layout.preferredWidth: 300
				horizontalAlignment: Qt.AlignHCenter
				placeholderText: qsTr("Mount Point")		
			}
			TextField {
				id: locationTxt
				Layout.preferredWidth: 300
				horizontalAlignment: Qt.AlignHCenter
				text: location
				placeholderText: qsTr("Location")		
				readOnly: true
			}

			Button {
				Layout.alignment: Qt.AlignHCenter
				id: browseLocationBtn
				text: qsTr("Browse Location")
				onClicked: fileDialog.open() 
			}
		}
	}
    standardButtons: StandardButton.Ok | StandardButton.Cancel
    onAccepted: {
	    visible = false;
	    if(locationTxt.text != ""  && 
	       mountPointTxt.text != ""){
		      server.addMountPoint(mountPointTxt.text, locationTxt.text);
	    }

    }
    onRejected: {
	    visible = false;
    }
}

 
