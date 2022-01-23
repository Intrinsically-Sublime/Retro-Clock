import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    id: root_time_format

    header: PageHeader {
        id: main_header

        title: i18n.tr("Time format")
        StyleHints {
            backgroundColor: isDayMode ? "#e8ae0e" : "#0a2449"
            foregroundColor: isDayMode ? "#0a2449" : "#e8ae0e"
        }
    }

    ListView {
        id: time_format_listview

        anchors {
            top: main_header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        clip: true

        model: ["hh:mm", "hh:mm ap", "h:mm", "h:mm ap"]

        delegate:
            ListItem {
            id: time_format_item

            height: main_layout.height + divider.height
            divider.anchors.leftMargin: units.gu(6)

            ListItemLayout {
                id: main_layout
                title.text: Qt.formatDateTime(test_time, modelData)

                Icon {
                    name: "tick"
                    color: main_layout.title.color
                    width: units.gu(2)
                    height: width
                    SlotsLayout.position: SlotsLayout.Leading
                    opacity: modelData == time_format ? 1 : 0
                }
            }

            onClicked: {
                time_format = modelData
                page_stack.pop()
            }
        }
    }
}
