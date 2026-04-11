import QtQuick
import QtQuick.Layouts
import qs.config

GridLayout {
    id: root

    columns: 6
    columnSpacing: Appearance.spacing.normal
    rowSpacing: Appearance.spacing.normal
    Layout.leftMargin: Appearance.padding.large
    Layout.rightMargin: Appearance.padding.large
    Layout.topMargin: Appearance.padding.large
    Layout.fillWidth: true

    Repeater {
        model: Config.dashboard.shortcuts

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
            Layout.preferredWidth: Config.session.sizes.button
            Layout.fillWidth: false
            Layout.alignment: Qt.AlignTop
        }
    }
}
