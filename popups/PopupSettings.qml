// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import "../common"

Popup {
    id: popup
    property bool tabBarIsFixedSettings: tabBarIsFixed
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    implicitHeight: parent.height * .7
    implicitWidth: parent.width * .7
    ColumnLayout {
        anchors.right: parent.right
        anchors.left: parent.left
        spacing: 20
        RowLayout {
            SwitchWithLeftLabel {
                topPadding: 6
                leftPadding: 8
                text: qsTr("Tabs Scrollable")
                checked: !tabBarIsFixedSettings
                onCheckedChanged: {
                    tabBarIsFixedSettings = !checked
                }
            } // switch scrollable
        } // row label
        RowLayout {
            ButtonFlat {
                id: cancelButton
                text: qsTr("Cancel")
                textColor: popupTextColor
                opacity: opacityBodySecondary
                onClicked: {
                    popup.close()
                }
            } // cancelButton
            ButtonFlat {
                id: okButton
                text: qsTr("OK")
                textColor: accentColor
                onClicked: {
                    tabBarIsFixed = tabBarIsFixedSettings
                    popup.close()
                }
            } // okButton
        } // row button
    } // col layout

} // popup
