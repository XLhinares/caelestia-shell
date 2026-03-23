pragma ComponentBehavior: Bound

import QtQuick
import qs.components
import qs.services
import qs.config

StyledRect {
    id: root

    readonly property color colour: Colours.palette.m3tertiary
    readonly property int padding: Config.bar.clock.background ? Appearance.padding.normal : Appearance.padding.small

    implicitWidth: Config.bar.sizes.innerWidth
    implicitHeight: layout.implicitHeight + root.padding * 2

    // edit: custom-clock
    StyledText {
        id: text_date
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: StyledText.AlignHCenter
        text: Time.format("MM\ndd")
        font.pointSize: Appearance.font.size.smaller
        font.family: Appearance.font.family.mono
        color: root.colour
    }

    StyledText {
        id: text_day
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: StyledText.AlignHCenter
        text: {
            var day = new Date().getDay();
            var days = ["日", "一", "二", "三", "四", "五", "六"];
            return days[day];
    color: Qt.alpha(Colours.tPalette.m3surfaceContainer, Config.bar.clock.background ? Colours.tPalette.m3surfaceContainer.a : 0)
    radius: Appearance.rounding.full

    // Column {
    //     id: layout

    //     anchors.centerIn: parent
    //     spacing: Appearance.spacing.small

    //     Loader {
    //         asynchronous: true
    //         anchors.horizontalCenter: parent.horizontalCenter

    //         active: Config.bar.clock.showIcon
    //         visible: active

    //         sourceComponent: MaterialIcon {
    //             text: "calendar_month"
    //             color: root.colour
    //         }
    //     }

    //     StyledText {
    //         anchors.horizontalCenter: parent.horizontalCenter

    //         visible: Config.bar.clock.showDate

    //         horizontalAlignment: StyledText.AlignHCenter
    //         text: Time.format("ddd\nd")
    //         font.pointSize: Appearance.font.size.smaller
    //         font.family: Appearance.font.family.sans
    //         color: root.colour
    //     }

    //     Rectangle {
    //         anchors.horizontalCenter: parent.horizontalCenter
    //         visible: Config.bar.clock.showDate
    //         height: visible ? 1 : 0

    //         width: parent.width * 0.8
    //         color: root.colour
    //         opacity: 0.2
    //     }

    //     StyledText {
    //         anchors.horizontalCenter: parent.horizontalCenter

    //         horizontalAlignment: StyledText.AlignHCenter
    //         text: Time.format(Config.services.useTwelveHourClock ? "hh\nmm\nA" : "hh\nmm")
    //         font.pointSize: Appearance.font.size.smaller
    //         font.family: Appearance.font.family.mono
    //         color: root.colour
    //     }
    //     font.pointSize: Appearance.font.size.smaller
    //     font.family: Appearance.font.family.mono
    //     color: root.colour
    // }
}
