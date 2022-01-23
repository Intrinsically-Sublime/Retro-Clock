import QtQuick 2.7
import QtQuick.Layouts 1.3
import Ubuntu.Components 1.3
import Qt.labs.settings 1.0
import QtSystemInfo 5.0
import QtQuick.Window 2.2

Window {
    id: root_window

    property bool isAnalog: selected_theme.slice(0,6) == "analog" ? true : false
    property bool isLed: selected_theme.slice(0,4) == "leds" ? true : false
    property bool isDigtal: selected_theme.slice(0,7) == "digital" ? true : false
    property bool isFullscreen: true
    property bool isLandscape: main_view.width > main_view.height
    property bool isDayMode: false
    property bool displaySeconds: true
    property bool blinkColons: false
    property bool displayAlarms: true
    property bool displayDate: true
    property bool moveNumbers: false
    property bool hideOscilloscope: false
    property string time_24: "000000"
    property string time_12: "000000ap"
    property string time_analog: "000000ap"
    property int sec_analog: 0
    property string this_day: Qt.formatDateTime(new Date(), "dddd")
    property date test_time: new Date(1996,4,20,04,19)
    property string time_format: "hh:mm ap"
    property string this_time: Qt.formatDateTime(new Date(), time_format)
    property date test_date: new Date(1996,4,20)
    property string date_format: "MMMM d yyyy"
    property string this_date: Qt.formatDateTime(new Date(), date_format)
    property color back_color: "#000"
    property color back_color_day: "#000"
    property color text_color: "#ffaa19"
    property color text_color_day: "#82ffff"
    property string tube_hue: "0"
    property string tube_hue_day: "0"
    property string color_edited // find out if text_color or back_color is edited in custom color setting
    property string clock_theme: "digital/b7971/"
    property string clock_theme_day: "digital/iel_0_vi/"
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
    title: i18n.tr("Retro Clock")
    width: units.gu(40)
    height: units.gu(90)
    minimumWidth: units.gu(40)
    minimumHeight: units.gu(80)
    visible: true
    visibility: isFullscreen ? Window.FullScreen : Window.AutomaticVisibility

    onSelected_themeChanged: selected_theme.slice(0,6) == "analog" ? updateTimeAnalog() : updateTime()

    ScreenSaver {
        screenSaverEnabled: !Qt.application.active
    }

    MainView {
        id: main_view

        // Note! applicationName needs to match the "name" field of the click manifest
        applicationName: "retro-clock.intrinsically-sublime"

        backgroundColor: isDayMode ? back_color_day : back_color

        anchors.fill: parent

        Settings {
            property alias tube_hue: root_window.tube_hue
            property alias tube_hue_day: root_window.tube_hue_day
            property alias is_analog: root_window.isAnalog
            property alias is_led: root_window.isLed
            property alias is_digital: root_window.isDigtal
            property alias blink_colons: root_window.blinkColons
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
            property alias hide_oscilloscope: root_window.hideOscilloscope
        }

        Connections {
            target: Qt.application
            onStateChanged:
                if(Qt.application.state == Qt.ApplicationActive) {
                    isAnalog ? updateTimeAnalog() : updateTime()
                }
        }

        LiveTimer {
            frequency: displaySeconds ? LiveTimer.Second : LiveTimer.Minute
            onTrigger: {
                if(isAnalog) {
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
            page_stack.push(Qt.resolvedUrl("Display.qml"))
        }

    }
}

