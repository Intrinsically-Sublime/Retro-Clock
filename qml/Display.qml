import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Window 2.2
import Qt.labs.settings 1.0
import "../img"

Page {
    id: display_page

    property real digit_clock_x_m: 1
    property real digit_clock_y_m: 100
    property real analog_clock_x: (root_window.width - analog_clock_loader.width) / 2
    property real analog_clock_y: units.gu(2)
    property real rest_height: isLandscape || !displayAlarms ? ap_label_item.height + day_label_item.height + date_label_item.height + units.gu(5)
                                                             : ap_label_item.height + day_label_item.height + date_label_item.height + alarm_del_h + units.gu(11)

    function moveDigitsOnScreen(m_w, w, m_h, h)
    {
        if (digital_clock.x === 0 && digital_clock.y === 0) {
            digital_clock.x = m_w - w
            digital_clock.y = (m_h - h) / 2
        }
        else if (digital_clock.x === m_w - w && digital_clock.y === (m_h - h) / 2) {
            digital_clock.x = 0
            digital_clock.y = m_h - h
        }
        else if (digital_clock.x === 0 && digital_clock.y === m_h - h) {
            digital_clock.x = (m_w - w) / 2
            digital_clock.y = 0
        }
        else if (digital_clock.x === (m_w - w) / 2 && digital_clock.y === 0) {
            digital_clock.x = m_w -w
            digital_clock.y = m_h - h
        }
        else if (digital_clock.x === m_w -w && digital_clock.y === m_h - h) {
            digital_clock.x = 0
            digital_clock.y = (m_h - h) / 2
        }
        else if (digital_clock.x === 0 && digital_clock.y === (m_h - h) / 2) {
            digital_clock.x = m_w - w
            digital_clock.y = 0
        }
        else if (digital_clock.x === m_w - w && digital_clock.y === 0) {
            digital_clock.x = (m_w - w) / 2
            digital_clock.y = m_h - h
        }
        else if (digital_clock.x === (m_w - w) / 2 && digital_clock.y === m_h - h) {
            digital_clock.x = (m_w - w) / 2
            digital_clock.y = (m_h - h) / 2
        }
        else {
            digital_clock.x = 0
            digital_clock.y = 0
        }
    }

    function positionDigitalClock()
    {
        if (moveNumbers) {
            digital_clock.x = 0
            digital_clock.y = 0
            digital_clock.digitWidth = display_back_rect.digit_width_small
        }
        else {
            digital_clock.digitWidth = display_back_rect.digit_width
            digital_clock.x = (root_window.width - digital_clock.width) / digit_clock_x_m
            digital_clock.y = (root_window.height - digital_clock.height) / digit_clock_y_m
        }
    }

    Settings {
        property alias d_c_x_m: display_page.digit_clock_x_m
        property alias d_c_y_m: display_page.digit_clock_y_m
    }

    LiveTimer {
        frequency: moveNumbers ? LiveTimer.Minute : LiveTimer.Disabled
        onTrigger: moveDigitsOnScreen(display_back_rect.width, digital_clock.width, display_back_rect.height, digital_clock.height + rest_height)
    }

    header: PageHeader {
        id: main_header

        title: i18n.tr("Retro Clock ~ " + presetTheme[currentPreset][2])
        exposed: false
        StyleHints {
            backgroundColor: back_color
            dividerColor: "transparent"
        }
        
        leadingActionBar.actions: []        
        trailingActionBar {
            actions: [
                Action {
                    iconSource: "../img/" + presetTheme[0][0] + "icon.png"
                    text: i18n.tr(presetTheme[0][2])

                    onTriggered: {
                        main_header.exposed = false
                        loadPreset(0, true)
                    }
                },
                Action {
                    iconSource: "../img/" + presetTheme[1][0] + "icon.png"
                    text: i18n.tr(presetTheme[1][2])

                    onTriggered: {
                        main_header.exposed = false
                        loadPreset(1, true)
                    }
                },
                Action {
                    iconSource: "../img/" + presetTheme[2][0] + "icon.png"
                    text: i18n.tr(presetTheme[2][2])

                    onTriggered: {
                        main_header.exposed = false
                        loadPreset(2, true)
                    }
                },
                Action {
                    iconSource: "../img/" + presetTheme[3][0] + "icon.png"
                    text: i18n.tr(presetTheme[3][2])

                    onTriggered: {
                        main_header.exposed = false
                        loadPreset(3, true)
                    }
                },
                Action {
                    iconSource: "../img/" + presetTheme[4][0] + "icon.png"
                    text: i18n.tr(presetTheme[4][2])

                    onTriggered: {
                        main_header.exposed = false
                        loadPreset(4, true)
                    }
                },
                Action {
                    iconSource: "../img/" + presetTheme[5][0] + "icon.png"
                    text: i18n.tr(presetTheme[5][2])

                    onTriggered: {
                        main_header.exposed = false
                        loadPreset(5, true)
                    }
                },
                Action {
                    iconName: "settings"
                    text: i18n.tr("Settings")

                    onTriggered: {
                        main_header.exposed = false
                        page_stack.push(Qt.resolvedUrl("Settings.qml"))
                    }
                },
                Action {
                    iconName: "info"
                    text: i18n.tr("Information")

                    onTriggered: {
                        main_header.exposed = false
                        page_stack.push(Qt.resolvedUrl("About.qml"))
                    }
                }
            ]
            numberOfSlots: 1
        }
    }

    Timer {
        id: hide_header_timer

        running: main_header.exposed
        onTriggered: main_header.exposed = false
        interval: 8000
    }

    Rectangle {
        id: display_back_rect

        property bool withLeadingZero: time_format === "hh:mm" || time_format === "hh:mm ap"
        property bool is24hour: time_format === "hh:mm" || time_format === "h:mm"
        property int digit_width: displaySeconds ? Math.min(display_back_rect.width * 2 / 18, (root_window.height - rest_height) * 2 / 3)
                                                 : Math.min(display_back_rect.width * 4 / 22 - 10, (root_window.height - rest_height - 10) * 2 / 3)
        property int digit_width_small: displaySeconds ? Math.min(display_back_rect.width * 2 / 18 - 10, (root_window.height - rest_height - 20) * 2 / 3)
                                                       : Math.min(display_back_rect.width * 4 / 22 - 20, (root_window.height - rest_height - 40) * 2 / 3)


        color: back_color
        anchors {
            top: main_header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        MouseArea {
            anchors.fill: parent
            onClicked: main_header.exposed = !main_header.exposed
        }

        Connections {
            target: display_page
            onWidthChanged: positionDigitalClock()
            onHeightChanged: positionDigitalClock()
        }

        Connections {
            target: page_stack
            onDepthChanged: {
                if(page_stack.depth == 1) positionDigitalClock();
            }
        }

        Loader {
            id: analog_clock_loader

            active: isAnalog
            width: Math.min((root_window.height - rest_height), parent.width - units.gu(4))
            height: width
            x: analog_clock_x
            y: analog_clock_y
            source: "AnalogClock.qml"
        }

        DigitalClock {
            id: digital_clock

            visible: !isAnalog
            x: digit_clock_x_m !== digit_clock_x_m ? (root_window.width - digital_clock.width) / digit_clock_x_m
                                                   : root_window.width - digital_clock.width
            y: digit_clock_y_m !== digit_clock_y_m ? (root_window.height - digital_clock.height) / digit_clock_y_m
                                                   : units.gu(2)

            MouseArea {
                anchors.fill: parent
                propagateComposedEvents: true
                drag {
                    target: digital_clock
                    minimumX: 0
                    maximumX: display_back_rect.width - digital_clock.width
                    minimumY: isLandscape ? - (digital_clock.height/2) : 0
                    maximumY: display_back_rect.height - digital_clock.height
                }
                onReleased: {
                    if(!moveNumbers) {
                        digit_clock_x_m = digital_clock.x <= 0 ? 1
                                                               : (root_window.width - digital_clock.width) / digital_clock.x
                        digit_clock_y_m = digital_clock.y <= 0 ? root_window.height - digital_clock.height
                                                               :(root_window.height - digital_clock.height) / digital_clock.y
                    }
                }
            }
        }


        Item {
            id: ap_label_item

            visible: !display_back_rect.is24hour
            anchors {
                top: isAnalog ? analog_clock_loader.bottom : digital_clock.bottom
                right: isAnalog ? analog_clock_loader.right : digital_clock.right
                rightMargin: isAnalog ? 0 : units.gu(2)
            }
            width: ap_label.implicitWidth
            height: visible ? ap_label.implicitHeight : 0

            Label {
                id: ap_label

                text: time_12.substring(6)
                anchors.right: parent.right
                textSize: Label.Large
                color: text_color
            }
        }

        Item {
            id: day_label_item

            visible: displayDate
            anchors {
                top: ap_label_item.bottom
                topMargin: units.gu(1)
                left: parent.left
                leftMargin: units.gu(2)
            }
            width: day_label.implicitWidth
            height: visible ? day_label.implicitHeight : 0

            Label {
                id: day_label

                color: text_color
                text: this_day
                anchors.left: parent.left
                textSize: Label.XLarge
            }
        }

        Item {
            id: date_label_item

            visible: displayDate
            anchors {
                top: day_label_item.bottom
                topMargin: units.gu(1)
                left: day_label_item.left
            }
            width: date_label.implicitWidth
            height: visible ? date_label.implicitHeight : 0

            Label {
                id: date_label

                color: text_color
                text: this_date
                anchors.left: parent.left
                textSize: Label.XLarge
            }
        }

        Loader {
            id: alarms_view_loader

            active: displayAlarms
            anchors {
                top: isLandscape || !displayDate ? ap_label_item.bottom : date_label_item.bottom
                topMargin: isLandscape ? 0 : units.gu(5)
                left: parent.left
                leftMargin: isLandscape ? parent.width/2 : 0
                right: parent.right
                bottom: parent.bottom
            }
            source: "AlarmsView.qml"
        }

    }
}

