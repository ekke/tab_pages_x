// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

Button {
    id: button
    // image should be 24x24
    property alias imageName: theIcon.imageName
    property alias imageSize: theIcon.imageSize
    focusPolicy: Qt.NoFocus
    contentItem:
        IconActive {
        id: theIcon
    }
    background:
        Rectangle {
        id: buttonBackground
        implicitHeight: 48
        Layout.minimumWidth: 88
        color: button.pressed ? accentColor : "transparent"
        opacity: button.pressed ? 0.12 : 1.0
    } // background
}
