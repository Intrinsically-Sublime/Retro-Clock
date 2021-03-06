import QtQuick 2.7
import QtQuick.Layouts 1.3
import Ubuntu.Components 1.3
import Qt.labs.settings 1.0
import QtSystemInfo 5.0
import QtQuick.Window 2.2

Window {
    id: root_window

    property bool isAnalog: false
    property bool isLed: false
    property bool isDigtal: false
    property bool isFullscreen: true
    property bool rgbSliders: false
    property bool isLandscape: main_view.width > main_view.height
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
    property string color_edited // find out if text_color or back_color is edited in custom color setting
    property real alarm_del_h: 0

    property var presetTheme:  [
        //[folder/display/,     hue,    title,      seconds,date,   alarm,  blink, s.saver, oscil]
        ["digital/B7971/",      0,      "Preset 1", true,   true,   true,   true,  false,   false],
        ["digital/ZM1010/",     0,      "Preset 2", true,   true,   true,   false, false,   false],
        ["digital/IEL0VI/",     0,      "Preset 3", true,   true,   true,   false, false,   false],
        ["leds/HP5802-7002/",   0,      "Preset 4", false,  true,   true,   false, false,   false],
        ["other/FLIP_BLACK/",   0,      "Preset 5", true,   true,   true,   false, false,   false],
        ["digital/ZM1010/",     0.7,    "Preset 6", true,   true,   true,   false, false,   false],
        ["digital/ZM1350/",     0,      "Preset 7", true,   true,   true,   false, false,   false],
        ["analog/FIP60/",       0,      "Preset 8", true,   true,   true,   false, false,   false]
    ]

    property int currentPreset: 0
    property string selected_theme: presetTheme[currentPreset][0]
    property var tubeHue: presetTheme[currentPreset][1]
    property string themeName: presetTheme[currentPreset][2]
    property bool displaySeconds: presetTheme[currentPreset][3]
    property bool displayDate: presetTheme[currentPreset][4]
    property bool displayAlarms: presetTheme[currentPreset][5]
    property bool blinkColons: presetTheme[currentPreset][6]
    property bool moveNumbers: presetTheme[currentPreset][7]
    property bool hideOscilloscope: presetTheme[currentPreset][8]
    
    property string displayTypeName: getDisplayType()
    
    property color back_color: getPresetBackColor(currentPreset)
    property color text_color: getPresetTextColor(currentPreset)

    // Hack to save colors as they can not be saved in the array
    property color pre_b_color_0: "#0b0b0b"
    property color pre_b_color_1: "#000000"
    property color pre_b_color_2: "#5b4c39"
    property color pre_b_color_3: "#000000"
    property color pre_b_color_4: "#171717"
    property color pre_b_color_5: "#000000"
    property color pre_b_color_6: "#000000"
    property color pre_b_color_7: "#000000"
    // Hack to save colors as they can not be saved in the array
    property color pre_t_color_0: "#ffaa19"
    property color pre_t_color_1: "#e18223"
    property color pre_t_color_2: "#a5e6ff"
    property color pre_t_color_3: "#ff0000"
    property color pre_t_color_4: "#ffffff"
    property color pre_t_color_5: "#af64ff"
    property color pre_t_color_6: "#ffbeaf"
    property color pre_t_color_7: "#50ffff"
    // Hack to save the text colors to match the preset array
    function savePresetTextColor(newColor)
    {
        switch(currentPreset)
        {
        case 0: pre_t_color_0 = newColor ; break
        case 1: pre_t_color_1 = newColor ; break
        case 2: pre_t_color_2 = newColor ; break
        case 3: pre_t_color_3 = newColor ; break
        case 4: pre_t_color_4 = newColor ; break
        case 5: pre_t_color_5 = newColor ; break
        case 6: pre_t_color_6 = newColor ; break
        case 7: pre_t_color_7 = newColor ; break
        }
    }
    // Hack to save the background colors to match the preset array
    function savePresetBackColor(newColor)
    {
        switch(currentPreset)
        {
        case 0: pre_b_color_0 = newColor ; break
        case 1: pre_b_color_1 = newColor ; break
        case 2: pre_b_color_2 = newColor ; break
        case 3: pre_b_color_3 = newColor ; break
        case 4: pre_b_color_4 = newColor ; break
        case 5: pre_b_color_5 = newColor ; break
        case 6: pre_b_color_6 = newColor ; break
        case 7: pre_b_color_7 = newColor ; break
        }
    }
    // Hack to get the background colors that match the preset array
    function getPresetBackColor(preset)
    {
        switch(preset)
        {
        case 0: return pre_b_color_0 ; break
        case 1: return pre_b_color_1 ; break
        case 2: return pre_b_color_2 ; break
        case 3: return pre_b_color_3 ; break
        case 4: return pre_b_color_4 ; break
        case 5: return pre_b_color_5 ; break
        case 6: return pre_b_color_6 ; break
        case 7: return pre_b_color_7 ; break
        }
    }
    // Hack to get the text colors that match the preset array
        function getPresetTextColor(preset)
    {
        switch(preset)
        {
        case 0: return pre_t_color_0 ; break
        case 1: return pre_t_color_1 ; break
        case 2: return pre_t_color_2 ; break
        case 3: return pre_t_color_3 ; break
        case 4: return pre_t_color_4 ; break
        case 5: return pre_t_color_5 ; break
        case 6: return pre_t_color_6 ; break
        case 7: return pre_t_color_7 ; break
        }
    }
    
    function setDisplayType()
    {
        if (selected_theme.slice(0,6) == "analog") {
            isAnalog = true
            isLed = false
            isDigtal = false
            updateTimeAnalog()
        }
        else if (selected_theme.slice(0,4) == "leds") {
            isAnalog = false
            isLed = true
            isDigtal = false
            updateTime()
        }
        else if (selected_theme.slice(0,7) == "digital" ||
                    selected_theme.slice(0,5) == "other") { 
            isAnalog = false
            isLed = false
            isDigtal = true
            updateTime()
        }
    }
    
    function getDisplayType()
    {
        var displayType = selected_theme.split("/");
        return displayType[1];
    }

    function loadPreset(selection, mainPage)
    {
        currentPreset = selection
        selected_theme = presetTheme[selection][0]
        tubeHue = presetTheme[selection][1]
        themeName = presetTheme[selection][2]
        displaySeconds = presetTheme[selection][3]
        displayDate = presetTheme[selection][4]
        displayAlarms = presetTheme[selection][5]
        blinkColons = presetTheme[selection][6]
        moveNumbers = presetTheme[selection][7]
        hideOscilloscope = presetTheme[selection][8]
        back_color = getPresetBackColor(selection)
        text_color = getPresetTextColor(selection)
        setDisplayType()
        // Not sure if this is the best way but we need to reload the page
        // if switching between presets with and without seconds displayed
        // or between analog and digital. Unfortunetly is slows the 
        // transistion between digital and analog but not vise versa. I 
        // think it is a binding issue somewhere, possibly a result of 
        // the array used for storing the presets. Or possibly becasue the
        // digital clock is part of the main page but the analog uses a loader.
        if (mainPage) { 
            //page_stack.pop(null, true)
            page_stack.clear()
            page_stack.push(Qt.resolvedUrl("Display.qml"))
        } else {
            page_stack.pop()
            page_stack.push(Qt.resolvedUrl("Settings.qml"))
        }
    }
    
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

    onSelected_themeChanged: setDisplayType()

    ScreenSaver {
        screenSaverEnabled: !Qt.application.active
    }

    MainView {
        id: main_view

        // Note! applicationName needs to match the "name" field of the click manifest
        applicationName: "retro-clock.intrinsically-sublime"

        backgroundColor: back_color

        anchors.fill: parent

        Settings {
            property alias preset_themes: root_window.presetTheme
            property alias current_preset: root_window.currentPreset
            property alias is_fullscreen: root_window.isFullscreen
            property alias rgb_sliders: root_window.rgbSliders
            property alias current_date_format: root_window.date_format
            property alias current_time_format: root_window.time_format
            
            // More Hack to make preset colors work
            property alias b_color_0: root_window.pre_b_color_0
            property alias b_color_1: root_window.pre_b_color_1
            property alias b_color_2: root_window.pre_b_color_2
            property alias b_color_3: root_window.pre_b_color_3
            property alias b_color_4: root_window.pre_b_color_4
            property alias b_color_5: root_window.pre_b_color_5
            property alias b_color_6: root_window.pre_b_color_6
            property alias b_color_7: root_window.pre_b_color_7
            property alias t_color_0: root_window.pre_t_color_0
            property alias t_color_1: root_window.pre_t_color_1
            property alias t_color_2: root_window.pre_t_color_2
            property alias t_color_3: root_window.pre_t_color_3
            property alias t_color_4: root_window.pre_t_color_4
            property alias t_color_5: root_window.pre_t_color_5
            property alias t_color_6: root_window.pre_t_color_6
            property alias t_color_7: root_window.pre_t_color_7
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

