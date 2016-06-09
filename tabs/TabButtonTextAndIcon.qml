// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import "../common"

TabButton {
    height: 72
    contentItem:
        Item {
        Image {
            id: contentImage
            // anchors.centerIn: parent
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            y: 12
            horizontalAlignment: Image.AlignHCenter
            source: "qrc:/images/"+iconFolder+"/"+modelData.icon
        }
        ColorOverlay {
            id: colorOverlay
            anchors.fill: contentImage
            source: contentImage
            color: index == navPane.currentIndex ? accentColor : Qt.lighter(accentColor)
        }
        LabelBody {
            topPadding: 6
            anchors.top: contentImage.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            font.capitalization: Font.AllUppercase
            font.weight: Font.Medium
            color: index == navPane.currentIndex ? accentColor : Qt.lighter(accentColor)
            text: modelData.name
        }
    } // content item



}
