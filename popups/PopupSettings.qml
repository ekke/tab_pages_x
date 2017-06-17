// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import "../common"

Popup {
    id: popup
    property bool tabBarIsFixedSettings: tabBarIsFixed
    property int tabButtonDesignSettings: tabButtonDesign
    property bool tabBarInsideTitleBarSettings: tabBarInsideTitleBar
    // default behavior for this Popup: OK Button Clicked
    property bool isOk: true
    Material.elevation: 8
    x: parent.width - width - 12
    y: parent.height - height - 12
    width: Math.min(appWindow.width, appWindow.height) / 3 * 2
    height: Math.min(appWindow.height, theContent.height +10)

    Flickable {
        contentHeight: popup.height
        anchors.fill: parent
        // Attention: clip should be used carefully,
        // but using a ListView inside a Popup
        // you must set it to true
        // otherwise content will appear outside while scrolling
        // don't clip at Paopup: will cut the elevation shadow
        clip: true

        ColumnLayout {
            id: theContent
            anchors.right: parent.right
            anchors.left: parent.left
            spacing: 6
            LabelSubheading {
                text: qsTr("Settings TabBar")
                color: accentColor
            }
            RowLayout {
                Switch {
                    focusPolicy: Qt.NoFocus
                    topPadding: 6
                    leftPadding: 12
                    text: qsTr("Tabs Scrollable")
                    checked: !tabBarIsFixedSettings
                    onCheckedChanged: {
                        tabBarIsFixedSettings = !checked
                    }
                } // switch scrollable
            } // row switch scroll
            RowLayout {
                Switch {
                    focusPolicy: Qt.NoFocus
                    leftPadding: 12
                    text: qsTr("Tabs inside TitleBar")
                    checked: tabBarInsideTitleBar
                    onCheckedChanged: {
                        tabBarInsideTitleBarSettings = checked
                    }
                } // switch scrollable
            } // row switch inside
            RowLayout {
                Frame {
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 6
                        RadioButton {
                            id: radioText
                            focusPolicy: Qt.NoFocus
                            text: qsTr("Buttons Text only")
                            checked: tabButtonDesignSettings == 0
                            onCheckedChanged: {
                                tabButtonDesignSettings = 0
                            }
                        }
                        RadioButton {
                            id: radioIcon
                            focusPolicy: Qt.NoFocus
                            text: qsTr("Buttons Icon only")
                            checked: tabButtonDesignSettings == 1
                            onCheckedChanged: {
                                tabButtonDesignSettings = 1
                            }
                        }
                        RadioButton {
                            id: radioTextAndIcon
                            focusPolicy: Qt.NoFocus
                            text: qsTr("Buttons Icon and Text")
                            checked: tabButtonDesignSettings == 2
                            onCheckedChanged: {
                                tabButtonDesignSettings = 2
                            }
                        }
                    }
                }
            } // radiobuttons design


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

        ScrollIndicator.vertical: ScrollIndicator { }

    } // flickable

    function update() {
        if(isOk) {
            tabBarIsFixed = tabBarIsFixedSettings
            tabButtonDesign = tabButtonDesignSettings
            tabBarInsideTitleBar = tabBarInsideTitleBarSettings
        }
    }

} // popup
