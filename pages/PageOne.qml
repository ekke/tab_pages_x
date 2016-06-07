// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

import "../common"

Flickable {
    id: flickable
    contentHeight: root.implicitHeight
    // StackView manages this, so please no anchors here
    // anchors.fill: parent
    property string name: "PageOne"
    property string title: qsTr("Car")

    Pane {
        id: root
        anchors.fill: parent
        ColumnLayout {
            anchors.right: parent.right
            anchors.left: parent.left
            LabelHeadline {
                leftPadding: 10
                text: qsTr("Drive by Car")
            }
            HorizontalDivider {}
            RowLayout {
                LabelSubheading {
                    topPadding: 6
                    bottomPadding: 6
                    leftPadding: 10
                    rightPadding: 10
                    wrapMode: Text.WordWrap
                    text: qsTr("Navigate between Pages:\n* Swipe with your fingers\n* Tap on a Tab\n* Tap on a Button\n\nTap on 'Settings' Button to configure TabBar\n\nFrom 'Option Menu' (three dots) placed top right in ToolBar you can switch Theme and change primary / accent colors\n\nBluetooth keyboard attached or BlackBerry PRIV?\n* Type '1', '2', '3', '4', '5' to go to the specific Tab\n* 'Space' or 'n' for the next Tab\n* 'Shift Space' or 'p' for the previous Tab\n")
                }
            }
            HorizontalDivider {}
            RowLayout {
                // implicite fillWidth = true
                spacing: 10
                Item {
                    // dummi placeholder
                    Layout.preferredWidth : 1
                    Layout.fillWidth: true
                }
                ButtonRaised {
                    id: button2
                    text: "Bus"
                    onClicked: {
                        navPane.goToPage(1)
                    }
                }
                Item {
                    // dummi placeholder
                    Layout.preferredWidth : 1
                    Layout.fillWidth: true
                }
            } // button row
        } // col layout
    } // root
    ScrollIndicator.vertical: ScrollIndicator { }

    // emitting a Signal could be another option
    Component.onDestruction: {
        cleanup()
    }

    function whoAmI() {
        return qsTr("Message from Page One [0]")
    }
    // called immediately after Loader.loaded
    function init() {
        console.log(qsTr("Init done from One [0]"))
    }
    // called from Component.destruction
    function cleanup() {
        console.log(qsTr("Cleanup done from One [0]"))
    }
} // flickable
