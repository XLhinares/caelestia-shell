import QtQuick
import QtQuick.Layouts
import Caelestia.Config
import qs.components
import qs.services

ListView {
    id: hourlyForecastList

    property var visibleItemsCount: 3

    spacing: Tokens.spacing.small
    width: contentItem.childrenRect.width
    height: (contentItem.children[0]?.height ?? 60) * visibleItemsCount + spacing * (visibleItemsCount - 1)
    clip: true

    model: Weather.hourlyForecast
    delegate: HourlyForecastItem {}

    component HourlyForecastItem: StyledRect {
        id: hourlyForecastItem

        required property var modelData

        property var timestamp: modelData?.timestamp
        property var hour: modelData?.hour ?? 0
        property var icon: modelData?.icon ?? "cloud_alert"
        property var tempC: modelData?.tempC ?? 0
        property var precipChance: modelData?.precipChance ?? "?"

        implicitHeight: hourlyForecastItemRow.implicitHeight + Tokens.padding.medium * 2
        implicitWidth: hourlyForecastItemRow.implicitWidth + Tokens.padding.medium * 2
        radius: Tokens.rounding.medium
        color: Colours.tPalette.m3surfaceContainer

        RowLayout {
            id: hourlyForecastItemRow

            anchors.centerIn: parent
            spacing: Tokens.spacing.small

            Column {
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: Tokens.font.body.medium.pointSize * 4

                StyledText {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: hourlyForecastItem.hour > 12 ? `${(hourlyForecastItem.hour - 12).toString().padStart(2, "0")}PM` : `${hourlyForecastItem.hour.toString().padStart(2, "0")}AM`
                    font: Tokens.font.body.builders.medium.weight(600).build()
                    color: Colours.palette.m3primary
                }

                StyledText {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: new Date(hourlyForecastItem.timestamp).toLocaleDateString(Qt.locale(), "(ddd)")
                    font: Tokens.font.body.small
                    opacity: 0.7
                    color: Colours.palette.m3onSurfaceVariant
                }
            }

            MaterialIcon {
                Layout.alignment: Qt.AlignVCenter
                text: hourlyForecastItem.icon
                font: Tokens.font.icon.extraLarge
                color: Colours.palette.m3secondary
            }

            Column {
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: Tokens.font.body.small.pointSize * 3.75

                StyledText {
                    anchors.right: parent.right
                    text: Weather.formatTemp(hourlyForecastItem.tempC, true);
                    font: Tokens.font.body.builders.small.weight(600).build()
                    color: Colours.palette.m3tertiary
                }

                StyledText {
                    anchors.right: parent.right
                    Layout.alignment: Qt.AlignHCenter
                    text: `${hourlyForecastItem.precipChance}%`
                    font: Tokens.font.body.builders.small.weight(600).build()
                    color: Colours.palette.m3tertiary
                }
            }
        }
    }
}
