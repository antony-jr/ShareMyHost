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
		Image {
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter 
			cache: true
			fillMode: Image.PreserveAspectFit
			Layout.preferredWidth: 100
			Layout.preferredHeight: 100
			source: mainWindow.serverStatusImg
		}
	
		TextField {	
			id: infoLbl
			objectName: "ipInfoLbl"
			text: mainWindow.serverIp
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
			font.pixelSize: 12
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
			property string loadText: qsTr("Processing... ")
			property string beforeText: qsTr("Start Sharing")
			
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.preferredWidth: 200
			Layout.preferredHeight: 80
			text: beforeText
			Material.background: Material.Teal
			onClicked: {
				startStopBtn.text = loadText
				mainServer.toggleServer();
			}
		}
	} // Close ColumnLayout
}

