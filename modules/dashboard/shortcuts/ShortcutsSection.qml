import QtQuick
import QtQuick.Layouts
import Caelestia.Config

GridLayout {
    id: root

    columns: 6
    columnSpacing: Tokens.spacing.normal
    rowSpacing: Tokens.spacing.normal
    Layout.leftMargin: Tokens.padding.large
    Layout.rightMargin: Tokens.padding.large
    Layout.topMargin: Tokens.padding.large
    Layout.fillWidth: true

    Repeater {
        model: GlobalConfig.dashboard.shortcuts

        delegate: ShortcutItem {
            required property var modelData

            label: modelData.name
            icon: modelData.icon
            command: modelData.command
            commandEnable: modelData.commandEnable
            commandDisable: modelData.commandDisable
            showCommandOutputNotif: modelData.showCommandOutputNotif
            isEnabled: modelData.isEnabled
            // Constrain the button’s width to prevent cell growth
            Layout.preferredWidth: Tokens.sizes.session.button
            Layout.fillWidth: false
            Layout.alignment: Qt.AlignTop
        }
    }
}
