import QtQuick 2.4
import Ubuntu.Components 1.3
import QtGraphicalEffects 1.12

Item {
    id: root

    property int digitWidth
    
    property bool blankDigit: (display_back_rect.is24hour && !display_back_rect.withLeadingZero && time_24.charAt(0) == "0") ||
        (!display_back_rect.is24hour && !display_back_rect.withLeadingZero && time_12.charAt(0) == "0") ? 1 : 0
    

    width: displaySeconds ? digitWidth * 17 / 2 : digitWidth * 21 / 4
    height: digitWidth * 3

    Row {
        id: time_row

        anchors.fill: parent


        Item {
            id: time_h_box
            width: digitWidth
            height: width * 4
                
            Icon {
                id: time_h_light
                visible: isLed

                source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                width: digitWidth
                height: width * 4
                color: isDayMode ? text_color_day : text_color
            }
                    
            BrightnessContrast {
                anchors.fill: time_h_light
                source: time_h_light
                brightness: 0.5
                contrast: 0.5
            }
            
            Icon {
                id: time_h
                
                source: blankDigit ? "../img/" + selected_theme + "blank.png" : isAnalog ? "" : display_back_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(0) + ".png" : "../img/" + selected_theme + time_12.charAt(0) + ".png"
                width: digitWidth
                height: width * 4
            }

            HueSaturation {
                anchors.fill: time_h
                source: time_h
                hue: isDigtal ? isDayMode ? tube_hue_day : tube_hue : "0"
            }
        }

        Item {
            id: time_hh_box
            width: digitWidth
            height: width * 4
                
            Icon {
                id: time_hh_light
                visible: isLed

                source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                width: digitWidth
                height: width * 4
                color: isDayMode ? text_color_day : text_color
            }
                    
            BrightnessContrast {
                anchors.fill: time_hh_light
                source: time_hh_light
                brightness: 0.5
                contrast: 0.5
            }

            Icon {
                id: time_hh

                source: isAnalog ? "" : display_back_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(1) + ".png" : "../img/" + selected_theme + time_12.charAt(1) + ".png"
                width: digitWidth
                height: width * 4
            }

            HueSaturation {
                anchors.fill: time_hh
                source: time_hh
                hue: isDigtal ? isDayMode ? tube_hue_day : tube_hue : "0"
            }
        }

        Item {
            id: time_colon_box
            width: digitWidth
            height: width * 4
                
            Icon {
                id: time_colon_light
                visible: isLed

                source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                width: digitWidth
                height: width * 4
                color: isDayMode ? text_color_day : text_color
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
                width: digitWidth
                height: digitWidth * 4
            }

            HueSaturation {
                anchors.fill: time_colon
                source: time_colon
                hue: isDigtal ? isDayMode ? tube_hue_day : tube_hue : "0"
            }
        }

        Item {
            id: time_m_box
            width: digitWidth
            height: width * 4
                
            Icon {
                id: time_m_light
                visible: isLed

                source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                width: digitWidth
                height: width * 4
                color: isDayMode ? text_color_day : text_color
            }
                    
            BrightnessContrast {
                anchors.fill: time_m_light
                source: time_m_light
                brightness: 0.5
                contrast: 0.5
            }

            Icon {
                id: time_m

                source: isAnalog ? "" : display_back_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(2) + ".png" : "../img/" + selected_theme + time_12.charAt(2) +".png"
                width: digitWidth
                height: width * 4
            }

            HueSaturation {
                anchors.fill: time_m
                source: time_m
                hue: isDigtal ? isDayMode ? tube_hue_day : tube_hue : "0"
            }
        }

        Item {
            id: time_mm_box
            width: digitWidth
            height: width * 4
                
            Icon {
                id: time_mm_light
                visible: isLed

                source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                width: digitWidth
                height: width * 4
                color: isDayMode ? text_color_day : text_color
            }
                    
            BrightnessContrast {
                anchors.fill: time_mm_light
                source: time_mm_light
                brightness: 0.5
                contrast: 0.5
            }

            Icon {
                id: time_mm

                source: isAnalog ? "" : display_back_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(3) + ".png" : "../img/" + selected_theme + time_12.charAt(3) +".png"
                width: digitWidth
                height: width * 4
            }

            HueSaturation {
                anchors.fill: time_mm
                source: time_mm
                hue: isDigtal ? isDayMode ? tube_hue_day : tube_hue : "0"
            }
        }

        Item {
            id: time_sec_colon_box
            width: digitWidth
            height: width * 4
                
            Icon {
                id: time_sec_colon_light
                visible: (displaySeconds && isLed)

                source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                width: displaySeconds ? digitWidth : 0
                height: width * 4
                color: isDayMode ? text_color_day : text_color
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
                width: displaySeconds ? digitWidth : 0
                height: digitWidth * 4
                //i & 1 == 1 ? console.log("odd") : console.log("even");
            }

            HueSaturation {
                anchors.fill: sec_colon
                source: time_colon
                hue: isDigtal ? isDayMode ? tube_hue_day : tube_hue : "0"
            }
        }

        Item {
            id: time_s_box
            width: digitWidth
            height: width * 4
                
            Icon {
                id: time_s_light
                visible: (displaySeconds && isLed)

                source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                width: displaySeconds ? digitWidth : 0
                height: width * 4
                color: isDayMode ? text_color_day : text_color
            }
                    
            BrightnessContrast {
                anchors.fill: time_s_light
                source: time_s_light
                brightness: 0.5
                contrast: 0.5
            }

            Icon {
                id: time_s

                source: isAnalog ? "" : display_back_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(4) + ".png" : "../img/" + selected_theme + time_12.charAt(4) +".png"
                width: displaySeconds ? digitWidth : 0
                height: width * 4
            }

            HueSaturation {
                anchors.fill: time_s
                source: time_s
                hue: isDigtal ? isDayMode ? tube_hue_day : tube_hue : "0"
            }
        }

        Item {
            id: time_ss_box
            width: digitWidth
            height: width * 4
                
            Icon {
                id: time_ss_light
                visible: (displaySeconds && isLed)

                source: isLed ? "../img/" + selected_theme + "light.svg" : ""
                width: displaySeconds ? digitWidth : 0
                height: width * 4
                color: isDayMode ? text_color_day : text_color
            }
                    
            BrightnessContrast {
                anchors.fill: time_ss_light
                source: time_ss_light
                brightness: 0.5
                contrast: 0.5
            }

            Icon {
                id: time_ss

                source: isAnalog ? "" : display_back_rect.is24hour ? "../img/" + selected_theme + time_24.charAt(5) + ".png" : "../img/" + selected_theme + time_12.charAt(5) +".png"
                width: displaySeconds ? digitWidth : 0
                height: width * 4
            }

            HueSaturation {
                anchors.fill: time_ss
                source: time_ss
                hue: isDigtal ? isDayMode ? tube_hue_day : tube_hue : "0"
            }
        }
    }
}

