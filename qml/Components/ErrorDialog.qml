import QtQuick 2.12
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Dialog {
    property ApplicationWindow mainWindow;

    x: (mainWindow.width - width) / 2
    y: (mainWindow.height - height) / 2
    title: mainWindow.errorTitle
    visible: mainWindow.showErrorDialog
    contentItem: GridLayout {
		anchors.fill: parent
		ColumnLayout {
			Layout.alignment: Qt.AlignHCenter
			Text {
				text: mainWindow.errorMessage
				font.pixelSize: 14
			}
		}
	}
    standardButtons: StandardButton.Ok | StandardButton.Cancel
    onAccepted: {
	    mainWindow.showErrorDialog = false
    }
    onRejected: {
	    mainWindow.showErrorDialog = false
    }
}

 
