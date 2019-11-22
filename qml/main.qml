import QtQuick 2.12
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.13
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12

import "./Components" as Components

ApplicationWindow {
    id: root
    title: qsTr("Share My Host")
    width: 800
    height: 500
    minimumWidth: 500
    minimumHeight: 500
    visible: true
    Material.theme: Material.Light // Use google material design
    
    /* Components.MainMenu is a MenuBar QML Object.
     * This is a Customized Object which takes a ApplicationWindow.
     * This expects all the properties on changing pages to be 
     * present. */
    menuBar: Components.MainMenu {
        id: mainMenu
        mainWindow: root
    }
    
    /*
     * These properties are used by some other 
     * components to navigate through different 
     * screens in the Application.
    */
    property bool showMainPage: true // Default page
    property bool showMountPage: false
    property bool showAboutPage: false
    property bool showAddMountPointDialog: false
    property string locationStr: qsTr("")

    /* 
     * Folder select dialog box which is used by 
     * the 'Add Mount Point' Dialog.
     *
     * The 'Browse Location' triggers this dialog.
      */
     FileDialog {
	id: localFolderDialog;
	title: "Select Mount Point";
	folder: shortcuts.home;
	selectFolder: true
	onAccepted: {
		// Change location to reflect the selection in the 
		// mountPointDialog.
		mountPointDialog.location = localFolderDialog.folder.toString()
	}
     }
     /* -- FileDialog -- */

    /* 
     * This is a Modal Dialog which will be shown when 
     * required to Add a new Mount Point.
     *
     * This requires the about FileDialog. 
     *
     * The 'location' is a string property which modifies the 
     * text of the Location TextField inside the Dialog.
     */
    Components.MountPointDialog {
	id: mountPointDialog
	mainWindow: root
	fileDialog: localFolderDialog
    }
    /* -- MountPointDialog -- */
    
    /* All the Pages. */
    Components.AboutPage {
	id: aboutPage
	mainWindow: root
    } 

    Components.MountPage {
	id: mountPage
	mainWindow: root
    }

    Components.MainPage {
        id: mainPage
	mainWindow: root
    }
    // -- End All Pages -- 

    /*
     * The main Mongoose Server QML bindings. This QML Object is just a wrapper
     * but it has deep connection to C++ code.
     *
     * Properties:
     *    controlButton -> The id of the button which controls the server,
     *                     we just change the text and other stuff when 
     *                     the server starts and closes.
     */
    Components.Server {
        id: mainServer
        controlButton: mainPage.controlButton
    }
}
