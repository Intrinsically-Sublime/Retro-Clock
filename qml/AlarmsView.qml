import QtQuick 2.4
import Ubuntu.Components 1.3

Item {
    id: root_alarm_view

    Connections {
        target: Qt.application
        onStateChanged:
            if(Qt.application.state == Qt.ApplicationActive) {
                list_view.model.refresh()
            }
    }

    ListView {
        id: list_view

        anchors.fill: parent
        snapMode: ListView.SnapToItem
        clip: true
        model: AlarmModel {id: alarm_model}
        delegate:
            ListItem {
            visible: model.enabled
            height: model.enabled ? lil.height : 0
            divider.visible: false

            Component.onCompleted: alarm_del_h =  lil.height

            SlotsLayout {
                id: lil

                mainSlot: Column {

                    Label {
                        color: isDayMode ? text_color_day
                                         : text_color
                        text: message
                        width: parent.width
                        elide: Text.ElideRight
                    }

                    Label {
                        color: isDayMode ? text_color_day
                                         : text_color
                        text: Qt.formatDateTime(date, time_format)
                        textSize: Label.XLarge
                    }

                    Row {
                        spacing: 2
                        Repeater {
                            model: [Alarm.Monday, Alarm.Tuesday, Alarm.Wednesday, Alarm.Thursday, Alarm.Friday, Alarm.Saturday, Alarm.Sunday]
                            delegate: Column {
                                width: Math.max(short_day_name.width, underline_rect.width)

                                Label {
                                    id: short_day_name

                                    opacity: daysOfWeek & modelData ? 1 : .4
                                    color: isDayMode ? text_color_day
                                                     : text_color
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: Qt.locale().standaloneDayName(index + 1, Locale.ShortFormat)
                                    textSize: Label.Small
                                }

                                Rectangle {
                                    id: underline_rect

                                    visible: daysOfWeek & modelData
                                    color: isDayMode ? text_color_day
                                                     : text_color
                                    width: units.gu(3)
                                    height: units.dp(2)
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }

                            }
                        }
                    }
                }

                Icon {
                    SlotsLayout.position: SlotsLayout.Leading
                    SlotsLayout.overrideVerticalPositioning : true
                    anchors.verticalCenter: parent.verticalCenter
                    color: isDayMode ? text_color_day
                                     : text_color
                    name: "alarm-clock"
                    height: units.gu(3)
                }
            }
        }
        // Workaround to make ListView "clickable"
        MouseArea {
            anchors.fill: parent
            onClicked: main_header.exposed = !main_header.exposed
        }
    }

}
