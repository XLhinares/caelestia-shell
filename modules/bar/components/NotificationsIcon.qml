import QtQuick
import qs.components
import qs.services
import qs.config

Item {
    id: root

    implicitWidth: Appearance.font.size.large * 1.2
    implicitHeight: Appearance.font.size.large * 1.2

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            const visibilities = Visibilities.getForActive();
            visibilities.sidebar = !visibilities.sidebar;
        }
    }

    MaterialIcon {
        text: "notifications_active"
        anchors.centerIn: parent
        width: Appearance.font.size.large * 1.2
        font.weight: Font.Bold
        color: Colours.palette.m3onSurface
    }
}
