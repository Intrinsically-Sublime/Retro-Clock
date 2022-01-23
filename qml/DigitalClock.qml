import QtQuick 2.4
import Ubuntu.Components 1.3

Item {
    id: root

    property int digitWidth

    width: displaySeconds ? digitWidth * 13 / 2 : digitWidth * 17 / 4
    height: digitWidth * 3 / 2

    Row {
        id: time_row

        anchors.fill: parent

        Icon {
            id: time_h

            opacity: (display_back_rect.is24hour && !display_back_rect.withLeadingZero && time_24.charAt(0) == "0") ||
                     (!display_back_rect.is24hour && !display_back_rect.withLeadingZero && time_12.charAt(0) == "0") ? 0 : 1
            source: selected_theme === "analog" ? "" : display_back_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(0) + ".svg" : "../img/" + selected_theme + time_12.charAt(0) + ".svg"
            width: digitWidth
            height: width * 3 / 2
            color: isDayMode ? text_color_day
                             : text_color
        }

        Icon {
            id: time_hh

            source: selected_theme === "analog" ? "" : display_back_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(1) + ".svg" : "../img/" + selected_theme + time_12.charAt(1) + ".svg"
            width: digitWidth
            height: width * 3 / 2
            color: isDayMode ? text_color_day
                             : text_color
        }

        Icon {
            id: time_colon

            source: selected_theme === "analog" ? "" : "../img/" + selected_theme + "colon.svg"
            width: digitWidth / 4
            height: digitWidth * 3 / 2
            color: isDayMode ? text_color_day
                             : text_color
        }

        Icon {
            id: time_m

            source: selected_theme === "analog" ? "" : display_back_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(2) + ".svg" : "../img/" + selected_theme + time_12.charAt(2) +".svg"
            width: digitWidth
            height: width * 3 / 2
            color: isDayMode ? text_color_day
                             : text_color
        }

        Icon {
            id: time_mm

            source: selected_theme === "analog" ? "" : display_back_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(3) + ".svg" : "../img/" + selected_theme + time_12.charAt(3) +".svg"
            width: digitWidth
            height: width * 3 / 2
            color: isDayMode ? text_color_day
                             : text_color
        }

        Icon {
            id: sec_colon

            source: selected_theme === "analog" ? "" : "../img/" + selected_theme + "colon.svg"
            width: displaySeconds ? digitWidth / 4 : 0
            height: digitWidth * 3 / 2
            color: isDayMode ? text_color_day
                             : text_color
        }

        Icon {
            id: time_s

            source: selected_theme === "analog" ? "" : display_back_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(4) + ".svg" : "../img/" + selected_theme + time_12.charAt(4) +".svg"
            width: displaySeconds ? digitWidth : 0
            height: width * 3 / 2
            color: isDayMode ? text_color_day
                             : text_color
        }

        Icon {
            id: time_ss

            source: selected_theme === "analog" ? "" : display_back_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(5) + ".svg" : "../img/" + selected_theme + time_12.charAt(5) +".svg"
            width: displaySeconds ? digitWidth : 0
            height: width * 3 / 2
            color: isDayMode ? text_color_day
                             : text_color
        }
    }
}

