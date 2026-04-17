pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Caelestia.Config
import qs.components
import qs.services
import qs.utils

RowLayout {
    id: root

    Layout.leftMargin: Tokens.padding.large
    Layout.rightMargin: Tokens.padding.large
    Layout.fillWidth: true
    spacing: Tokens.padding.normal

    SessionButton {
        id: logout

        icon: "logout"
        label: "Logout"
        command: Config.session.commands.logout
    }

    SessionButton {
        id: hibernate

        icon: "downloading"
        label: "Hibernate"
        command: Config.session.commands.hibernate
    }

    Item {
        width: (Config.session.sizes.button - Tokens.padding.normal * .5) * .5
    }

    AnimatedImage {
        width: Config.session.sizes.button
        height: Config.session.sizes.button
        sourceSize.width: width
        sourceSize.height: height

        playing: visible
        asynchronous: true
        speed: 0.7
        source: Paths.absolutePath(Config.paths.sessionGif)
    }

    Item {
        width: (Config.session.sizes.button - Tokens.padding.normal * .5) * .5
    }

    SessionButton {
        id: shutdown

        icon: "power_settings_new"
        label: "Shutdown"
        command: Config.session.commands.shutdown
    }

    SessionButton {
        id: reboot

        icon: "cached"
        label: "Reboot"
        command: Config.session.commands.reboot
    }

    component SessionButton: ColumnLayout {
        id: button

        required property string icon
        required property string label
        required property list<string> command

        Layout.fillWidth: true
        spacing: 8

        StyledRect {
            implicitWidth: Config.session.sizes.button
            implicitHeight: Config.session.sizes.button
            radius: Tokens.rounding.large
            color: button.activeFocus ? Colours.palette.m3secondaryContainer : Colours.tPalette.m3surfaceContainer

            StateLayer {
                function onClicked(): void {
                    Quickshell.execDetached(button.command);
                }

                radius: parent.radius
                color: button.activeFocus ? Colours.palette.m3onSecondaryContainer : Colours.palette.m3onSurface
            }

            MaterialIcon {
                anchors.centerIn: parent

                text: button.icon
                color: button.activeFocus ? Colours.palette.m3onSecondaryContainer : Colours.palette.m3onSurface
                font.pointSize: Tokens.font.size.extraLarge
                font.weight: 500
            }
        }

        StyledText {
            text: button.label
            Layout.alignment: Qt.AlignHCenter
            // color: tab.current ? Colours.palette.m3primary : Colours.palette.m3onSurfaceVariant
        }
    }
}
