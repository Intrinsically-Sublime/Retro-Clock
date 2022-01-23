import QtQuick 2.4
import Ubuntu.Components 1.3


Page {
    id: root_settingpage

    property var colorModel: [
        "#ffffff", "#929292", "#000000",
        "#b71c1c", "#f32c36","#e91e63", "#9c27b0",
        "#673ab7", "#12a3d8", "#00bcd4",
        "#00a132", "#ffc107", "#ffeb3b"]

    header: PageHeader {
        id: main_header

        title: i18n.tr("Settings")
        StyleHints {
            backgroundColor: isDayMode ? "#e8ae0e" : "#0a2449"
            foregroundColor: isDayMode ? "#0a2449" : "#e8ae0e"
        }
        extension: Sections {
            id: header_sections
            StyleHints {
                selectedSectionColor: isDayMode ? "#0a2449" : "#e8ae0e"
                sectionColor:"#f7f7f7"
            }
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            model: [i18n.tr("Appearance"), i18n.tr("Time & Date Format")]
        }

    }

    Flow {
        id: main_flow

        anchors.top: main_header.bottom
        width: parent.width
        spacing: 0

        Rectangle {
            id: preview_rect

            property bool withLeadingZero: time_format === "hh:mm" || time_format === "hh:mm ap"
            property bool is24hour: time_format === "hh:mm" || time_format === "h:mm"
            property int digit_width: displaySeconds ? Math.min(preview_rect.width*2/13, (preview_rect.height - day_label.height - date_label.height - ap_label.height - units.gu(8))*2/3)
                                                     : Math.min(preview_rect.width*4/17, (preview_rect.height - day_label.height - date_label.height - ap_label.height - units.gu(8))*2/3)

            color: isDayMode ? back_color_day : back_color
            width: isLandscape ? root_settingpage.width/2 : root_settingpage.width
            height: isLandscape ? root_settingpage.height - main_header.height : (root_settingpage.height - main_header.height)/2

            AnalogClock {
                id: analog_clock

                visible: selected_theme === "analog"
                width: Math.min(preview_rect.width - units.gu(4), (preview_rect.height - day_label.height - date_label.height - ap_label.height - units.gu(8)))
                height: width
                anchors {
                    top: parent.top
                    topMargin: units.gu(2)
                    horizontalCenter: parent.horizontalCenter
                }
            }

            Row {
                id: time_row

                visible: selected_theme !== "analog"
                width: displaySeconds ? time_h.width * 6 + time_colon.width * 2 : time_h.width * 4 + time_colon.width
                anchors {
                    right: parent.right
                    top: parent.top
                    topMargin: units.gu(2)
                }

                Icon {
                    id: time_h

                    opacity: (preview_rect.is24hour && !preview_rect.withLeadingZero && time_24.charAt(0) == "0") ||
                             (!preview_rect.is24hour && !preview_rect.withLeadingZero && time_12.charAt(0) == "0") ? 0 : 1
                    source: selected_theme === "analog" ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(0) + ".svg" : "../img/" + selected_theme + time_12.charAt(0) + ".svg"
                    width: preview_rect.digit_width
                    height: width * 3/2
                    color: isDayMode ? text_color_day : text_color
                }

                Icon {
                    id: time_hh

                    source: selected_theme === "analog" ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(1) + ".svg" : "../img/" + selected_theme + time_12.charAt(1) + ".svg"
                    width: preview_rect.digit_width
                    height: width * 3/2
                    color: isDayMode ? text_color_day : text_color
                }

                Icon {
                    id: time_colon

                    source: selected_theme === "analog" ? "" : "../img/" + selected_theme + "colon.svg"
                    width: preview_rect.digit_width/4
                    height: time_h.height
                    color: isDayMode ? text_color_day : text_color
                }

                Icon {
                    id: time_m

                    source: selected_theme === "analog" ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(2) + ".svg" : "../img/" + selected_theme + time_12.charAt(2) +".svg"
                    width: preview_rect.digit_width
                    height: width * 3/2
                    color: isDayMode ? text_color_day : text_color
                }

                Icon {
                    id: time_mm

                    source: selected_theme === "analog" ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(3) + ".svg" : "../img/" + selected_theme + time_12.charAt(3) +".svg"
                    width: preview_rect.digit_width
                    height: width * 3/2
                    color: isDayMode ? text_color_day : text_color
                }

                Icon {
                    id: sec_colon

                    source: selected_theme === "analog" ? "" : "../img/" + selected_theme + "colon.svg"
                    width: displaySeconds ? preview_rect.digit_width/4 : 0
                    height: time_h.height
                    color: isDayMode ? text_color_day : text_color
                }

                Icon {
                    id: time_s

                    source: selected_theme === "analog" ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(4) + ".svg" : "../img/" + selected_theme + time_12.charAt(4) +".svg"
                    width: displaySeconds ? preview_rect.digit_width : 0
                    height: width * 3/2
                    color: isDayMode ? text_color_day : text_color
                }

                Icon {
                    id: time_ss

                    source: selected_theme === "analog" ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(5) + ".svg" : "../img/" + selected_theme + time_12.charAt(5) +".svg"
                    width: displaySeconds ? preview_rect.digit_width : 0
                    height: width * 3/2
                    color: isDayMode ? text_color_day : text_color
                }
            }

            Label {
                id: ap_label

                visible: !preview_rect.is24hour
                text: time_12.substring(6)
                anchors {
                    top: selected_theme === "analog" ? analog_clock.bottom : time_row.bottom
                    right: parent.right
                    rightMargin: units.gu(2)
                }
                color: isDayMode ? text_color_day : text_color
            }

            Label {
                id: day_label

                visible: displayDate
                color: isDayMode ? text_color_day : text_color
                text: this_day
                anchors {
                    top: ap_label.bottom
                    topMargin: units.gu(1)
                    left: parent.left
                    leftMargin: units.gu(2)
                }
            }

            Label {
                id: date_label

                visible: displayDate
                color: isDayMode ? text_color_day : text_color
                text: this_date
                anchors {
                    top: day_label.bottom
                    topMargin: units.gu(1)
                    left: day_label.left
                }
            }
        }

        Item {
            id: settings_item

            width: preview_rect.width
            height: preview_rect.height

            Flickable {
                id: page_flickable

                anchors.fill: parent

                contentHeight:  settings_column.height + units.gu(2)
                clip: true

                Column {
                    id: settings_column

                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                    }
                    spacing: units.gu(1)

                    ListItem {
                        id: date_format_setting_item

                        visible: header_sections.selectedIndex === 1
                        height: d_f_layout.height
                        divider.visible: false

                        ListItemLayout {
                            id: d_f_layout

                            title.text: i18n.tr("Date format")

                            Label {
                                text: Qt.formatDateTime(test_date, date_format)
                                font.italic: true
                            }
                            ProgressionSlot {}
                        }
                        onClicked: {
                            page_stack.push(Qt.resolvedUrl("DateFormatSetting.qml"))
                        }
                    }

                    ListItem {
                        id: time_format_setting_item

                        visible: header_sections.selectedIndex === 1
                        height: t_f_layout.height
                        divider.visible: false

                        ListItemLayout {
                            id: t_f_layout

                            title.text:i18n.tr("Time format")

                            Label {
                                text: Qt.formatDateTime(test_time, time_format)
                                font.italic: true
                            }
                            ProgressionSlot {}
                        }
                        onClicked: {
                            page_stack.push(Qt.resolvedUrl("TimeFormatSetting.qml"))
                        }
                    }

                    ListItem {
                        id: display_date_item

                        visible: header_sections.selectedIndex === 1
                        height: d_layout.height
                        divider.visible: false
                        ListItemLayout {
                            id: d_layout

                            title.text: i18n.tr("Display date")

                            CheckBox {
                                id: d_switch

                                checked: displayDate
                                onCheckedChanged: displayDate = checked
                                SlotsLayout.position: SlotsLayout.Leading
                            }
                        }
                        onClicked: d_switch.checked = !d_switch.checked
                    }

                    ListItem {
                        id: display_seconds_setting_item

                        visible: header_sections.selectedIndex === 1
                        height: s_layout.height
                        divider.visible: false
                        ListItemLayout {
                            id: s_layout
                            title.text: i18n.tr("Display seconds")

                            CheckBox {
                                id: s_switch

                                checked: displaySeconds
                                onCheckedChanged: displaySeconds = checked
                                SlotsLayout.position: SlotsLayout.Leading
                            }
                        }
                        onClicked: s_switch.checked = !s_switch.checked
                    }

                    Label {
                        id: seconds_warning

                        visible: displaySeconds && header_sections.selectedIndex === 1
                        color: UbuntuColors.red
                        x: units.gu(2)
                        width: parent.width - units.gu(4)
                        text: i18n.tr("WARNING: This setting will reduce battery life")
                        wrapMode: Text.Wrap
                    }

                    ListItem {
                        id: show_fullscreen_setting_item

                        visible: header_sections.selectedIndex === 0
                        height: fs_layout.height
                        divider.visible: false
                        ListItemLayout {
                            id: fs_layout

                            title.text: i18n.tr("Full screen")

                            Switch {
                                id: fs_switch

                                checked: isFullscreen
                                onCheckedChanged: isFullscreen = checked
                            }
                        }
                        onClicked: fs_switch.checked = !fs_switch.checked
                    }

                    ListItem {
                        id: move_digits_setting_item

                        visible: header_sections.selectedIndex === 0
                        height: m_d_lil.height
                        divider.visible: false
                        ListItemLayout {
                            id: m_d_lil

                            title.text: i18n.tr("Screensaver mode")
                            subtitle.text: i18n.tr("Digital clock will change its position every minute to prevent screen burn-in")
                            subtitle.maximumLineCount: 4

                            Switch {
                                id: md_switch

                                checked: moveNumbers
                                onCheckedChanged: moveNumbers = checked
                            }
                        }
                        onClicked: md_switch.checked = !md_switch.checked
                    }

                    ListItem {
                        id: display_alarms_setting_item

                        visible: header_sections.selectedIndex === 0
                        height: a_layout.height
                        divider.visible: false

                        ListItemLayout {
                            id: a_layout

                            title.text: i18n.tr("Display active alarms")

                            CheckBox {
                                id: a_switch

                                checked: displayAlarms
                                onCheckedChanged: displayAlarms = checked
                                SlotsLayout.position: SlotsLayout.Leading
                            }
                        }
                        onClicked: a_switch.checked = !a_switch.checked
                    }

                    ListItem {
                        id: text_color_setting_item
                        visible: header_sections.selectedIndex === 0
                        divider.visible: false

                        Column {
                            id: text_color_column
                            anchors {
                                left: parent.left
                                leftMargin: units.gu(2)
                                right: parent.right
                                rightMargin: units.gu(2)
                            }
                            spacing: units.dp(4)

                            Label {
                                text: i18n.tr("Foreground colour")
                            }

                            Row {
                                width: parent.width
                                height: units.gu(5)
                                spacing: units.gu(1)

                                Item {
                                    id: custom_text_color_rect

                                    width: units.gu(3)
                                    height: units.gu(4)

                                    Icon {
                                        name: "edit"
                                        width: units.gu(3)
                                        height: width
                                        anchors.centerIn: parent
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            color_edited = "text_color"
                                            page_stack.push(Qt.resolvedUrl("CustomColor.qml"))
                                        }
                                    }
                                }

                                ListView {
                                    id: text_color_rep

                                    width: parent.width - custom_text_color_rect.width - units.gu(1)
                                    height: units.gu(5)

                                    spacing: units.gu(1)
                                    orientation:  ListView.Horizontal
                                    clip: true
                                    model: colorModel
                                    delegate:
                                        Rectangle {
                                        id: text_color_rect

                                        color: modelData
                                        width: units.gu(4)
                                        height: width
                                        radius: height / 2
                                        border.color: "#ddd"

                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                isDayMode ? text_color_day = text_color_rect.color
                                                          : text_color = text_color_rect.color
                                            }
                                        }
                                    }
                                }

                            }
                        }
                    }

                    ListItem {
                        id: background_color_setting_item
                        visible: header_sections.selectedIndex === 0
                        divider.visible: false
                        Column {
                            id: back_color_column
                            anchors {
                                left: parent.left
                                leftMargin: units.gu(2)
                                right: parent.right
                                rightMargin: units.gu(2)
                            }
                            spacing: units.dp(4)

                            Label {
                                text: i18n.tr("Background colour")
                            }

                            Row {
                                width: parent.width
                                height: units.gu(5)
                                spacing: units.gu(1)

                                Item {
                                    id: custom_back_color_rect

                                    width: units.gu(3)
                                    height: units.gu(4)

                                    Icon {
                                        name: "edit"
                                        width: units.gu(3)
                                        height: width
                                        anchors.centerIn: parent
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            color_edited = "back_color"
                                            page_stack.push(Qt.resolvedUrl("CustomColor.qml"))
                                        }
                                    }
                                }

                                ListView {
                                    id: back_color_rep

                                    width: parent.width - custom_text_color_rect.width - units.gu(1)
                                    height: units.gu(5)

                                    spacing: units.gu(1)
                                    orientation:  ListView.Horizontal
                                    clip: true
                                    model: colorModel
                                    delegate:
                                        Rectangle {
                                        id: back_color_rect

                                        color: modelData
                                        width: units.gu(4)
                                        height: width
                                        radius: height / 2
                                        border.color: "#ddd"

                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                isDayMode ? back_color_day = back_color_rect.color
                                                          : back_color = back_color_rect.color
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    ListItem {
                        id: theme_setting_item

                        visible: header_sections.selectedIndex === 0
                        divider.visible: false

                        Column {
                            id: theme_column
                            anchors {
                                left: parent.left
                                leftMargin: units.gu(2)
                                right: parent.right
                                rightMargin: units.gu(2)
                            }
                            spacing: units.dp(4)

                            Label {
                                text: i18n.tr("Clock theme")
                            }

                            Flickable {
                                width: parent.width
                                height: units.gu(4)
                                contentWidth: theme_row.width
                                clip: true

                                Row {
                                    id: theme_row

                                    spacing: units.gu(1)
                                    Repeater {
                                        id: theme_rep

                                        model: [
                                            "tha/", "thb/", "thc/", "thd/", "the/", "thf/", "thg/", "thh/"
                                        ]

                                        Item {
                                            width: units.gu(4)
                                            height: units.gu(4)

                                            Icon {
                                                id: theme_icon

                                                color: UbuntuColors.orange
                                                source: "../img/" + modelData + (index+1) + ".svg"
                                                anchors.centerIn: parent
                                                width: height * 2/3
                                                height: units.gu(3)
                                            }
                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: {
                                                    isDayMode ? clock_theme_day = modelData
                                                              : clock_theme = modelData
                                                    updateTime()
                                                }
                                            }
                                        }
                                    }

                                    Item {
                                        id: analog_theme

                                        width: units.gu(4)
                                        height: units.gu(4)

                                        Icon {
                                            color: UbuntuColors.orange
                                            name: "clock"
                                            width: units.gu(3)
                                            height: width
                                            anchors.centerIn: parent
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                isDayMode ? clock_theme_day = "analog"
                                                          : clock_theme = "analog"
                                                updateTimeAnalog()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
