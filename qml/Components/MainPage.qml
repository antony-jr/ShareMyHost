import QtQuick 2.12
import QtQuick.Layouts 1.13
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12

GridLayout {
	property ApplicationWindow mainWindow;
	property Button controlButton : startStopBtn;

	visible: mainWindow.showMainPage
	anchors.fill: parent
	columns: 2
	ColumnLayout {
		Layout.column: 0
		Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
		TextField {	
			id: infoLbl
			property string info: qsTr("HTTPS://192.168.1.3:8080")
			text: info
			Layout.preferredWidth: 240
			Layout.alignment: Qt.AlignHCenter
			horizontalAlignment: TextInput.AlignHCenter
			font.pixelSize: 20
			readOnly: true
			selectByMouse: true
		}
		Text {
			text: 
			qsTr("We are currently using the above address to host your file(s).")
			font.pixelSize: 15
			Layout.alignment: Qt.AlignHCenter
		}	
		RowLayout {
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			spacing: 10	

			Button {
				id: copyIpBtn
				objectName: "copyIpBtn"
				property string beforeText: qsTr("Copy Address")

				Layout.alignment: Qt.AlignHCenter
				text: beforeText
				Material.background: Material.Green
				highlighted: true	
			}
	
			Button {
				text: qsTr("Open in Browser")
				onClicked: Qt.openUrlExternally(infoLbl.text)
			}
		}
		Button {
			id: startStopBtn
			objectName: "startStopBtn"
			highlighted: true	
			property bool isClicked : false
			property string loadText: qsTr("Processing... ")
			property string beforeText: qsTr("Start Sharing")
			
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.preferredWidth: 200
			Layout.preferredHeight: 80
			text: beforeText
			Material.background: Material.Teal
			onClicked: {
				isClicked = !isClicked
				startStopBtn.text = loadText
				if(isClicked){
					// Start server
					mainServer.startServer();
				}else{
					// Stop server
					mainServer.stopServer();
				}
			}
		}

		Button {
			Layout.alignment: Qt.AlignHCenter
			text: qsTr("Show Mount Point(s)") 
			onClicked: {
				mainWindow.showMainPage = false
				mainWindow.showMountPage = true
			}
		}

		ToolSeparator{ 
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter	
			orientation: Qt.Horizontal
		
		}
		Pane {
			Material.elevation: 4
			Material.background: Material.Orange
			Layout.alignment: Qt.AlignHCenter
			Layout.topMargin: 30
			Text {
				horizontalAlignment: TextInput.AlignHCenter

				text: qsTr("Click on the 'Start Sharing' button to start the server!\n") +
				      qsTr("Make sure to add some mount points to access your local file(s).")
			}
		}
	} // Close ColumnLayout
}

