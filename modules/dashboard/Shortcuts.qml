import QtQuick
import QtQuick.Layouts
import Caelestia.Config
import qs.components
import qs.services
import "shortcuts"

ColumnLayout {
    id: root

    Layout.leftMargin: Tokens.padding.large
    Layout.rightMargin: Tokens.padding.large
    Layout.fillWidth: true
    spacing: Tokens.padding.large

    ShortcutsSection {}

    StyledRect {
        Layout.fillWidth: true
        Layout.topMargin: Tokens.spacing.medium
        Layout.bottomMargin: Tokens.spacing.medium
        implicitHeight: 1
        color: Colours.tPalette.m3outlineVariant
    }

    PowerSection {}
}
