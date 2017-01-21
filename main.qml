import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import FileIO 1.0


Window {
    visible: true
    width: 300
    height: 280
    title: qsTr("LineNum Adder 0.99")

    property int buttonWidth: 150
    property int buttonHeight: 40
    property int buttonRadius: buttonHeight/4


    FileDialog {
        id: fileDialogLoad
        folder: "."
        title: "Choose a file to open"
        selectMultiple: false
        nameFilters: [ "Text files (*.txt)", "All files (*)" ]
        onAccepted: {
            console.log("Accepted: " + fileDialogLoad.fileUrl)
            myFile.source = fileUrl;
            lastLineSpb.value = myFile.getLastLineNum();
            addlinebtn.enabled = true;
        }
        onRejected: {
            addlinebtn.enabled = false;
        }
    }

    FileIO {
        id: myFile
//        source: fileDialogLoad.fileUrl
        onError: console.log(msg)
    }

    Column{
        spacing: 10
        padding: 10

        Button {
            text: qsTr("Chose file")
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: fileDialogLoad.open();
        }

        Text{
            text: fileDialogLoad.fileUrl
        }

        Grid{
            columns: 2
            spacing: 10

            Text {
                text: qsTr("Last line:")
            }
            SpinBox{
                id: lastLineSpb
                value: 0
                maximumValue: 10000000
            }
            Text {
                text: qsTr("Lines to add:")
            }
            SpinBox{
                id: lineToAddSpb
                value: 10
            }
        }

        Button {
            id: addlinebtn

            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Add line")

            enabled: false
            onClicked: {
                console.log("Last line: " + lastLineSpb.value);
                console.log("Lines to add: " + lineToAddSpb.value);
                var startLine = lastLineSpb.value + 1
                var lastLine = startLine + lineToAddSpb.value;
                for(var i = startLine; i <= lastLine; i++)
                    myFile.write("\r\n"+i+".");
                lastLineSpb.value = lastLine;
            }
        }
    }
}
