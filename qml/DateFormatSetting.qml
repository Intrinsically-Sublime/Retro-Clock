import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    id: root_date_format

    header: PageHeader {
        id: main_header

        title: i18n.tr("Date format")
        StyleHints {
            backgroundColor: isDayMode ? "#e8ae0e" : "#0a2449"
            foregroundColor: isDayMode ? "#0a2449" : "#e8ae0e"
        }
    }

    ListView {
        id: date_format_listview

        anchors {
            top: main_header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        clip: true

        model: ["yyyy MMMM d", "d MMMM yyyy", "MMMM d yyyy", "yyyy M d", "d M yyyy", "M d yyyy", "yyyy MM dd", "dd MM yyyy", "MM dd yyyy"]

        delegate:
            ListItem {
            id: date_format_item

            height: main_layout.height + divider.height
            divider.anchors.leftMargin: units.gu(6)

            ListItemLayout {
                id: main_layout

                title.text: Qt.formatDateTime(test_date, modelData)

                Icon {
                    name: "tick"
                    color: main_layout.title.color
                    width: units.gu(2)
                    height: width
                    SlotsLayout.position: SlotsLayout.Leading
                    opacity: modelData == date_format ? 1 : 0
                }

            }

            onClicked: {
                date_format = modelData
                this_date = Qt.formatDateTime(new Date(), date_format)
                page_stack.pop()
            }
        }
    }
}
