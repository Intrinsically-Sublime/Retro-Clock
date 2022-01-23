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

        title: i18n.tr("Night Clock")
        exposed: false
        StyleHints {
            backgroundColor: isDayMode ? "#e8ae0e" : "#0a2449"
            foregroundColor: isDayMode ? "#0a2449" : "#e8ae0e"
            dividerColor: "transparent"
        }
        leadingActionBar.actions: []
        trailingActionBar.actions: [
            Action {
                iconName: isDayMode ? "night-mode" : "display-brightness-max"

                onTriggered: {
                    isDayMode = !isDayMode
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
        property int digit_width: displaySeconds ? Math.min(display_back_rect.width * 2 / 13, (root_window.height - rest_height) * 2 / 3)
                                                 : Math.min(display_back_rect.width * 4 / 17, (root_window.height - rest_height) * 2 / 3)
        property int digit_width_small: displaySeconds ? Math.min(display_back_rect.width * 2 / 13 - 10, (root_window.height - rest_height - 20) * 2 / 3)
                                                       : Math.min(display_back_rect.width * 4 / 17 - 10, (root_window.height - rest_height - 20) * 2 / 3)


        color: isDayMode ? back_color_day
                         : back_color
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

            active: selected_theme === "analog"
            width: Math.min((root_window.height - rest_height), parent.width - units.gu(4))
            height: width
            x: analog_clock_x
            y: analog_clock_y
            source: "AnalogClock.qml"
        }

        DigitalClock {
            id: digital_clock

            visible: selected_theme !== "analog"
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
                    minimumY: 0
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
                top: selected_theme === "analog" ? analog_clock_loader.bottom : digital_clock.bottom
                right: selected_theme === "analog" ? analog_clock_loader.right : digital_clock.right
                rightMargin: selected_theme === "analog" ? 0 : units.gu(2)
            }
            width: ap_label.implicitWidth
            height: visible ? ap_label.implicitHeight : 0

            Label {
                id: ap_label

                text: time_12.substring(6)
                anchors.right: parent.right
                textSize: Label.Large
                color: isDayMode ? text_color_day
                                 : text_color
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

                color: isDayMode ? text_color_day
                                 : text_color
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

                color: isDayMode ? text_color_day
                                 : text_color
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

