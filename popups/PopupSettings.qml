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
    property int tabButtonDesignSettings: tabButtonDesign
    property bool tabBarInsideTitleBarSettings: tabBarInsideTitleBar
    // default behavior for this Popup: OK Button Clicked
    property bool isOk: true
    x: parent.width - width
    width: Math.min(appWindow.width, appWindow.height) / 4 * 3
    height: header? appWindow.height - header.height : appWindow.height
    transformOrigin: Popup.BottomRight


    ColumnLayout {
        anchors.right: parent.right
        anchors.left: parent.left
        spacing: 10
        RowLayout {
            Switch {
                focusPolicy: Qt.NoFocus
                topPadding: 8
                leftPadding: 12
                text: qsTr("Tabs Scrollable")
                checked: !tabBarIsFixedSettings
                onCheckedChanged: {
                    tabBarIsFixedSettings = !checked
                }
            } // switch scrollable
        } // row label
        RowLayout {
            GroupBox {
                title: qsTr("Tab Button Design")
                ColumnLayout {
                    anchors.fill: parent
                    RadioButton {
                        id: radioText
                        focusPolicy: Qt.NoFocus
                        text: qsTr("Text only")
                        checked: tabButtonDesignSettings == 0
                        onCheckedChanged: {
                            tabButtonDesignSettings = 0
                        }
                    }
                    RadioButton {
                        id: radioIcon
                        focusPolicy: Qt.NoFocus
                        text: qsTr("Icon only")
                        checked: tabButtonDesignSettings == 1
                        onCheckedChanged: {
                            tabButtonDesignSettings = 1
                        }
                    }
                    RadioButton {
                        id: radioTextAndIcon
                        focusPolicy: Qt.NoFocus
                        text: qsTr("Icon and Text")
                        checked: tabButtonDesignSettings == 2
                        onCheckedChanged: {
                            tabButtonDesignSettings = 2
                        }
                    }
                }
            }
        } // radiobuttons design
        RowLayout {
            Switch {
                focusPolicy: Qt.NoFocus
                topPadding: 8
                leftPadding: 12
                text: qsTr("Tabs inside TitleBar")
                checked: tabBarInsideTitleBar
                onCheckedChanged: {
                    tabBarInsideTitleBarSettings = checked
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
                    isOk = false
                    popup.close()
                }
            } // cancelButton
            ButtonFlat {
                id: okButton
                text: qsTr("OK")
                textColor: accentColor
                onClicked: {
                    isOk = true
                    popup.close()
                }
            } // okButton
        } // row button

    } // col layout

    function cleanup() {
        if(isOk) {
            tabBarIsFixed = tabBarIsFixedSettings
            tabButtonDesign = tabButtonDesignSettings
            tabBarInsideTitleBar = tabBarInsideTitleBarSettings
        }
    }

} // popup
