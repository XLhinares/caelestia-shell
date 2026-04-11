import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.components
import qs.services
import qs.config

ColumnLayout {
    id: button

    required property string icon
    required property string label
    required property var command
    required property var commandEnable
    required property var commandDisable
    required property var showCommandOutputNotif
    required property var isEnabled
    property bool enabledBool: false

    property Process enabledCheckerProcess: Process {
        id: enabledChecker

        command: {
            const cmd = button.isEnabled;
            if (cmd === undefined)
                return ["echo", "false"];
            if (typeof cmd === 'boolean')
                return ["echo", cmd];
            if (typeof cmd === 'string')
                return cmd.split(/\s+/);
            return cmd;
        }
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                // print(">>> [" + button.label + "] isEnabled: " + enabledChecker.isEnabled)
                // print(">>> [" + button.label + "] Output:    " + data)
                button.enabledBool = data == "true";
            }
        }
        Component.onCompleted: running = true
    }

    property Process commandRunnerProcess: Process {
        id: commandRunner

        command: {
            var cmd = "";
            if (button.enabledBool && button.commandDisable !== undefined) {
                cmd = button.commandDisable;
            } else if (!button.enabledBool && button.commandEnable !== undefined) {
                cmd = button.commandEnable;
            } else if (button.command !== undefined) {
                cmd = button.command;
            } else {
                return ""; // Abort if no command is given.
            }
            // print(">>> [" + button.label + "] cmd: " + cmd);
            return typeof cmd === 'string' ? cmd.split(/\s+/) : cmd;
        }
        stderr: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                if (button.showCommandOutputNotif == undefined)
                    return;
                if (!button.showCommandOutputNotif)
                    return;
                // print(">>> [" + button.label + "] isEnabled: " + enabledChecker.isEnabled)
                print(">>> [" + button.label + "] Output:    " + data);
                Quickshell.execDetached(["notify-send", "[" + button.label + "]", data,]);
            }
        }
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                if (button.showCommandOutputNotif == undefined)
                    return;
                if (!button.showCommandOutputNotif)
                    return;
                // print(">>> [" + button.label + "] isEnabled: " + enabledChecker.isEnabled)
                print(">>> [" + button.label + "] Output:    " + data);
                Quickshell.execDetached(["notify-send", "[" + button.label + "]", data,]);
            }
        }
        onExited: code => button.rerunEnabledCheck()
    }

    function rerunEnabledCheck() {
        if (enabledChecker.running) {
            enabledChecker.kill();
            enabledChecker.stdout.clear(); // Clear any buffered data
        }
        enabledChecker.running = true;
    }

    function runCommand(): void {
        if (commandRunner.running) {
            commandRunner.kill();
            commandRunner.stdout.clear(); // Clear any buffered data
        }
        commandRunner.running = true;
    }

    width: Config.session.sizes.button
    implicitWidth: width
    spacing: Appearance.spacing.normal

    StyledRect {
        implicitWidth: Config.session.sizes.button
        implicitHeight: Config.session.sizes.button
        radius: Appearance.rounding.large
        color: {
            // print(button.label + " is enabled: " + button.enabledBool);
            return button.enabledBool ? Colours.palette.m3secondaryContainer : Colours.tPalette.m3surfaceContainer;
        }

        StateLayer {
            radius: parent.radius
            color: button.activeFocus ? Colours.palette.m3onSecondaryContainer : Colours.palette.m3onSurface
            onClicked: {
                button.runCommand();
            }
        }

        MaterialIcon {
            anchors.centerIn: parent

            text: button.icon
            color: button.activeFocus ? Colours.palette.m3onSecondaryContainer : Colours.palette.m3onSurface
            font.pointSize: Appearance.font.size.extraLarge
            font.weight: 500
        }
    }
    StyledText {
        text: button.label
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: parent.width // Prevents layout from growing
        width: parent.width
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        maximumLineCount: 3
        // color: tab.current ? Colours.palette.m3primary : Colours.palette.m3onSurfaceVariant
    }
}
