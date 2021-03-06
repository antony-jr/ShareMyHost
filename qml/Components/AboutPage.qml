import QtQuick 2.12
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12


GridLayout {
	property ApplicationWindow mainWindow;

	visible: mainWindow.showAboutPage
	anchors.fill: parent
	anchors.top: parent.top
	anchors.left: parent.left
	anchors.right: parent.right
	anchors.bottom: parent.bottom
	columns: 1
        rows: 1


	ColumnLayout {
	      	Layout.preferredWidth: parent.width - 100
	    	Layout.preferredHeight: parent.height - 50
	    	Layout.row: 0
	    	Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
	    	Layout.topMargin: 10

		RowLayout{
				Layout.alignment: Qt.AlignHCenter
				Image {
					cache: true
					fillMode: Image.PreserveAspectFit
					Layout.preferredWidth: 175
					Layout.preferredHeight: 175
					source: "qrc:/logo.png"
				}

		}

		Label {
			Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
			Layout.preferredWidth: parent.width - 100
			horizontalAlignment: Qt.AlignHCenter
			verticalAlignment: Qt.AlignTop
			text: qsTr("This program is licensed under GNU General Public License V2.<br>") +
			      qsTr("Copyright \u00A9 Antony Jr.<br>") +
			      qsTr("All Icons by <a href=https://icons8.com>Icons8</a>.<br>")
			font.pixelSize: 18
			wrapMode: Text.WordWrap
			textFormat: Text.RichText
			onLinkActivated: Qt.openUrlExternally(link)
		}
	}
}
