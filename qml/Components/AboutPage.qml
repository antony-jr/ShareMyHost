import QtQuick 2.12
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.13
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12


GridLayout {
	property ApplicationWindow mainWindow;

	visible: mainWindow.showAboutPage
	anchors.fill: parent
	ColumnLayout {
		Layout.alignment: Qt.AlignHCenter
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
