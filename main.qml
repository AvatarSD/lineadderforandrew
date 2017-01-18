import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import FileIO 1.0


Window {
    visible: true
    //    width: 640
    //    height: 480
    title: qsTr("Hello World")

    property int buttonWidth: 150
    property int buttonHeight: 40
    property int buttonRadius: buttonHeight/4

    Column{
        spacing: 10
        padding: 10

        FileDialog {
            id: fileDialogLoad
            folder: "."
            title: "Choose a file to open"
            selectMultiple: false
            nameFilters: [ "Text files (*.txt)", "All files (*)" ]
            onAccepted: {
                console.log("Accepted: " + fileDialogLoad.fileUrl)
                addlinebtn.enabled = true;
            }
            onRejected: {
                addlinebtn.enabled = false;
            }
        }

        FileIO {
            id: myFile
            source: fileDialogLoad.fileUrl
            onError: console.log(msg)
        }

        Button {
            width: buttonWidth
            height: buttonHeight
            text: qsTr("Chose file")

            onClicked: {
                fileDialogLoad.open();
            }


        }

        //Rectangle{
           // width: parent.width
           // height: 100

            Column{
                Row{
                    Text {
                        text: qsTr("Start number:")
                    }
                    TextEdit{
                        id: startNum
                        text: "0"
                    }
                }
                Row{
                    Text {
                        text: qsTr("Numbers:")
                    }
                    TextEdit{
                        id: numbersQty
                        text: "10"
                    }
                }
            }
        //}

        Button {
            id: addlinebtn
            width: buttonWidth
            height: buttonHeight
            text: qsTr("Add line")
            enabled: false
            onClicked: {
                //console.log(myFile.read());
//                var numbers = parseInt(numbersQty.text, 10)
//                var startnum = parseInt(startNum.text, 10)



            }


        }


    }
}
