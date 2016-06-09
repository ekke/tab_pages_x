// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import "../common"

ColumnLayout {
    property alias text: myTitleBar.text
    property alias currentIndex: myTabBar.currentIndex
    SwipeTextTitle {
        id: myTitleBar
        backToolButtonVisible: false
        Layout.fillWidth: true
    }
    TabBar {
        id: myTabBar
        anchors.top: myTitleBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        currentIndex: 0
        onCurrentIndexChanged: {
            navPane.currentIndex = currentIndex
        }
        Repeater {
            model: tabButtonTextModel
            TabButton {
                text: modelData
                width: tabBarIsFixed? myTabBar.width / tabButtonTextModel.length  : Math.max(112, myTabBar.width / tabButtonTextModel.length)
            }
        } // repeater
    }
}
