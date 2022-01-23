import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    id: root_custom_color

    property color temp_text_color: isDayMode ? text_color_day : text_color
    property color temp_back_color: isDayMode ? back_color_day : back_color

    function setColor()
    {
        return color_edited == "text_color" ? temp_text_color = Qt.rgba(slider_r.value, slider_g.value, slider_b.value, 1)
                                            : temp_back_color = Qt.rgba(slider_r.value, slider_g.value, slider_b.value, 1)
    }

    header: PageHeader {
        id: main_header

        title: color_edited == "text_color" ? i18n.tr("Foreground colour")
                                            : i18n.tr("Background colour")
        StyleHints {
            backgroundColor: isDayMode ? "#e8ae0e" : "#0a2449"
            foregroundColor: isDayMode ? "#0a2449" : "#e8ae0e"
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
                    isDayMode ? text_color_day = temp_text_color
                              : text_color = temp_text_color
                    isDayMode ? back_color_day = temp_back_color
                              : back_color = temp_back_color
                    page_stack.pop()
                }
            }
        ]
    }

    Component.onCompleted: {
        if(color_edited == "text_color") {
            slider_r.value = isDayMode ? text_color_day.r
                                       : text_color.r
            slider_g.value = isDayMode ? text_color_day.g
                                       : text_color.g
            slider_b.value = isDayMode ? text_color_day.b
                                       : text_color.b
        }
        else {
            slider_r.value = isDayMode ? back_color_day.r
                                       : back_color.r
            slider_g.value = isDayMode ? back_color_day.g
                                       : back_color.g
            slider_b.value = isDayMode ? back_color_day.b
                                       : back_color.b
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
            property int digit_width: displaySeconds ? Math.min(preview_rect.width*2/13, (preview_rect.height - day_label.height - date_label.height - ap_label.height - units.gu(8))*2/3)
                                                     : Math.min(preview_rect.width*4/17, (preview_rect.height - day_label.height - date_label.height - ap_label.height - units.gu(8))*2/3)

            color: temp_back_color
            width: isLandscape ? root_custom_color.width/2 : root_custom_color.width
            height: isLandscape ? root_custom_color.height - main_header.height : (root_custom_color.height - main_header.height)/2

            AnalogClock {
                id: analog_clock

                visible: selected_theme === "analog"
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
                    color: temp_text_color
                }

                Icon {
                    id: time_hh

                    source: selected_theme === "analog" ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(1) + ".svg" : "../img/" + selected_theme + time_12.charAt(1) + ".svg"
                    width: preview_rect.digit_width
                    height: width * 3/2
                    color: temp_text_color
                }

                Icon {
                    id: time_colon

                    source: selected_theme === "analog" ? "" : "../img/" + selected_theme + "colon.svg"
                    width: preview_rect.digit_width/4
                    height: time_h.height
                    color: temp_text_color
                }

                Icon {
                    id: time_m

                    source: selected_theme === "analog" ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(2) + ".svg" : "../img/" + selected_theme + time_12.charAt(2) +".svg"
                    width: preview_rect.digit_width
                    height: width * 3/2
                    color: temp_text_color
                }

                Icon {
                    id: time_mm

                    source: selected_theme === "analog" ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(3) + ".svg" : "../img/" + selected_theme + time_12.charAt(3) +".svg"
                    width: preview_rect.digit_width
                    height: width * 3/2
                    color: temp_text_color
                }

                Icon {
                    id: sec_colon

                    source: selected_theme === "analog" ? "" : "../img/" + selected_theme + "colon.svg"
                    width: displaySeconds ? preview_rect.digit_width/4 : 0
                    height: time_h.height
                    color: temp_text_color
                }

                Icon {
                    id: time_s

                    source: selected_theme === "analog" ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(4) + ".svg" : "../img/" + selected_theme + time_12.charAt(4) +".svg"
                    width: displaySeconds ? preview_rect.digit_width : 0
                    height: width * 3/2
                    color: temp_text_color
                }

                Icon {
                    id: time_ss

                    source: selected_theme === "analog" ? "" : preview_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(5) + ".svg" : "../img/" + selected_theme + time_12.charAt(5) +".svg"
                    width: displaySeconds ? preview_rect.digit_width : 0
                    height: width * 3/2
                    color: temp_text_color
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
            }
        }
    }
}

