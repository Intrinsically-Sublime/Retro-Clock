import QtQuick 2.4
import Ubuntu.Components 1.3
import Qt.labs.settings 1.0
import QtSystemInfo 5.0
import QtQuick.Window 2.2

Window {
    id: root_window

    property bool isFullscreen: true
    property bool isLandscape: main_view.width > main_view.height
    property bool isDayMode: false
    property bool displaySeconds: false
    property bool displayAlarms: true
    property bool displayDate: true
    property bool moveNumbers: false
    property string time_24: "000000"
    property string time_12: "000000ap"
    property string time_analog: "000000ap"
    property int sec_analog: 0
    property string this_day: Qt.formatDateTime(new Date(), "dddd")
    property date test_time: new Date(1996,4,21,09,14)
    property string time_format: "hh:mm"
    property string this_time: Qt.formatDateTime(new Date(), time_format)
    property date test_date: new Date(1996,4,21)
    property string date_format: "d MMMM yyyy"
    property string this_date: Qt.formatDateTime(new Date(), date_format)
    property color back_color: "#000"
    property color back_color_day: "#fff"
    property color text_color: UbuntuColors.red
    property color text_color_day: "#000"
    property string color_edited // find out if text_color or back_color is edited in custom color setting
    property string clock_theme: "tha/"
    property string clock_theme_day: "thc/"
    property string selected_theme: isDayMode ? clock_theme_day : clock_theme
    property real alarm_del_h: 0

    function updateTime()
    {
        time_24 = Qt.formatDateTime(new Date(), "hhmmss")
        time_12 = Qt.formatDateTime(new Date(), "hhmmssap")
        this_day = Qt.formatDateTime(new Date(), "dddd")
        this_date = Qt.formatDateTime(new Date(), date_format)
    }

    function updateTimeAnalog()
    {
        time_analog = Qt.formatDateTime(new Date(), "hhmmssap")
        this_day = Qt.formatDateTime(new Date(), "dddd")
        this_date = Qt.formatDateTime(new Date(), date_format)
    }
    title: i18n.tr("Night Clock")
    width: units.gu(40)
    height: units.gu(90)
    minimumWidth: units.gu(40)
    minimumHeight: units.gu(80)
    visibility: isFullscreen ? Window.FullScreen : Window.AutomaticVisibility

    onSelected_themeChanged: selected_theme === "analog" ? updateTimeAnalog()
                                                         : updateTime()

    ScreenSaver {
        screenSaverEnabled: !Qt.application.active
    }

    MainView {
        id: main_view

        // Note! applicationName needs to match the "name" field of the click manifest
        applicationName: "nightclock.mivoligo"

        backgroundColor: page_stack.depth <= 1 ? "#000" : "#f7f7f7"

        anchors.fill: parent

        Settings {
            property alias background_colour: root_window.back_color
            property alias foreground_colour: root_window.text_color
            property alias background_colour_day: root_window.back_color_day
            property alias foreground_colour_day: root_window.text_color_day
            property alias is_day_mode: root_window.isDayMode
            property alias is_fullscreen: root_window.isFullscreen
            property alias current_date_format: root_window.date_format
            property alias current_time_format: root_window.time_format
            property alias isDisplayingSeconds: root_window.displaySeconds
            property alias isDisplayingAlarms: root_window.displayAlarms
            property alias isDisplayingDate: root_window.displayDate
            property alias current_theme: root_window.clock_theme
            property alias current_theme_day: root_window.clock_theme_day
            property alias move_numbers: root_window.moveNumbers
        }

        Connections {
            target: Qt.application
            onStateChanged:
                if(Qt.application.state == Qt.ApplicationActive) {
                    selected_theme === "analog" ? updateTimeAnalog() : updateTime()
                }
        }

        LiveTimer {
            frequency: displaySeconds ? LiveTimer.Second : LiveTimer.Minute
            onTrigger: {
                if(selected_theme === "analog") {
                    updateTimeAnalog()
                    sec_analog = parseInt(time_analog.substring(4,6), 10) * 6
                }
                else {
                    updateTime()
                }
            }
        }

        PageStack {
            id: page_stack
        }

        Component.onCompleted: {
            time_24 = Qt.formatDateTime(new Date(), "hhmmss")
            time_12 = Qt.formatDateTime(new Date(), "hhmmssap")
            page_stack.push(Qt.resolvedUrl("qml/Display.qml"))
        }

    }
}

