// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import "common"
import "pages"

// This app demonstrates HowTo use Qt 5.7 new Qt Quick Controls 2, High DPI and more
// This app is NOT a production ready app
// This app's goal is only to help you to understand some concepts
// see blog http://j.mp/qt-x to learn about Qt 5.7 for Material - styled Android or iOS Apps
// learn about this tab_pages_x app from this article: http://bit.ly/qt-tab-pages-x
// ekke (Ekkehard gentz) @ekkescorner

ApplicationWindow {
    id: appWindow
    // visibile must set to true - default is false
    visible: true
    // primary and accent properties:
    property variant primaryPalette: myApp.defaultPrimaryPalette()
    property color primaryLightColor: primaryPalette[0]
    property color primaryColor: primaryPalette[1]
    property color primaryDarkColor: primaryPalette[2]
    property color textOnPrimaryLight: primaryPalette[3]
    property color textOnPrimary: primaryPalette[4]
    property color textOnPrimaryDark: primaryPalette[5]
    property string iconOnPrimaryLightFolder: primaryPalette[6]
    property string iconOnPrimaryFolder: primaryPalette[7]
    property string iconOnPrimaryDarkFolder: primaryPalette[8]
    property variant accentPalette: myApp.defaultAccentPalette()
    property color accentColor: accentPalette[0]
    property color textOnAccent: accentPalette[1]
    property string iconOnAccentFolder: accentPalette[2]
    Material.primary: primaryColor
    Material.accent: accentColor
    // theme Dark vs Light properties:
    property variant themePalette: myApp.defaultThemePalette()
    property color dividerColor: themePalette[0]
    property color cardAndDialogBackground: themePalette[1]
    property real primaryTextOpacity: themePalette[2]
    property real secondaryTextOpacity: themePalette[3]
    property real dividerOpacity: themePalette[4]
    property real iconActiveOpacity: themePalette[5]
    property real iconInactiveOpacity: themePalette[6]
    property string iconFolder: themePalette[7]
    property int isDarkTheme: themePalette[8]
    property color flatButtonTextColor: themePalette[9]
    property color popupTextColor: themePalette[10]
    // Material.dropShadowColor  OK for Light, but too dark for dark theme
    property color dropShadow: isDarkTheme? "#E4E4E4" : Material.dropShadowColor
    onIsDarkThemeChanged: {
        if(isDarkTheme == 1) {
            Material.theme = Material.Dark
        } else {
            Material.theme = Material.Light
        }
    }
    // font sizes - defaults from Google Material Design Guide
    property int fontSizeDisplay4: 112
    property int fontSizeDisplay3: 56
    property int fontSizeDisplay2: 45
    property int fontSizeDisplay1: 34
    property int fontSizeHeadline: 24
    property int fontSizeTitle: 20
    property int fontSizeSubheading: 16
    property int fontSizeBodyAndButton: 14 // is Default
    property int fontSizeCaption: 12
    // fonts are grouped into primary and secondary with different Opacity
    // to make it easier to get the right property,
    // here's the opacity per size:
    property real opacityDisplay4: secondaryTextOpacity
    property real opacityDisplay3: secondaryTextOpacity
    property real opacityDisplay2: secondaryTextOpacity
    property real opacityDisplay1: secondaryTextOpacity
    property real opacityHeadline: primaryTextOpacity
    property real opacityTitle: primaryTextOpacity
    property real opacitySubheading: primaryTextOpacity
    // body can be both: primary or secondary text
    property real opacityBodyAndButton: primaryTextOpacity
    property real opacityBodySecondary: secondaryTextOpacity
    property real opacityCaption: secondaryTextOpacity
    //

    header: SwipeTextTitle {
        id: titleBar
        backToolButtonVisible: false
        text: qsTr("HowTo move from A to B")
    }

    FloatingActionButton {
        id: fab
        property string imageName: "/settings.png"
        z: 1
        anchors.margins: 16
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        imageSource: "qrc:/images/"+iconOnAccentFolder+imageName
        backgroundColor: accentColor
        onClicked: {
            showInfo("TODO: Settings TabBar:\nfix vs scrolling\ntop vs bottom\ntext, icon, text+icon")
        }
    } // FAB

    TabBar {
        id: bar

        // tabbar at bottom TODO
        // position: TabBar.Footer
        // anchors.bottom: parent.bottom
        // SwipeView reposition
        // FAB reposition

        anchors.left: parent.left
        anchors.right: parent.right
        currentIndex: 0
        onCurrentIndexChanged: {
            navPane.currentIndex = currentIndex
        }
        Repeater {
            model: ["Car", "Bus", "Subway", "Truck", "Flight"]
            TabButton {
                text: modelData
                width: undefined // Math.max(112, bar.width / 5)
            }
        } // repeater
    }

    SwipeView {
        id: navPane
        focus: true
        // anchors.fill: parent
        anchors.top: bar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        currentIndex: bar.currentIndex
        // currentIndex is the NEXT index swiped to
        onCurrentIndexChanged: {
            bar.currentIndex = currentIndex
            switch(currentIndex) {
                case 1:
                    pageThreeLoader.active = true
                    break;
                case 2:
                    pageThreeLoader.active = true
                    pageFourLoader.active = true
                    break;
                case 3:
                    pageThreeLoader.active = true
                    pageFourLoader.active = true
                    pageFiveLoader.active = true
                    break;
                case 4:
                    pageFourLoader.active = true
                    pageFiveLoader.active = true
                    break;
            }
        }

        // support of BACK key
        property bool firstPageInfoRead: false
        Keys.onBackPressed: {
            event.accepted = navPane.currentIndex > 0 || !firstPageInfoRead
            if(navPane.currentIndex > 0) {
                onePageBack()
                return
            }
            // first time we reached first tab
            // user gets Popupo Info
            // hitting again BACK will close the app
            if(!firstPageInfoRead) {
                firstPageReached()
            }
            // We don't have to manually cleanup loaded Pages
            // While shutting down the app, all loaded Pages will be deconstructed
            // and cleanup called
        }

        // some keyboard shortcuts if:
        // * running on BlackBerry PRIV (Slider with hardware keyboard)
        // * or attached Bluetooth Keyboard
        // Jump to Page 1 (w), 2 (e), 3 (r), 4 (s), 5(d)
        // Goto next tab: 'n' or 'space'
        // Goto previous tab: 'p' or 'shift' + 'space'
        Shortcut {
            sequence: "w"
            onActivated: navPane.goToPage(0)
        }
        Shortcut {
            sequence: "Alt+w"
            onActivated: navPane.goToPage(0)
        }
        Shortcut {
            sequence: "e"
            onActivated: navPane.goToPage(1)
        }
        Shortcut {
            sequence: "Alt+e"
            onActivated: navPane.goToPage(1)
        }
        Shortcut {
            sequence: "r"
            onActivated: navPane.goToPage(2)
        }
        Shortcut {
            sequence: "Alt+r"
            onActivated: navPane.goToPage(2)
        }
        Shortcut {
            sequence: "s"
            onActivated: navPane.goToPage(3)
        }
        Shortcut {
            sequence: "Alt+s"
            onActivated: navPane.goToPage(3)
        }
        Shortcut {
            sequence: "d"
            onActivated: navPane.goToPage(4)
        }
        Shortcut {
            sequence: "Alt+d"
            onActivated: navPane.goToPage(4)
        }
        // n == NEXT
        Shortcut {
            sequence: "n"
            onActivated: navPane.onePageForward()
        }
        // p == PREVIOUS
        Shortcut {
            sequence: "p"
            onActivated: navPane.onePageBack()
        }
        Shortcut {
            sequence: " "
            onActivated: navPane.onePageForward()
        }
        Shortcut {
            sequence: "Shift+ "
            onActivated: navPane.onePageBack()
        }
        function onePageBack() {
            if(navPane.currentIndex == 0) {
                firstPageReached()
                return
            }
            navPane.goToPage(currentIndex - 1)
        } // onePageBack

        function onePageForward() {
            if(navPane.currentIndex == 4) {
                lastPageReached()
                return
            }
            navPane.goToPage(currentIndex + 1)
        }

        function goToPage(pageIndex) {
            if(pageIndex == navPane.currentIndex) {
                // it's the current page
                return
            }
            if(pageIndex > 4 || pageIndex < 0) {
                return
            }
            navPane.currentIndex = pageIndex
        } // goToPage
        // Page 1 and 2 preloaded to be able to swipe
        // other pages will be lazy loaded first time they're needed
        Loader {
            // index 0
            id: pageOneLoader
            active: true
            source: "pages/PageOne.qml"
            onLoaded: item.init()
        }
        Loader {
            // index 1
            id: pageTwoLoader
            active: true
            source: "pages/PageTwo.qml"
            onLoaded: item.init()
        }
        Loader {
            // index 2
            id: pageThreeLoader
            active: false
            source: "pages/PageThree.qml"
            onLoaded: item.init()
        }
        Loader {
            // index 3
            id: pageFourLoader
            active: false
            source: "pages/PageFour.qml"
            onLoaded: item.init()
        }
        Loader {
            // index 4
            id: pageFiveLoader
            active: false
            source: "pages/PageFive.qml"
            onLoaded: item.init()
        }

    } // navPane

    function switchPrimaryPalette(paletteIndex) {
        primaryPalette = myApp.primaryPalette(paletteIndex)
    }
    function switchAccentPalette(paletteIndex) {
        accentPalette = myApp.accentPalette(paletteIndex)
    }

    // we can loose the focus if Menu or Popup is opened
    function resetFocus() {
        navPane.focus = true
    }

    //
    PopupPalette {
        id: popup
        onAboutToHide: {
            resetFocus()
        }
    }

    function firstPageReached() {
        popupInfo.text = qsTr("No more Tabs\nLeftmost Tab reached")
        popupInfo.buttonText = qsTr("OK")
        popupInfo.open()
        navPane.firstPageInfoRead = true
    }
    function lastPageReached() {
        popupInfo.text = qsTr("No more Tabs\nRightmost Tab reached")
        popupInfo.buttonText = qsTr("OK")
        popupInfo.open()
    }
    function pageNotValid(pageNumber) {
        popupInfo.text = qsTr("Page %1 not valid.\nPlease tap 'Done' Button","").arg(pageNumber)
        popupInfo.buttonText = qsTr("So Long, and Thx For All The Fish")
        popupInfo.open()
    }
    function showInfo(info) {
        popupInfo.text = info
        popupInfo.buttonText = qsTr("OK")
        popupInfo.open()
    }

    // Unfortunately no SIGNAL if end or beginning reached from SWIPE GESTURE
    // so at the moment user gets no visual feedback
    // TODO Bugreport
    PopupInfo {
        id: popupInfo
        onAboutToHide: {
            popupInfo.stopTimer()
            resetFocus()
        }
    } // popupInfo

    // TODO PopupSettings


} // app window
