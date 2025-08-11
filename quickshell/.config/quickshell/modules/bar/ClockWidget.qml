import qs.config
import qs.widgets
import qs.services
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    // property bool borderless: Config.options.bar.borderless
    property bool borderless: false
    // property bool showDate: Config.options.bar.verbose
    implicitWidth: rowLayout.implicitWidth
    // implicitHeight: 32

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: 4

        StyledText {
            font.pixelSize: Appearance.font.pixelSize.small
            color: "white"
            // text: Qt.formatDateTime(new Date(), "MMM  d  HH:mm")
            text: DateTime.format("MMM d HH:mm")
        }
    }
}
