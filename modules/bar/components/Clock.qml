pragma ComponentBehavior: Bound

import QtQuick
import Caelestia.Config
import qs.components
import qs.services

StyledRect {
    id: root

    readonly property color colour: Colours.palette.m3tertiary
    readonly property int padding: Config.bar.clock.background ? Tokens.padding.normal : Tokens.padding.small

    implicitWidth: Tokens.sizes.bar.innerWidth
    implicitHeight: layout.implicitHeight + root.padding * 2

    color: Qt.alpha(Colours.tPalette.m3surfaceContainer, Config.bar.clock.background ? Colours.tPalette.m3surfaceContainer.a : 0)
    radius: Tokens.rounding.full

    Column {
        id: layout

        anchors.centerIn: parent
        spacing: Tokens.spacing.small

        // edit: custom-clock
        StyledText {
            id: text_date

            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: StyledText.AlignHCenter
            text: Time.format("MM\ndd")
            font.pointSize: Tokens.font.size.smaller
            font.family: Tokens.font.family.mono
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
            }
        }

        StyledText {
            anchors.horizontalCenter: parent.horizontalCenter

            visible: Config.bar.clock.showDate

            horizontalAlignment: StyledText.AlignHCenter
            text: Time.format("ddd\nd")
            font.pointSize: Tokens.font.size.smaller
            font.family: Tokens.font.family.sans
            color: root.colour
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            visible: Config.bar.clock.showDate
            height: visible ? 1 : 0

            width: parent.width * 0.8
            color: root.colour
            opacity: 0.2
        }

        StyledText {
            anchors.horizontalCenter: parent.horizontalCenter

            horizontalAlignment: StyledText.AlignHCenter
            text: Time.format(GlobalConfig.services.useTwelveHourClock ? "hh\nmm\nA" : "hh\nmm")
            font.pointSize: Tokens.font.size.smaller
            font.family: Tokens.font.family.mono
            color: root.colour
        }
    }
}
