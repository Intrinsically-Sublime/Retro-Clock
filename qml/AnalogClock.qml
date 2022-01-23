import QtQuick 2.4
import Ubuntu.Components 1.3
import "../img"

Item {
    id: analog_root

    property color main_color: isDayMode ? text_color_day
                                         : text_color

    Icon {
        id: hour_hand

        source: "../img/analog/hour-hand.svg"
        width: parent.width
        height: width
        color: main_color
        rotation: (60 * parseInt(time_analog.substring(0,2), 10) + parseInt(time_analog.substring(2,4), 10))/2
    }

    Icon {
        id: min_hand

        source: "../img/analog/min-hand.svg"
        width: parent.width
        height: width
        color: main_color
        rotation: parseInt(time_analog.substring(2,4), 10) * 6
    }

    Icon {
        id: sec_hand

        visible: displaySeconds
        source: "../img/analog/sec-hand.svg"
        width: parent.width
        height: width
        color: main_color
        rotation: sec_analog
    }

    Icon {
        id: background

        source: "../img/analog/back.svg"
        width: parent.width
        height: width
        color: main_color
    }
}

