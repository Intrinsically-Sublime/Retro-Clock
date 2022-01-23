import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    id: root_about

    header: PageHeader {
        id: main_header

        title: i18n.tr("Information")
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
            model: [i18n.tr("Summary"), i18n.tr("Credits"), i18n.tr("Support")]
        }
    }

    Flickable {
        id: page_flickable

        anchors {
            top: main_header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        contentHeight:  main_column.height + units.gu(2)
        clip: true

        Column {
            id: main_column

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }
            Item {
                id: icon

                visible: header_sections.selectedIndex === 0
                width: parent.width
                height: app_icon.height + units.gu(1)

                UbuntuShape {
                    id: app_icon

                    width: Math.min(root_about.width/3, 256)
                    height: width
                    anchors.centerIn: parent

                    source: Image {
                        id: icon_image
                        source: "../img/RetroClock.png"
                    }
                    radius: "medium"
                    aspect: UbuntuShape.DropShadow
                }
            }

            Label {
                id: name

                visible: header_sections.selectedIndex === 0
                text: i18n.tr("Retro Clock")
                anchors.horizontalCenter: parent.horizontalCenter
                textSize: Label.Large
                horizontalAlignment:  Text.AlignHCenter
            }

            Label {
                id: description_text

                visible: header_sections.selectedIndex === 0
                width: parent.width
                text: i18n.tr("Take a trip back in time")
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.WordWrap
                horizontalAlignment:  Text.AlignHCenter
            }

            ListItem {
                visible: header_sections.selectedIndex === 0
                ListItemLayout {
                    title.text: i18n.tr("Website")

                    ProgressionSlot {}
                }
                onClicked: {Qt.openUrlExternally('https://github.com/Intrinsically-Sublime/Retro-Clock')}
            }

            ListItem {
                visible: header_sections.selectedIndex === 0
                ListItemLayout {
                    title.text: i18n.tr("Artwork License")

                    Label { text: "Creative Commons BY-NC-SA 4.0" }

                    ProgressionSlot {}
                }
                onClicked: {Qt.openUrlExternally('https://creativecommons.org/licenses/by-nc-sa/4.0/')}
            }

            ListItem {
                visible: header_sections.selectedIndex === 0
                ListItemLayout {
                    title.text: i18n.tr("Software License")

                    Label { text: "Simplified BSD License" }

                    ProgressionSlot {}
                }
                onClicked: {Qt.openUrlExternally('http://opensource.org/licenses/bsd-license.php')}
            }

            ListItem {
                visible: header_sections.selectedIndex === 1
                ListItemLayout {
                    title.text: i18n.tr("Retro-Clock Author & Artist")

                    Label { text: "Intrinsically-Sublime" }

                    ProgressionSlot {}
                }
                onClicked: {Qt.openUrlExternally('https://github.com/Intrinsically-Sublime')}
            }

            ListItem {
                visible: header_sections.selectedIndex === 1
                ListItemLayout {
                    title.text: i18n.tr("Derived from Night-Clock by Michał Prędotka")

                    ProgressionSlot {}
                }
                onClicked: {Qt.openUrlExternally('https://open-store.io/app/nightclock.mivoligo')}
            }

            Label {
                visible: header_sections.selectedIndex === 1
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - units.gu(4)
                text: i18n.tr("Thank you to all translators.")
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                textSize: Label.Large
            }

            ListItem {
                visible: header_sections.selectedIndex === 2
                ListItemLayout {
                    title.text: i18n.tr("Report bugs")

                    ProgressionSlot {}
                }
                onClicked: Qt.openUrlExternally('https://github.com/Intrinsically-Sublime/Retro-Clock/issues')
            }

            ListItem {
                visible: header_sections.selectedIndex === 2
                ListItemLayout {
                    title.text: i18n.tr("Help with translation")

                    ProgressionSlot {}
                }
                onClicked: Qt.openUrlExternally('https://github.com/Intrinsically-Sublime/Retro-Clock/blob/main/po/retro-clock.intrinsically-sublime.pot')
            }

//            ListItem {
//                visible: header_sections.selectedIndex === 2
//                ListItemLayout {
//                    title.text: i18n.tr("My other apps")

//                    ProgressionSlot {}
//                }
//                onClicked: Qt.openUrlExternally('')
//            }

//            ListItem {
//                visible: header_sections.selectedIndex === 0 || header_sections.selectedIndex === 2
//                ListItemLayout {
//                    title.text: i18n.tr("Donate")

//                    ProgressionSlot {
//                        name: "like"
//                        color: UbuntuColors.red
//                        height: units.gu(3)
//                        width: height
//                    }
//                }
//                onClicked: Qt.openUrlExternally('')
//            }
        }
    }
}
