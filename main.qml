import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4
import FileIO 1.0


Window {
    visible: true
    width: mainColumn.width
    height:  mainColumn.height
    title: qsTr("S.D. Adder 1.0")

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
        onError: console.log(msg)
    }

    Rectangle{
        id: backgroundRect
        anchors.fill: parent
        z:-1
        color: "#c5ff19"
    }

    Column{
        id: mainColumn
        spacing: 10
        padding: 10
        Button {
            text: qsTr("Chose file")
            anchors.horizontalCenter: parent.horizontalCenter
            style: MyButtonStyle{}
            onClicked: {
                fileDialogLoad.open();
                resultTextBox.text = "";
            }
        }

        Text{
            text: fileDialogLoad.fileUrl
        }

        Grid{
            columns: 2
            spacing: 10
            verticalItemAlignment: Grid.AlignVCenter

            Text {
                text: qsTr("Last line:")
                font.family: "Helvetica"
                    font.pointSize: 12
            }
            SpinBox{
                id: lastLineSpb
                value: 0
                maximumValue: 10000000
                style: MySpinBoxStyle{}
            }
            Text {
                text: qsTr("Lines to add:")
                font.family: "Helvetica"
                    font.pointSize: 12
            }
            SpinBox{
                id: lineToAddSpb
                value: 10
                width: lastLineSpb.width
                style: MySpinBoxStyle{}
            }
        }

        Button {
            id: addlinebtn
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Add line")
            style: MyButtonStyle{}
            enabled: false
            onClicked: {
                console.log("Last line: " + lastLineSpb.value);
                console.log("Lines to add: " + lineToAddSpb.value);
                var startLine = lastLineSpb.value + 1
                var lastLine = startLine + lineToAddSpb.value;
                for(; startLine < lastLine; startLine++)
                    myFile.write("\n"+startLine+".");
                lastLineSpb.value = startLine-1;
                resultTextBox.text = "OK";
            }
        }

        Text {
            id: resultTextBox
            text: ""
            font.family: "Helvetica"
            font.pointSize: 24
            color: "green"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
