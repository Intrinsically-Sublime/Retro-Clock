import QtQuick 2.4
import Ubuntu.Components 1.3
import QtGraphicalEffects 1.12


Page {
    id: root_settingpage

    property var colorModel: [
        "#ffffff", "#929292", "#000000", "#ff0000",
        "#b71c1c", "#f32c36","#e91e63", "#9c27b0",
        "#673ab7", "#12a3d8", "#00bcd4",
        "#00a132", "#3de011", "#ffc107", "#ffeb3b"]

    property bool blankDigit: (preview_rect.is24hour && !preview_rect.withLeadingZero && time_24.charAt(0) == "0") ||
        (!preview_rect.is24hour && !preview_rect.withLeadingZero && time_12.charAt(0) == "0") ? 1 : 0
                        
    header: PageHeader {
        id: main_header

        title: i18n.tr("Settings for " + presetTheme[currentPreset][2])
        StyleHints {
            backgroundColor: back_color
        }
        
        extension: Sections {
            id: header_sections
            StyleHints {
                selectedSectionColor: "#e8ae0e"
                sectionColor:"#f7f7f7"
            }
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            model: [i18n.tr("Appearance"), i18n.tr("Advanced"), i18n.tr("Time & Date Format")]
        }
              
        trailingActionBar {
            actions: [
                Action {
                    iconSource: "../img/" + presetTheme[0][0] + "icon.png"
                    text: i18n.tr(presetTheme[0][2])

                    onTriggered: loadPreset(0, false)
                },
                Action {
                    iconSource: "../img/" + presetTheme[1][0] + "icon.png"
                    text: i18n.tr(presetTheme[1][2])

                    onTriggered: loadPreset(1, false)
                },
                Action {
                    iconSource: "../img/" + presetTheme[2][0] + "icon.png"
                    text: i18n.tr(presetTheme[2][2])

                    onTriggered: loadPreset(2, false)
                },
                Action {
                    iconSource: "../img/" + presetTheme[3][0] + "icon.png"
                    text: i18n.tr(presetTheme[3][2])

                    onTriggered: loadPreset(3, false)
                },
                Action {
                    iconSource: "../img/" + presetTheme[4][0] + "icon.png"
                    text: i18n.tr(presetTheme[4][2])

                    onTriggered: loadPreset(4, false)
                },
                Action {
                    iconSource: "../img/" + presetTheme[5][0] + "icon.png"
                    text: i18n.tr(presetTheme[5][2])

                    onTriggered: loadPreset(5)
                }
            ]
            numberOfSlots: 1
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
            property int digit_width: displaySeconds ? Math.min(preview_rect.width*2/16, (preview_rect.height - day_label.height - date_label.height - ap_label.height - units.gu(8))*2/3)
                                                     : Math.min(preview_rect.width*4/20, (preview_rect.height - day_label.height - date_label.height - ap_label.height - units.gu(8))*2/3)

            color: back_color
            width: isLandscape ? root_settingpage.width/2 : root_settingpage.width
            height: isLandscape ? root_settingpage.height - main_header.height : (root_settingpage.height - main_header.height)/2

            AnalogClock {
                id: analog_clock

                visible: isAnalog
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

                visible: !isAnalog
                width: displaySeconds ? time_h.width * 6 + time_colon.width * 2 : time_h.width * 4 + time_colon.width
                anchors {
                    right: parent.right
                    top: parent.top
                    topMargin: units.gu(2)
                }

                Item {
                    id: time_h_box
                    width: preview_rect.digit_width
                    height: width * 4
                        
                    Icon {
                        id: time_h_light
                        visible: (!blankDigit && isLed)

                        source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                        width: preview_rect.digit_width
                        height: width * 4
                        color: text_color
                    }
                    
                    BrightnessContrast {
                        anchors.fill: time_h_light
                        source: time_h_light
                        brightness: 0.5
                        contrast: 0.5
                    }
                    
                    Icon {
                        id: time_h
                        
                        source: isAnalog ? "" : blankDigit ? "../img/" + selected_theme + "blank.png" : isAnalog ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(0) + ".png" : "../img/" + selected_theme + time_12.charAt(0) + ".png"
                        width: preview_rect.digit_width
                        height: width * 4
                    }

                    HueSaturation {
                        anchors.fill: time_h
                        source: time_h
                        hue: isDigtal ? tubeHue : "0"
                    }
                }

                Item {
                    id: time_hh_box
                    width: preview_rect.digit_width
                    height: width * 4
                        
                    Icon {
                        id: time_hh_light
                        visible: isLed

                        source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                        width: preview_rect.digit_width
                        height: width * 4
                        color: text_color
                    }
                    
                    BrightnessContrast {
                        anchors.fill: time_hh_light
                        source: time_hh_light
                        brightness: 0.5
                        contrast: 0.5
                    }
                    
                    Icon {
                        id: time_hh

                        source: isAnalog ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(1) + ".png" : "../img/" + selected_theme + time_12.charAt(1) + ".png"
                        width: preview_rect.digit_width
                        height: width * 4
                    }

                    HueSaturation {
                        anchors.fill: time_hh
                        source: time_hh
                        hue: isDigtal ? tubeHue : "0"
                    }
                }

                Item {
                    id: time_colon_box
                    width: preview_rect.digit_width
                    height: width * 4
                        
                    Icon {
                        id: time_colon_light
                        visible: isLed

                        source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                        width: preview_rect.digit_width
                        height: width * 4
                        color: text_color
                    }
                    
                    BrightnessContrast {
                        anchors.fill: time_colon_light
                        source: time_colon_light
                        brightness: 0.5
                        contrast: 0.5
                    }
                    
                    Icon {
                        id: time_colon

                        source: time_12.charAt(5) & 1 == 1 ? isAnalog ? "" : "../img/" + selected_theme + "colon.png" : isAnalog ? "" : blinkColons ? "../img/" + selected_theme + "blank_colon.png" : "../img/" + selected_theme + "colon.png"
                        width: preview_rect.digit_width
                        height: width * 4
                    }

                    HueSaturation {
                        anchors.fill: time_colon
                        source: time_colon
                        hue: isDigtal ? tubeHue : "0"
                    }
                }

                Item {
                    id: time_m_box
                    width: preview_rect.digit_width
                    height: width * 4
                        
                    Icon {
                        id: time_m_light
                        visible: isLed

                        source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                        width: preview_rect.digit_width
                        height: width * 4
                        color: text_color
                    }
                    
                    BrightnessContrast {
                        anchors.fill: time_m_light
                        source: time_m_light
                        brightness: 0.5
                        contrast: 0.5
                    }
                    
                    Icon {
                        id: time_m

                        source: isAnalog ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(2) + ".png" : "../img/" + selected_theme + time_12.charAt(2) +".png"
                        width: preview_rect.digit_width
                        height: width * 4
                    }

                    HueSaturation {
                        anchors.fill: time_m
                        source: time_m
                        hue: isDigtal ? tubeHue : "0"
                    }
                }

                Item {
                    id: time_mm_box
                    width: preview_rect.digit_width
                    height: width * 4
                        
                    Icon {
                        id: time_mm_light
                        visible: isLed

                        source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                        width: preview_rect.digit_width
                        height: width * 4
                        color: text_color
                    }
                    
                    BrightnessContrast {
                        anchors.fill: time_mm_light
                        source: time_mm_light
                        brightness: 0.5
                        contrast: 0.5
                    }
                    
                    Icon {
                        id: time_mm

                        source: isAnalog ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(3) + ".png" : "../img/" + selected_theme + time_12.charAt(3) +".png"
                        width: preview_rect.digit_width
                        height: width * 4
                    }

                    HueSaturation {
                        anchors.fill: time_mm
                        source: time_mm
                        hue: isDigtal ? tubeHue : "0"
                    }
                }

                Item {
                    id: time_sec_colon_box
                    width: displaySeconds ? preview_rect.digit_width : 0
                    height: width * 4
                        
                    Icon {
                        id: time_sec_colon_light
                        visible: isLed

                        source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                        width: displaySeconds ?  preview_rect.digit_width : 0
                        height: width * 4
                        color: text_color
                    }
                    
                    BrightnessContrast {
                        anchors.fill: time_sec_colon_light
                        source: time_sec_colon_light
                        brightness: 0.5
                        contrast: 0.5
                    }
                    
                    Icon {
                        id: sec_colon

                        source: time_12.charAt(5) & 1 == 1 ? isAnalog ? "" : "../img/" + selected_theme + "colon.png" : isAnalog ? "" : blinkColons ? "../img/" + selected_theme + "blank_colon.png" : "../img/" + selected_theme + "colon.png"
                        width: displaySeconds ? preview_rect.digit_width : 0
                        height: width * 4
                    }

                    HueSaturation {
                        anchors.fill: sec_colon
                        source: sec_colon
                        hue: isDigtal ? tubeHue : "0"
                    }
                }

                Item {
                    id: time_s_box
                    width: displaySeconds ? preview_rect.digit_width : 0
                    height: width * 4
                        
                    Icon {
                        id: time_s_light
                        visible: isLed

                        source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                        width: displaySeconds ? preview_rect.digit_width : 0
                        height: width * 4
                        color: text_color
                    }
                    
                    BrightnessContrast {
                        anchors.fill: time_s_light
                        source: time_s_light
                        brightness: 0.5
                        contrast: 0.5
                    }
                    
                    Icon {
                        id: time_s

                        source: isAnalog ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(4) + ".png" : "../img/" + selected_theme + time_12.charAt(4) +".png"
                        width: displaySeconds ? preview_rect.digit_width : 0
                        height: width * 4
                    }

                    HueSaturation {
                        anchors.fill: time_s
                        source: time_s
                        hue: isDigtal ? tubeHue : "0"
                    }
                }

                Item {
                    id: time_ss_box
                    width: displaySeconds ? preview_rect.digit_width : 0
                    height: width * 4
                        
                    Icon {
                        id: time_ss_light
                        visible: isLed

                        source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                        width: displaySeconds ? preview_rect.digit_width : 0
                        height: width * 4
                        color: text_color
                    }
                    
                    BrightnessContrast {
                        anchors.fill: time_ss_light
                        source: time_ss_light
                        brightness: 0.5
                        contrast: 0.5
                    }

                    Icon {
                        id: time_ss

                        source: isAnalog ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(5) + ".png" : "../img/" + selected_theme + time_12.charAt(5) +".png"
                        width: displaySeconds ? preview_rect.digit_width : 0
                        height: width * 4
                    }

                    HueSaturation {
                        anchors.fill: time_ss
                        source: time_ss
                        hue: isDigtal ? tubeHue : "0"
                    }
                }
            }

            Label {
                id: ap_label

                visible: !preview_rect.is24hour
                text: time_12.substring(6)
                anchors {
                    top: isAnalog ? analog_clock.bottom : time_row.bottom
                    right: parent.right
                    rightMargin: units.gu(2)
                }
                color: text_color
            }

            Label {
                id: day_label

                visible: displayDate
                color: text_color
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
                color: text_color
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

                        visible: header_sections.selectedIndex === 2
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

                        visible: header_sections.selectedIndex === 2
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
                        id: preset_name_label
                        
                        visible: header_sections.selectedIndex === 1
                        height: units.gu(3)
                        divider.visible: false

                        ListItemLayout {
                            id: name_field_label_layout
                            Label {
                                id: name_field_label
                                text: i18n.tr("Theme Name")
                                SlotsLayout.position: SlotsLayout.Leading
                                SlotsLayout.overrideVerticalPositioning : true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }

                    ListItem {
                        id: preset_name_setting
                        
                        visible: header_sections.selectedIndex === 1
                        height: units.gu(6)
                        divider.visible: false

                        ListItemLayout {
                            id: name_field_layout
                            
                            TextField {
                                id: name_field
                                text: presetTheme[currentPreset][2]
                            }
                            
                            Button {
                                
                                text: "Save"
                                SlotsLayout.position: SlotsLayout.Trailing
                                SlotsLayout.overrideVerticalPositioning : true
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.leftMargin: units.gu(2)
                                anchors.rightMargin: units.gu(2)
                                height: units.gu(4)
                                onClicked: {
                                    themeName = name_field.text
                                    presetTheme[currentPreset][2] = themeName
                                }
                            }
                        }
                    }
                    
                    ListItem {
                        id: show_fullscreen_setting_item

                        visible: header_sections.selectedIndex === 1
                        height: fs_layout.height * 3 / 4
                        divider.visible: false
                        ListItemLayout {
                            id: fs_layout

                            title.text: i18n.tr("Full screen")

                            Switch {
                                id: fs_switch

                                checked: isFullscreen
                                onCheckedChanged: isFullscreen = checked
                                SlotsLayout.overrideVerticalPositioning : true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        onClicked: {
                            fs_switch.checked = !fs_switch.checked
                        }
                    }

                    ListItem {
                        id: move_digits_setting_item

                        visible: header_sections.selectedIndex === 1
                        height: m_d_lil.height * 3 / 4
                        divider.visible: false
                        ListItemLayout {
                            id: m_d_lil

                            title.text: i18n.tr("Screensaver mode")

                            Switch {
                                id: md_switch

                                checked: moveNumbers
                                onCheckedChanged: { 
                                    moveNumbers = checked
                                    presetTheme[currentPreset][7] = moveNumbers
                                }
                                SlotsLayout.overrideVerticalPositioning : true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        onClicked: {
                            md_switch.checked = !md_switch.checked
                        }
                    }
                    
                    ListItem {
                        id: show_rgb_setting_item

                        visible: header_sections.selectedIndex === 1

                        height: rgb_layout.height * 3 / 4
                        divider.visible: false
                        ListItemLayout {
                            id: rgb_layout

                            title.text: i18n.tr("RGB color selectors")

                            Switch {
                                id: rgb_switch

                                checked: rgbSliders
                                onCheckedChanged: rgbSliders = checked
                                SlotsLayout.overrideVerticalPositioning : true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        onClicked: {
                            rgb_switch.checked = !rgb_switch.checked
                        }
                    }

                    ListItem {
                        id: display_alarms_setting_item

                        visible: header_sections.selectedIndex === 1
                        height: a_layout.height * 3 / 4
                        divider.visible: false

                        ListItemLayout {
                            id: a_layout

                            title.text: i18n.tr("Display active alarms")

                            Switch {
                                id: a_switch

                                checked: displayAlarms
                                onCheckedChanged: {
                                    displayAlarms = checked
                                    presetTheme[currentPreset][5] = displayAlarms
                                }
                                SlotsLayout.overrideVerticalPositioning : true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        onClicked: {
                            a_switch.checked = !a_switch.checked
                        }
                    }

                    ListItem {
                        id: display_date_item

                        visible: header_sections.selectedIndex === 1
                        height: d_layout.height * 3 / 4
                        divider.visible: false
                        ListItemLayout {
                            id: d_layout

                            title.text: i18n.tr("Display date")

                            Switch {
                                id: d_switch

                                checked: displayDate
                                onCheckedChanged: {
                                    displayDate = checked
                                    presetTheme[currentPreset][4] = displayDate
                                }
                            }
                        }
                        onClicked: {
                            d_switch.checked = !d_switch.checked
                        }
                    }

                    ListItem {
                        id: display_seconds_setting_item

                        visible: header_sections.selectedIndex === 1
                        height: s_layout.height * 3 / 4
                        divider.visible: false
                        ListItemLayout {
                            id: s_layout
                            title.text: i18n.tr("Display seconds")

                            Switch {
                                id: s_switch

                                checked: displaySeconds
                                onCheckedChanged: {
                                    displaySeconds = checked
                                    blinkColons = false

                                    presetTheme[currentPreset][3] = displaySeconds
                                    presetTheme[currentPreset][6] = blinkColons
                                }
                            }
                        }
                        onClicked: {
                            s_switch.checked = !s_switch.checked
                        }
                    }

                    Label {
                        id: seconds_warning

                        visible: displaySeconds && header_sections.selectedIndex === 1
                        color: UbuntuColors.red
                        x: units.gu(2)
                        width: parent.width - units.gu(4)
                        text: i18n.tr("WARNING: This setting may reduce battery life")
                        wrapMode: Text.Wrap
                    }

                    ListItem {
                        id: blink_colons_setting_item

                        visible: displaySeconds && header_sections.selectedIndex === 1
                        height: b_layout.height * 3 / 4
                        divider.visible: false
                        ListItemLayout {
                            id: b_layout
                            title.text: i18n.tr("Blinky colons")

                            Switch {
                                id: b_switch

                                checked: blinkColons
                                onCheckedChanged: {
                                    blinkColons = checked
                                    presetTheme[currentPreset][6] = blinkColons
                                }
                                SlotsLayout.overrideVerticalPositioning : true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        onClicked: {
                            b_switch.checked = !b_switch.checked
                        }
                    }

                    ListItem {
                        id: digital_tube_setting_item

                        height: units.gu(9)
                        visible: header_sections.selectedIndex === 0
                        divider.visible: false

                        Column {
                            id: digital_tube_column
                            anchors {
                                left: parent.left
                                leftMargin: units.gu(2)
                                right: parent.right
                                rightMargin: units.gu(2)
                            }
                            spacing: units.dp(3)

                            Label {
                                text: i18n.tr("Tube Clocks")
                            }

                            Flickable {
                                id: digital_tube
                                width: parent.width
                                height: units.gu(4)
                                contentWidth: digital_tube_row.width
                                clip: true

                                Row {
                                    id: digital_tube_row

                                    spacing: units.gu(1)
                                    Repeater {
                                        id: digital_tube_rep

                                        model: [
                                            "digital/b7971/", "digital/nixie_4k/", "digital/nixie_gn1/", "digital/nixie_zm1010/", "digital/nixie_cd66a/",
                                            "digital/in23_1/", "digital/mg17g/", "digital/neo_8000/", "digital/neo_5000/", "digital/zm_1350/"
                                        ]

                                        Item {
                                            width: units.gu(4)
                                            height: units.gu(4)

                                            Icon {
                                                id: digital_tube_icon

                                                source: "../img/" + modelData + "icon.png"
                                                anchors.centerIn: parent
                                                width: height
                                                height: units.gu(4)
                                            }
                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: {
                                                    selected_theme = modelData
                                                    setDisplayType()
                                                    presetTheme[currentPreset][0] = selected_theme
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    ListItem {
                        id: digital_other_setting_item

                        visible: header_sections.selectedIndex === 0
                        divider.visible: false

                        Column {
                            id: digital_other_column
                            anchors {
                                left: parent.left
                                leftMargin: units.gu(2)
                                right: parent.right
                                rightMargin: units.gu(2)
                            }
                            spacing: units.dp(3)

                            Flickable {
                                id: digital_other
                                
                                width: parent.width
                                height: units.gu(6)
                                contentWidth: digital_other_row.width
                                clip: true

                                Row {
                                    id: digital_other_row

                                    spacing: units.gu(1)
                                    Repeater {
                                        id: digital_other_rep

                                        model: [
                                            "digital/iel_0_vi/", "digital/y1938_p/", "digital/itron_dg10b/", "digital/vfd_iv6/",
                                            "digital/nimo_xm1000_a/", "digital/nimo_xm1000_b/", 
                                            "digital/its1a/", "digital/e1t/", "digital/pixie_1/", "digital/pixie_2/"
                                        ]

                                        Item {
                                            width: units.gu(4)
                                            height: units.gu(4)

                                            Icon {
                                                id: digital_led_icon

                                                source: "../img/" + modelData + "icon.png"
                                                anchors.centerIn: parent
                                                width: height
                                                height: units.gu(4)
                                            }
                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: {
                                                    selected_theme = modelData
                                                    setDisplayType()
                                                    presetTheme[currentPreset][0] = selected_theme
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    ListItem {
                        height: units.gu(6)
                        divider.visible: true
                        visible: header_sections.selectedIndex === 0

                        ListItemLayout {
                            id: tubeHue_layout
                            
                            Label {
                                id: slider_tube_h_label
                                text: i18n.tr("Tube Hue")
                                SlotsLayout.position: SlotsLayout.Leading
                                SlotsLayout.overrideVerticalPositioning : true
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Slider {
                                id: slider_h
                                
                                SlotsLayout.position: SlotsLayout.Trailing
                                SlotsLayout.overrideVerticalPositioning : true
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.leftMargin: units.gu(2)
                                anchors.rightMargin: units.gu(2)

                                live: true
                                minimumValue: 0
                                maximumValue: 1
                                value: !slider_h.pressed ? tubeHue : ""
                                onValueChanged: {
                                    tubeHue = slider_h.value
                                    presetTheme[currentPreset][1] = tubeHue
                                }
                            }
                        }
                    }

                    ListItem {
                        id: digital_led_setting_item

                        height: units.gu(10)
                        visible: header_sections.selectedIndex === 0
                        divider.visible: true

                        Column {
                            id: digital_led_column
                            anchors {
                                left: parent.left
                                leftMargin: units.gu(2)
                                right: parent.right
                                rightMargin: units.gu(2)
                            }
                            spacing: units.dp(3)

                            Label {
                                text: i18n.tr("L.E.D. & Flip Clocks")
                            }

                            Flickable {
                                id: digital_led
                                
                                width: parent.width
                                height: units.gu(4)
                                contentWidth: digital_led_row.width
                                clip: true

                                Row {
                                    id: digital_led_row

                                    spacing: units.gu(1)
                                    Repeater {
                                        id: digital_led_rep

                                        model: [
                                            "leds/hp_5802_7002/", "leds/hdsp_960x/", "leds/hp_5802_7000_1970/", "leds/hp_5802_7000_1987/",
                                            "leds/tia8447/", "other/flip_blk/", "other/flip_wht/"
                                        ]

                                        Item {
                                            width: units.gu(4)
                                            height: units.gu(4)

                                            Icon {
                                                id: digital_led_icon

                                                source: "../img/" + modelData + "icon.png"
                                                anchors.centerIn: parent
                                                width: height
                                                height: units.gu(4)
                                            }
                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: {
                                                    selected_theme = modelData
                                                    setDisplayType()
                                                    presetTheme[currentPreset][0] = selected_theme
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    ListItem {
                        id: analog_theme_setting_item

                        visible: header_sections.selectedIndex === 0
                        divider.visible: false

                        Column {
                            id: analog_theme_column
                            anchors {
                                left: parent.left
                                leftMargin: units.gu(2)
                                right: parent.right
                                rightMargin: units.gu(2)
                            }
                            spacing: units.dp(3)

                            Label {
                                text: i18n.tr("Analog Clocks")
                            }

                            Flickable {
                                id: analog_theme_type
                                
                                width: parent.width
                                height: units.gu(4)
                                contentWidth: analog_theme_row.width
                                clip: true

                                Row {
                                    id: analog_theme_row

                                    spacing: units.gu(1)
                                    Repeater {
                                        id: analog_theme_rep

                                        model: [
                                            "analog/vfd_fip60/", "analog/vfd48/",
                                            "analog/osc_e/", "analog/osc_d/", "analog/osc_c/",
                                            "analog/osc_b/", "analog/osc_a/"
                                        ]

                                        Item {
                                            width: units.gu(4)
                                            height: units.gu(4)

                                            Icon {
                                                id: analog_theme_icon

                                                source: "../img/" + modelData + "icon.png"
                                                anchors.centerIn: parent
                                                width: height
                                                height: units.gu(4)
                                            }
                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: {
                                                    selected_theme = modelData
                                                    setDisplayType()
                                                    presetTheme[currentPreset][0] = selected_theme
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    ListItem {
                        id: display_oscilloscope_setting_item

                        visible: header_sections.selectedIndex === 0
                        height: osc_layout.height
                        divider.visible: true

                        ListItemLayout {
                            id: osc_layout

                            title.text: i18n.tr("Hide Oscilloscope Background")

                            Switch {
                                id: osc_switch

                                checked: hideOscilloscope
                                onCheckedChanged: {
                                    hideOscilloscope = checked
                                    presetTheme[currentPreset][8] = hideOscilloscope
                                }
                                SlotsLayout.overrideVerticalPositioning : true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        onClicked: {
                            osc_switch.checked = !osc_switch.checked
                        }
                    }
                                      
                    ListItem {
                        id: text_color_setting_slider
                        visible: !rgbSliders && header_sections.selectedIndex === 0
                        divider.visible: false
                                height: units.gu(8)

                        Column {
                            id: text_color_slider_column
                            anchors {
                                left: parent.left
                                leftMargin: units.gu(2)
                                right: parent.right
                                rightMargin: units.gu(2)
                            }

                            Label {
                                text: i18n.tr("Foreground colour")
                            }

                            Row {
                                width: parent.width
                                anchors.right: parent.right
                                anchors.left: parent.left

                                Item {
                                    id: custom_text_color_slider_rect

                                    width: units.gu(3)
                                    height: units.gu(4)

                                    Icon {
                                        name: "edit"
                                        width: units.gu(3)
                                        height: width
                                        anchors.left: parent.left
                                        anchors.bottom: parent.bottom
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            color_edited = "text_color"
                                            page_stack.push(Qt.resolvedUrl("CustomColor.qml"))
                                        }
                                    }
                                }

                                ListItemLayout {
                                    Slider {
                                        id: slider_text_h
                                        
                                        SlotsLayout.position: SlotsLayout.Trailing
                                        anchors.right: parent.right
                                        anchors.leftMargin: units.gu(2)
                                        anchors.rightMargin: units.gu(3)
                                        
                                        Image {
                                            id: text_hue_background
                                            
                                            height: units.gu(3.5)
                                            z: -1
                                            source: "../img/bars/text_color_bar.png"
                                            fillMode: Image.Stretch
                                            anchors.right: parent.right
                                            anchors.left: parent.left
                                        }

                                        live: true
                                        minimumValue: -0.2
                                        maximumValue: 1
                                        
                                        function formatValue(v) { 
                                            if ((v*100) <= 0) {
                                                return (v * 1280).toFixed(0)
                                            } else {
                                                return (v * 360).toFixed(0)
                                            }
                                        }
                                        
                                        // Causes binding loop but I could not figure out how to bind 
                                        // it to two different settings for the dual use slider using onCompleted.
                                        value: 
                                        if ( text_color.hsvSaturation == 0 ) {
                                            !slider_text_h.pressed ? (((1-text_color.hsvValue)*-1)/5) : ""
                                        } else {
                                            !slider_text_h.pressed ? text_color.hsvHue : ""
                                        }
                                        
                                        onValueChanged: {
                                            if ((slider_text_h.value*1000) < 1) {
                                                text_color = Qt.hsva(1, 0, 1-((slider_text_h.value*-1)*5), 1)
                                            } else if (text_color.hsvSaturation == 0) {
                                                text_color = Qt.hsva(slider_text_h.value, 1, 1, 1)
                                            } else {
                                                text_color = Qt.hsva(slider_text_h.value, text_color.hsvSaturation, text_color.hsvValue, 1)
                                            }
                                            savePresetTextColor(text_color)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    ListItem {
                        id: back_color_setting_slider
                        visible: !rgbSliders && header_sections.selectedIndex === 0
                        divider.visible: true
                                height: units.gu(8)

                        Column {
                            id: back_color_slider_column
                            anchors {
                                left: parent.left
                                leftMargin: units.gu(2)
                                right: parent.right
                                rightMargin: units.gu(2)
                            }

                            Label {
                                text: i18n.tr("Background colour")
                            }

                            Row {
                                width: parent.width
                                anchors.right: parent.right
                                anchors.left: parent.left

                                Item {
                                    id: custom_back_color_slider_rect

                                    width: units.gu(3)
                                    height: units.gu(4)

                                    Icon {
                                        name: "edit"
                                        width: units.gu(3)
                                        height: width
                                        anchors.left: parent.left
                                        anchors.bottom: parent.bottom
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            color_edited = "back_color"
                                            page_stack.push(Qt.resolvedUrl("CustomColor.qml"))
                                        }
                                    }
                                }

                                ListItemLayout {
                                    Slider {
                                        id: slider_back_h
                                        
                                        SlotsLayout.position: SlotsLayout.Trailing
                                        anchors.right: parent.right
                                        anchors.leftMargin: units.gu(2)
                                        anchors.rightMargin: units.gu(3)
                                        
                                        Image {
                                            id: back_hue_background
                                            
                                            height: units.gu(3.5)
                                            z: -1
                                            source: "../img/bars/back_color_bar.png"
                                            fillMode: Image.Stretch
                                            anchors.right: parent.right
                                            anchors.left: parent.left
                                        }

                                        live: true
                                        minimumValue: -1
                                        maximumValue: 1
                                        
                                        function formatValue(v) { 
                                            if ((v*100) <= 0) {
                                                return (v * 256).toFixed(0)
                                            } else {
                                                return (v * 360).toFixed(0)
                                            }
                                        }
                                        
                                        // Causes binding loop but I could not figure out how to bind 
                                        // it to two different settings for the dual use slider using onCompleted.
                                        value: if ( back_color.hsvSaturation == 0 ) {
                                            !slider_back_h.pressed ? ((1-back_color.hsvValue)*-1) : ""
                                        } else {
                                            !slider_back_h.pressed ? back_color.hsvHue : ""
                                        }
                                        
                                        onValueChanged: {
                                            if ((slider_back_h.value*1000) < 1) {
                                                back_color = Qt.hsva(1, 0, 1-(slider_back_h.value*-1), 1)
                                            } else if (back_color.hsvSaturation == 0) {
                                                back_color = Qt.hsva(slider_back_h.value, 0.5, 0.35, 1)
                                            } else {
                                                back_color = Qt.hsva(slider_back_h.value, back_color.hsvSaturation, back_color.hsvValue, 1)
                                            }
                                            savePresetBackColor(back_color)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    ListItem {
                        id: text_color_setting_item
                        visible: rgbSliders && header_sections.selectedIndex === 0
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
                                                text_color = text_color_rect.color
                                                savePresetTextColor(text_color)
                                            }
                                        }
                                    }
                                }

                            }
                        }
                    }

                    ListItem {
                        id: background_color_setting_item
                        visible: rgbSliders && header_sections.selectedIndex === 0
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
                                                back_color = back_color_rect.color
                                                savePresetBackColor(back_color)
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
