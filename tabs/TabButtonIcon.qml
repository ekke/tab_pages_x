// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

TabButton {
    height: 48
    contentItem:
        Item {
        Image {
            id: contentImage
            anchors.centerIn: parent
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter
            source: "qrc:/images/"+iconFolder+"/"+modelData.icon
        }
        ColorOverlay {
            id: colorOverlay
            anchors.fill: contentImage
            source: contentImage
            color: accentColor
        }
    } // item
}
