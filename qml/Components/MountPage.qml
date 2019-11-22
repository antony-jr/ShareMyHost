import QtQuick 2.12
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.13
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12


ColumnLayout {
	property ApplicationWindow mainWindow;

	visible: mainWindow.showMountPage
	anchors.fill: parent
	RowLayout {
		RoundButton {
			id: mntBackBtn
			text: "\u2190"
			highlighted: true
			onClicked: {
				mainWindow.showMainPage = true
				mainWindow.showMountPage = false
			}
		}
		
		Text {
			id: mntPoinTxt
			text: qsTr("Mount Point(s)")
			font.pixelSize: 30
		}

		ToolSeparator {
			orientation: Qt.Horizontal
			Layout.preferredWidth: mainWindow.width - mntBackBtn.width - mntPoinTxt.width - addMountBtn.width - 60
		}

		Button {
			id: addMountBtn
			objectName: "addMountBtn"
			text: qsTr("Add Mount Point")
			onClicked: {
				mainWindow.showAddMountPointDialog = true
			}
		}
	}

	Pane {
		id: mountPointsPane
		objectName: "mountPointsPane"
		Layout.leftMargin: 55
		Layout.preferredWidth: mainWindow.width - 100
		Layout.preferredHeight: mainWindow.height - 130
		ColumnLayout {
			ScrollView {
				width: mainWindow.width - 100
				height: mainWindow.height - 150

                ListView {
                    id: mountPointsListView
                    objectName: "mountPointsListView"
                    width: mainWindow.width - 100
                    height: mainWindow.height - 150
/*
                    model: ListModel {
                        ListElement {
                            remote: "/Anime"
                            local: "/home/antonyjr/Anime"
                        }
                    }
*/

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
                } // Close ListView 
            } // Close ScrollView
        } // Close Pane.ColumnLayout
	} // Close Pane
} // Close main ColumnLayout
