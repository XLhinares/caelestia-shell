import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services
import qs.config
import "shortcuts"

ColumnLayout {
    id: root

    Layout.leftMargin: Appearance.padding.large
    Layout.rightMargin: Appearance.padding.large
    Layout.fillWidth: true
    spacing: Appearance.padding.large

    ShortcutsSection {}

    StyledRect {
        Layout.fillWidth: true
        Layout.topMargin: Appearance.spacing.normal
        Layout.bottomMargin: Appearance.spacing.normal
        implicitHeight: 1
        color: Colours.tPalette.m3outlineVariant
    }

    PowerSection {}
}
