//import related modules
import QtQuick 2.12
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.13
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12


ApplicationWindow {
    id: root
    title: qsTr("Share My Host")
    width: 800
    height: 500
    minimumWidth: 500
    minimumHeight: 500
    visible: true

    property bool showMainPage: true
    property bool showMountPage: false
    property bool showAboutPage: false

    Material.theme: Material.Light

    menuBar: MenuBar {
        Menu {
	    title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
	    }
        }
	Menu {
	    title: qsTr("Help")
	    MenuItem {
		text: qsTr("Check for Update")
	    }
	    MenuItem {
		text: qsTr("About")
		onTriggered: {
			showMainPage = false;
			showMountPage = false;
			showAboutPage = true;
		}
	    }
	}
    }

    GridLayout {
	id: aboutPage
	visible: showAboutPage
	anchors.fill: parent
	ColumnLayout {
		Layout.alignment: Qt.AlignHCenter
		RoundButton {
			text: "\u2190"
			highlighted: true
			onClicked: {
				showMainPage = true
				showMountPage = false
				showAboutPage = false
			}
		}
		
			RowLayout{
				Layout.alignment: Qt.AlignHCenter
				Image {
				cache: true
				fillMode: Image.PreserveAspectFit
				Layout.preferredWidth: 145
				Layout.preferredHeight: 145
				source: "qrc:/logo.png"
				}
				Image {
				Layout.alignment: Qt.AlignHCenter
				cache: true
				fillMode: Image.PreserveAspectFit
				Layout.preferredWidth: 136
				Layout.preferredHeight: 68
				source: "qrc:/gplv3.png"
				}

			}
			Label {
				text: qsTr("This program is licensed under GNU General Public License.<br>") +
				      qsTr("Copyright \u00A9 Antony Jr.<br>") +
				      qsTr("Program Logo by <a href=https://icons8.com>Icons8</a>.<br><br><br>") +
				      qsTr("Share My Host is a simple program to share your local file(s)<br>")+
				      qsTr("within your local network. Free and Open Source.<br>")      
				font.pixelSize: 20
				wrapMode: Text.WordWrap
				textFormat: Text.RichText
				onLinkActivated: Qt.openUrlExternally(link)
			}

			}
    }

    property bool showAddMountPointDialog: false
    property string locationStr: qsTr("")

    FileDialog {
    	id: localFolderDialog;
    	title: "Please select a folder for Mount Point";
    	folder: shortcuts.home;
	selectFolder: true
    	onAccepted: {
		locationStr = localFolderDialog.folder.toString()
	}
    }

    Dialog {
    id: addMountPointDialog
    visible: showAddMountPointDialog
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    title: "Add Mount Point"
    contentItem: GridLayout {
		id: addMountPointDialogContent
		anchors.fill: parent
		ColumnLayout {
			Layout.alignment: Qt.AlignHCenter
			TextField {
				id: mountPointTxt
				Layout.preferredWidth: 300
				horizontalAlignment: Qt.AlignHCenter
				placeholderText: qsTr("Mount Point")		
			}
			TextField {
				id: locationTxt
				Layout.preferredWidth: 300
				horizontalAlignment: Qt.AlignHCenter
				text: locationStr
				placeholderText: qsTr("Location")		
			}

			Button {
				Layout.alignment: Qt.AlignHCenter
				id: browseLocationBtn
				text: qsTr("Browse Location")
				onClicked: localFolderDialog.open() 
			}
		}
	}
    standardButtons: StandardButton.Ok | StandardButton.Cancel
    onAccepted: {
	    showAddMountPointDialog = false
	    /*
	    if(locationTxt.text == ""  || 
	       mountPointTxt.text == ""){

	    }
	    */
    }
    onRejected: {
	    showAddMountPointDialog = false
    }
    }

    ColumnLayout {
	id: mountPage
	objectName: "mountPage"
	visible: showMountPage
	anchors.fill: parent
	RowLayout {
		RoundButton {
			id: mntBackBtn
			text: "\u2190"
			highlighted: true
			onClicked: {
				showMainPage = true
				showMountPage = false
			}
		}
		
		Text {
			id: mntPoinTxt
			text: qsTr("Mount Point(s)")
			font.pixelSize: 30
		}

		ToolSeparator {
			orientation: Qt.Horizontal
			Layout.preferredWidth: root.width - mntBackBtn.width - mntPoinTxt.width - addMountBtn.width - 60
		}

		Button {
			id: addMountBtn
			objectName: "addMountBtn"
			text: qsTr("Add Mount Point")
			onClicked: {
				showAddMountPointDialog = true
			}
		}
	}

	Pane {
		id: mountPointsPane
		objectName: "mountPointsPane"
		Layout.leftMargin: 55
	//	Material.elevation: 3
		Layout.preferredWidth: root.width - 100
		Layout.preferredHeight: root.height - 130
		ColumnLayout {
		ScrollView {
			width: root.width - 100
			height: root.height - 150

		ListView {
			id: mountPointsListView
			objectName: "mountPointsListView"
			width: root.width - 100
			height: root.height - 150


			model: ListModel {
				ListElement {
					remote: "/Anime"
					local: "/home/antonyjr/Anime"
				}
			}

			delegate: RowLayout {
				spacing: 0
				Pane {
					Material.background: Material.Orange
					Text {
						text: remote
						font.pixelSize: 15
					}
				}

				Pane {
					Material.background: Material.Blue
					Text {
						text: "\u21B9"
						font.pixelSize: 15
					}
				}

				Pane {
					Material.background: Material.Red
					Text {
						text: local
						font.pixelSize: 15
					}
				}
			}
		}
		}
		}
	}
    }

    GridLayout {
	id: mainPage   
	visible: showMainPage
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
			property string beforeText: qsTr("Start Sharing")
			property string afterText: qsTr("Stop Sharing")
			
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.preferredWidth: 200
			Layout.preferredHeight: 80
			text: beforeText
			Material.background: Material.Teal
			onClicked: {
				isClicked = !isClicked
				if(isClicked){
					startStopBtn.text = afterText
					startStopBtn.Material.background = Material.Red
				}else{
					startStopBtn.text = beforeText
					startStopBtn.Material.background = Material.Teal
				}
			}
		}

		Button {
			Layout.alignment: Qt.AlignHCenter
			text: qsTr("Show Mount Point(s)") 
			onClicked: {
				showMainPage = false
				showMountPage = true
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
}
