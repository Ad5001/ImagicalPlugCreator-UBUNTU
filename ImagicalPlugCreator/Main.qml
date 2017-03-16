import QtQuick 2.4;
import Qt.labs.folderlistmodel 2.1
import Ubuntu.Components 1.3;
import Ubuntu.Components.Popups 1.0;
import QtQuick.Window 2.2;
import Ubuntu.DownloadManager 1.2
import Ubuntu.Components.ListItems 1.3 as ListItem
import "Main.js" as Functions;

/*!
    \brief MainView with a Label and Button elements.
*/


MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "imagicalplugcreator.ad5001"

    width: units.gu(50)
    height: units.gu(75)

    Page {

        id: page
        title: i18n.tr("ImagicalPlugCreator - Name by Author")
        header: PageHeader {
            id: pageHeader
            title: i18n.tr("ImagicalPlugCreator - Name by Author")
            StyleHints {
                foregroundColor: UbuntuColors.orange
                backgroundColor: UbuntuColors.porcelain
                dividerColor: UbuntuColors.slate
                horizontalCenter: parent.horizontalCenter
            }
        }

        // First column, name.
        Column {
            id: labels
            width: parent.width * 0.25
            anchors {
                top: pageHeader.bottom
                topMargin: units.gu(3)
            }
            spacing: units.gu(2)

            // Name
            Label {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                height: units.gu(4)
                id: nameLabel
                objectName: "labelName"
                text: "Name: "
            }

            // Author
            Label {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                height: units.gu(4)
                id: authorLabel
                objectName: "labelAuthor"
                text: "Author: "
            }

            // Configs
            Label {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                height: units.gu(4)
                id: configLabel
                objectName: "labelConfig"
                text: "Config: "
            }

            // Events
            Label {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                height: units.gu(4)
                id: eventsLabel
                objectName: "labelEvents"
                text: "Events: "
            }

            // Tasks
            Label {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                height: units.gu(4)
                id: tasksLabel
                objectName: "labelTasks"
                text: "Tasks: "
            }

            // Dummies
            Label {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                height: units.gu(4)
                id: dumiesLabel
                objectName: "dumiesLabel"
                text: "Dummy files: "
            }
        }











        // Second column, inputs
        Column {
            id: inputs
            width: parent.width * 0.75
            anchors {
                top: pageHeader.bottom
                left: labels.right
                topMargin: units.gu(2)
            }
            spacing: units.gu(2)

            // Name
            TextField {
                validator: RegExpValidator{
                    regExp: /[A-Za-z_]{1}[A-Za-z\d_]{0,}/; // Matches only if made of letters and numbers (but do not starts with a number)
                }
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                width: parent.width * 0.8
                id: inputName
                objectName: "inputName"
                Keys.onReleased: {
                    Functions.refreshName(this.text, inputAuthor.text, i18n, page, pageHeader)
                }
            }

            //Author
            TextField {
                validator: RegExpValidator{
                    regExp: /[A-Za-z_]{1}[A-Za-z\d_]{0,}/; // Matches only if made of letters and numbers (but do not starts with a number)
                }
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                width: parent.width * 0.8
                id: inputAuthor
                objectName: "inputAuthor"
                Keys.onReleased: {
                    Functions.refreshName(inputName.text, this.text, i18n, page, pageHeader)
                }
            }

            //Config
            CheckBox {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                height: units.gu(4)
                width: units.gu(4)
                checked: false
                id: checkConfig
                objectName: "checkConfig"

            }

            //Events
            CheckBox {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                height: units.gu(4)
                width: units.gu(4)
                checked: false
                id: checkEvents
                objectName: "checkEvents"
            }



            // Tasks
            Column {
                id: tasks
                width: parent.width * 0.75
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    topMargin: units.gu(2)
                }
                spacing: units.gu(2)

                function addRow() {
                    this.children[this.children.length] = Qt.createQmlObject('import QtQuick 2.4; import Ubuntu.Components 1.3; TextField {anchors {horizontalCenter: parent.horizontalCenter;} validator: RegExpValidator{regExp: /[A-Za-z_]{1}[A-Za-z\d_]{0,}/;} text: i18n.tr("Task' + this.children.length + '"); }',
                                                          this,
                                                          "dynamicSnippet1")
                    dumiesLabel.anchors.topMargin = (this.children.length - 1) * units.gu(8);
                }

                function delRow() {
                    if(this.children.length - 1 == 0) return; // Would be a bad idea to destroy the buttons :p
                    this.children[this.children.length - 1].destroy();
                    this.children[this.children.length - 1] = undefined;
                    dumiesLabel.anchors.topMargin = (this.children.length - 1) * units.gu(8);
                }

                function getRows() {
                    var childs = [];
                    for(var i = 1; i < this.children.length; i++) {
                        childs[i] = this.children[i].text;
                    }
                    childs.slice(0, 0);
                    return childs;
                }

                Row {
                    width: parent.width
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }

                    Button {
                        text: i18n.tr("+")
                        width: this.height
                        onClicked: {parent.parent.addRow()}
                    }

                    Button {
                        text: i18n.tr("-")
                        width: this.height
                        onClicked: {parent.parent.delRow()}
                    }
                }
            }



            // Dummies
            Column {
                id: dummies
                width: parent.width * 0.75
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    topMargin: units.gu(2)
                }
                spacing: units.gu(2)

                function addRow() {
                    this.children[this.children.length] = Qt.createQmlObject('import QtQuick 2.4; import Ubuntu.Components 1.3; TextField {anchors {horizontalCenter: parent.horizontalCenter;} validator: RegExpValidator{regExp: /[A-Za-z_]{1}[A-Za-z\d_]{0,}/;} text: i18n.tr("Dummy' + this.children.length + '"); }',
                                                          this,
                                                          "dynamicSnippet1")
                }

                function delRow() {
                    if(this.children.length - 1 == 0) return; // Would be a bad idea to destroy the buttons :p
                    this.children[this.children.length - 1].destroy();
                    this.children[this.children.length - 1] = undefined;
                }

                function getRows() {
                    var childs = [];
                    for(var i = 1; i < this.children.length; i++) {
                        childs[i] = this.children[i].text;
                    }
                    childs.slice(0, 0);
                    return childs;
                }

                Row {
                    width: parent.width
                    Button {
                        text: i18n.tr("+")
                        width: this.height
                        onClicked: {parent.parent.addRow()}
                    }

                    Button {
                        text: i18n.tr("-")
                        width: this.height
                        onClicked: {parent.parent.delRow()}
                    }
                }
            }

        }

        Button {
            id: build
            objectName: "button"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: inputs.bottom
                topMargin: units.gu(2)
            }
            height: inputAuthor.height
            width: parent.width
            text: i18n.tr("Create plugin base!")
            onClicked: {
                // splash.show()
                Functions.buildPlugin(inputName.text, inputAuthor.text, checkConfig.checked, checkEvents.checked, tasks.getRows(), dummies.getRows(), download)
            }

            SingleDownload {
                id: download
                allowMobileDownload: true
                autoStart: true
                metadata: Metadata {
                    showInIndicator: true
                    extract: true
                    title: inputName.text
                }
                onFinished: {
                    console.log(download.errorMessage);
                    alert.display("Your plugin base can be found at <br>" + path + ".", "Plugin base finished !")
                }
            }
        }


        ProgressBar {
            minimumValue: 0
            maximumValue: 100
            value: download.progress
            anchors {
                left: build.left
                right: build.right
                top: build.bottom
                topMargin: units.gu(3)
            }
        }




        // Dialog
        Window {
            id: splash
            title: "Choose a folder."
            modality: Qt.SubWindow
            width: units.gu(50)
            height: units.gu(75)
            FolderListModel {
                id: pickedPath
                showDirs: true
                showDotAndDotDot: true
                showFiles: false
                folder: "/home"
                nameFilters: [ "*" ]
            }

            ListView {
                anchors.fill: parent
                model: pickedPath
                delegate: ListItem.SingleValue {
                    text: model.fileName
                    onClicked: {console.log(model.filePath); pickedPath.folder = model.filePath}
                }

            }

            Button {
                text: "Pick"
                color: UbuntuColors.orange
                onClicked: {
                    Functions.buildPlugin(inputName.text, inputAuthor.text, checkConfig.checked, checkEvents.checked, tasks.getRows(), dummies.getRows(), pickedPath.folder)
                    splash.close()
                }
            }
            //flags: Qt.SplashScreen
            property int timeoutInterval: 2000
            signal timeout
        }

        // Alert:
        Window {
            id: alert
            modality: Qt.SubWindow
            width: units.gu(90)
            height: units.gu(30)

            PageHeader {
                StyleHints {
                    backgroundColor: UbuntuColors.porcelain
                    foregroundColor: UbuntuColors.orange
                    fontSize: units.gu(5);
                }
                id: alertLabel
                title: ""
            }

            Button {
                text: "Ok"
                onClicked: alert.hide()
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: alertLabel.bottom
                    topMargin: units.gu(5)
                }
            }

            function display(message, title) {
                alertLabel.title = message
                this.title = title
                this.show()
            }
        }
    }
}
