pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Caelestia.Config
import qs.components
import qs.services

StyledRect {
    id: root

    readonly property color colour: Colours.palette.m3tertiary
    readonly property int padding: Config.bar.clock.background ? Tokens.padding.medium : Tokens.padding.extraSmall
    readonly property var font: Tokens.font.body.builders.small.scale(1.1)

    implicitWidth: Tokens.sizes.bar.innerWidth
    implicitHeight: layout.implicitHeight + root.padding * 2

    color: Qt.alpha(Colours.tPalette.m3surfaceContainer, Config.bar.clock.background ? Colours.tPalette.m3surfaceContainer.a : 0)
    radius: Tokens.rounding.full

    ColumnLayout {
        id: layout

        anchors.centerIn: parent
        spacing: Tokens.spacing.extraSmall

        // edit: custom-clock
        StyledText {
            id: text_date
            Layout.alignment: Qt.AlignHCenter
            visible: Config.bar.clock.showDate

            text: Time.format("MM\ndd")
            font: root.font.width(100).letterSpacing(scale).family("mono").build()
            color: root.colour
        }

        StyledText {
            id: text_day
            Layout.alignment: Qt.AlignHCenter

            text: {
                var day = new Date().getDay();
                var days = ["日", "一", "二", "三", "四", "五", "六"];
                return days[day];
            }
            font: root.font.width(100).letterSpacing(scale).family("mono").build()
        }

        StyledText {
            Layout.alignment: Qt.AlignHCenter
            text: Time.hourStr + "\n" + Time.minuteStr
            font: root.font.width(100).letterSpacing(scale).family("mono").build()
            color: root.colour

            TextMetrics {
                id: hourMetrics

                font: root.font.build()
                text: Time.hourStr
            }
            TextMetrics {
                id: minMetrics

                font: root.font.build()
                text: Time.minuteStr
            }
        }

        Loader {
            Layout.topMargin: -parent.spacing - 4
            Layout.alignment: Qt.AlignHCenter
            asynchronous: true
            active: GlobalConfig.services.useTwelveHourClock
            visible: active

            sourceComponent: StyledText {
                text: Time.amPmStr.toLowerCase()
                font: Tokens.font.body.builders.small.scale(0.9).build()
                color: root.colour
            }
        }
    }
}
