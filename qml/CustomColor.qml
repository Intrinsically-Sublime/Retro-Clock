import QtQuick 2.4
import Ubuntu.Components 1.3
import QtGraphicalEffects 1.12

Page {
    id: root_custom_color

    property color temp_text_color: text_color
    property color temp_back_color: back_color

    property bool blankDigit: (preview_rect.is24hour && !preview_rect.withLeadingZero && time_24.charAt(0) == "0") ||
             (!preview_rect.is24hour && !preview_rect.withLeadingZero && time_12.charAt(0) == "0") ? 1 : 0
                        
    function setColor()
    {
        return color_edited == "text_color" ? temp_text_color = Qt.rgba(slider_r.value, slider_g.value, slider_b.value, 1)
                                            : temp_back_color = Qt.rgba(slider_r.value, slider_g.value, slider_b.value, 1)
    }

    function setColorHSV()
    {
        return color_edited == "text_color" ? temp_text_color = Qt.hsva(slider_hue.value, slider_sat.value, slider_val.value, 1)
                                            : temp_back_color = Qt.hsva(slider_hue.value, slider_sat.value, slider_val.value, 1)
    }
    
    header: PageHeader {
        id: main_header

        title: color_edited == "text_color" ? i18n.tr("Foreground colour for " + presetTheme[currentPreset][2])
                                            : i18n.tr("Background colour for " + presetTheme[currentPreset][2])
        StyleHints {
            backgroundColor: back_color
        }
        leadingActionBar.actions: [
            Action {
                iconName: "close"
                onTriggered: {
                    page_stack.pop()
                }
            }
        ]
        trailingActionBar.actions: [
            Action {
                iconName: "ok"

                onTriggered: {
                    text_color = temp_text_color
                    back_color = temp_back_color
                    savePresetBackColor(back_color)
                    savePresetTextColor(text_color)
                    page_stack.pop()
                }
            }
        ]
    }

    Component.onCompleted: {
        if(color_edited == "text_color") {
            slider_r.value = text_color.r
            slider_g.value = text_color.g
            slider_b.value = text_color.b
            slider_hue.value = text_color.hsvHue
            slider_sat.value = text_color.hsvSaturation
            slider_val.value = text_color.hsvValue
        }
        else {
            slider_r.value = back_color.r
            slider_g.value = back_color.g
            slider_b.value = back_color.b
            slider_hue.value = back_color.hsvHue
            slider_sat.value = back_color.hsvSaturation
            slider_val.value = back_color.hsvValue
        }
    }

    Flow {
        id: main_flow

        width: parent.width
        anchors.top: main_header.bottom
        spacing: 0

        Rectangle {
            id: preview_rect

            property bool withLeadingZero: time_format === "hh:mm" || time_format === "hh:mm ap"
            property bool is24hour: time_format === "hh:mm" || time_format === "h:mm"
            property int digit_width: displaySeconds ? Math.min(preview_rect.width*2/16, (preview_rect.height - day_label.height - date_label.height - ap_label.height - units.gu(8))*2/3)
                                                     : Math.min(preview_rect.width*4/20, (preview_rect.height - day_label.height - date_label.height - ap_label.height - units.gu(8))*2/3)

            color: temp_back_color
            width: isLandscape ? root_custom_color.width/2 : root_custom_color.width
            height: isLandscape ? root_custom_color.height - main_header.height : (root_custom_color.height - main_header.height)/2

            AnalogClock {
                id: analog_clock

                visible: isAnalog
                main_color: temp_text_color
                width: (preview_rect.height - day_label.height - date_label.height - ap_label.height - units.gu(8))
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
                        color: temp_text_color
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
                        color: temp_text_color
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
                        anchors.fill: time_hh_box
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
                        color: temp_text_color
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
                        color: temp_text_color
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
                        color: temp_text_color
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
                        color: temp_text_color
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
                        color: temp_text_color
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
                        color: temp_text_color
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
                color: temp_text_color
            }

            Label {
                id: day_label

                color: temp_text_color
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

                color: temp_text_color
                text: this_date
                anchors {
                    top: day_label.bottom
                    topMargin: units.gu(1)
                    left: day_label.left
                }
            }
        }

        Item {

            width: preview_rect.width
            height: preview_rect.height

            Column {
                id: main_column

                anchors.fill: parent

                SlotsLayout {
                    visible: rgbSliders
                    mainSlot: Slider {
                        id: slider_r

                        live: true
                        minimumValue: 0
                        maximumValue: 1
                        function formatValue(v) { return (v * 255).toFixed(0) }
                        onValueChanged: setColor()
                    }

                    Rectangle {
                        color: "red"
                        width: units.gu(3)
                        height: width
                        radius: height / 2
                        SlotsLayout.position: SlotsLayout.Leading
                        SlotsLayout.overrideVerticalPositioning : true
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                SlotsLayout {
                    visible: rgbSliders
                    mainSlot: Slider {
                        id: slider_g

                        live: true
                        minimumValue: 0
                        maximumValue: 1
                        function formatValue(v) { return (v * 255).toFixed(0) }
                        onValueChanged: setColor()
                    }

                    Rectangle {
                        color: "green"
                        width: units.gu(3)
                        height: width
                        radius: height / 2
                        SlotsLayout.position: SlotsLayout.Leading
                        SlotsLayout.overrideVerticalPositioning : true
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                SlotsLayout {
                    visible: rgbSliders
                    mainSlot: Slider {
                        id: slider_b

                        live: true
                        minimumValue: 0
                        maximumValue: 1
                        function formatValue(v) { return (v * 255).toFixed(0) }
                        onValueChanged: setColor()
                    }

                    Rectangle {
                        color: "blue"
                        width: units.gu(3)
                        height: width
                        radius: height / 2
                        SlotsLayout.position: SlotsLayout.Leading
                        SlotsLayout.overrideVerticalPositioning : true
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                                  
                ListItem {
                    visible: !rgbSliders
                    id: hue_setting_item
                    divider.visible: false
                    height: units.gu(8)

                    Column {
                        id: hue_column
                        anchors {
                            left: parent.left
                            leftMargin: units.gu(2)
                            right: parent.right
                            rightMargin: units.gu(2)
                        }

                        Label {
                            text: i18n.tr("Hue")
                        }

                        Row {
                            width: parent.width
                            anchors.right: parent.right
                            anchors.left: parent.left

                            ListItemLayout {
                                Slider {
                                    id: slider_hue
                                    
                                    SlotsLayout.position: SlotsLayout.Trailing
                                    anchors.right: parent.right
                                    anchors.leftMargin: units.gu(2)
                                    
                                    Image {
                                        id: hue_background
                                        
                                        height: units.gu(3.5)
                                        z: -1
                                        source: "../img/bars/hue_bar.png"
                                        fillMode: Image.Stretch
                                        anchors.right: parent.right
                                        anchors.left: parent.left
                                    }

                                    live: true
                                    minimumValue: 0
                                    maximumValue: 1
                                    
                                    function formatValue(v) { return (v * 360).toFixed(0) }
                                    
                                    onValueChanged: {
                                        setColorHSV()
                                    }
                                }
                            }
                        }
                    }
                }
                                  
                ListItem {
                    visible: !rgbSliders
                    id: saturation_setting_item
                    divider.visible: false
                            height: units.gu(8)

                    Column {
                        id: saturation_column
                        anchors {
                            left: parent.left
                            leftMargin: units.gu(2)
                            right: parent.right
                            rightMargin: units.gu(2)
                        }

                        Label {
                            text: i18n.tr("Saturation")
                        }

                        Row {
                            width: parent.width
                            anchors.right: parent.right
                            anchors.left: parent.left

                            ListItemLayout {
                                Slider {
                                    id: slider_sat
                                    
                                    SlotsLayout.position: SlotsLayout.Trailing
                                    anchors.right: parent.right
                                    anchors.leftMargin: units.gu(2)
                                    
                                    Image {
                                        id: sat_background
                                        
                                        height: units.gu(3.5)
                                        z: -1
                                        source: "../img/bars/saturation_bar.png"
                                        fillMode: Image.Stretch
                                        anchors.right: parent.right
                                        anchors.left: parent.left
                                    }

                                    HueSaturation {
                                        z: -1
                                        anchors.fill: sat_background
                                        source: sat_background
                                        hue: slider_hue.value
                                    }

                                    live: true
                                    minimumValue: 0
                                    maximumValue: 1
                                    
                                    function formatValue(v) { return (v * 256).toFixed(0) }
                                    
                                    onValueChanged: {
                                        setColorHSV()
                                    }
                                }
                            }
                        }
                    }
                }
                                  
                ListItem {
                    visible: !rgbSliders
                    id: value_setting_item
                    divider.visible: false
                            height: units.gu(8)

                    Column {
                        id: value_column
                        anchors {
                            left: parent.left
                            leftMargin: units.gu(2)
                            right: parent.right
                            rightMargin: units.gu(2)
                        }

                        Label {
                            text: i18n.tr("Value")
                        }

                        Row {
                            width: parent.width
                            anchors.right: parent.right
                            anchors.left: parent.left

                            ListItemLayout {
                                Slider {
                                    id: slider_val
                                    
                                    SlotsLayout.position: SlotsLayout.Trailing
                                    anchors.right: parent.right
                                    anchors.leftMargin: units.gu(2)
                                    
                                    Image {
                                        id: value_background
                                        
                                        height: units.gu(3.5)
                                        z: -1
                                        source: "../img/bars/value_bar.png"
                                        fillMode: Image.Stretch
                                        anchors.right: parent.right
                                        anchors.left: parent.left
                                    }

                                    live: true
                                    minimumValue: 0
                                    maximumValue: 1
                                    
                                    function formatValue(v) { return (v * 256).toFixed(0) }
                                    
                                    onValueChanged: {
                                        setColorHSV()
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

