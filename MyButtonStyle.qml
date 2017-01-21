import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ButtonStyle {
    background: Rectangle {
        implicitWidth: 150
        implicitHeight: 40
        border.width: control.activeFocus ? 3 : 2
        border.color: "yellow"
        radius: height/4
        color: "green"
    }
}
