import QtQuick 2.12
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4
import QtQuickControls 2.12
import QtQuick.Controls.Material 2.12

import Core.MongooseBackend 1.0

GridLayout {
	property ApplicationWindow mainWindow;
	property ListModel listModel;
	property MongooseBackend server;
	property Dialog dialog;

	visible: mainWindow.showMountPage
	anchors.fill: parent
	anchors.top: parent.top
	anchors.left: parent.left
	anchors.right: parent.right
	anchors.bottom: parent.bottom
	columns: 1
        rows: 2	

	Pane {
	    Material.elevation: 4
	    Layout.preferredWidth: parent.width - 100
	    Layout.preferredHeight: parent.height - controls.height - 50
	    Layout.row: 0
	    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
	    Layout.topMargin: 10

	    ScrollView {
		    width: parent.width - 10
		    height: parent.height - 60
		    ScrollBar.vertical.policy: ScrollBar.AlwaysOn

		    ListView {
			    id: mountPointList
			    width: parent.width
			    height: parent.height 

			    model: listModel

			    delegate: RowLayout {
			       width: parent.width - 10
			       Text {
				       Layout.alignment: Qt.AlignLeft
				       text: name
				       font.pixelSize: 16
			       }

			       RowLayout {  
				       Layout.rightMargin: 10
				       Layout.alignment: Qt.AlignRight	      
				       RoundButton {
				       		Material.background: Material.Red
						text: "\u00D7"
						onClicked: {
							server.removeMountPoint(name)
						}
			       	       }
		               }
		    	    } // Close delegate property
		    } // Close ListView
	    } // Close ScrollView
        } // Close Pane

	ColumnLayout {
	    id: controls
	    Layout.preferredWidth: parent.width - 50
	    Layout.row: 1
	    Layout.bottomMargin: 20
	    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom	    
	    ToolSeparator {
		    Layout.preferredWidth: parent.width / 2
		    Layout.alignment: Qt.AlignHCenter
		    orientation: Qt.Horizontal
	    }
	    
	    Button {
		    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
		    id: addMountBtn
		    objectName: "addMountBtn"
		    text: qsTr("Add Mount Point")
		    onClicked: {
			 dialog.location = "";
	                 dialog.mountPointTextField.text = "";
			 dialog.visible = true;
		    }
	    }
       } // Close ColumnLayout 
} // Close main GridLayout
