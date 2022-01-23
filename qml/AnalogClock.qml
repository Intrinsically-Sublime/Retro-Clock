import QtQuick 2.4
import Ubuntu.Components 1.3
import "../img"

Item {
    id: analog_root

    property color main_color: text_color
    
    Icon {
        id: background

        source: selected_theme.slice(0,6) == "analog" && !hideOscilloscope ? "../img/" + selected_theme + "back.png" : ""
        width: parent.width
        height: width
    }
    Icon {
        id: face

        source: selected_theme.slice(0,6) == "analog" ? "../img/" + selected_theme + "back.svg" : ""
        width: parent.width
        height: width
        color: main_color
    }
    
    Icon {
        id: hour_hand

        source: selected_theme.slice(0,6) == "analog" ? "../img/" + selected_theme + "hour-hand.svg" : ""
        width: parent.width
        height: width
        color: main_color
        rotation: (60 * parseInt(time_analog.substring(0,2), 10) + parseInt(time_analog.substring(2,4), 10))/2
    }

    Icon {
        id: min_hand

        source: selected_theme.slice(0,6) == "analog" ? "../img/" + selected_theme + "min-hand.svg" : ""
        width: parent.width
        height: width
        color: main_color
        rotation: parseInt(time_analog.substring(2,4), 10) * 6
    }

    Icon {
        id: sec_hand

        visible: displaySeconds
        source: selected_theme.slice(0,6) == "analog" ? "../img/" + selected_theme + "sec-hand.svg" : ""
        width: parent.width
        height: width
        color: main_color
        rotation: sec_analog
    }
    
    Icon {
        id: mask

        source: selected_theme.slice(0,6) == "analog" ? "../img/" + selected_theme + "mask.png" : ""
        width: parent.width
        height: width
    }
}

