import qs.widgets
import qs.services
import qs.config
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    // property bool borderless: Config.options.bar.borderless
    property bool borderless: false
    property bool alwaysShowAllResources: true
    implicitWidth: rowLayout.implicitWidth + rowLayout.anchors.leftMargin + rowLayout.anchors.rightMargin
    implicitHeight: 30

    RowLayout {
        id: rowLayout

        spacing: 0
        anchors.fill: parent
        // anchors.leftMargin: 4
        // anchors.rightMargin: 4
        // Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        Resource {
            iconName: "memory"
            percentage: ResourceUsage.memoryUsedPercentage
            Layout.rightMargin: 4
        }

        // Resource {
        //     iconName: "swap_horiz"
        //     percentage: ResourceUsage.swapUsedPercentage
        //     shown: (Config.options.bar.resources.alwaysShowSwap && percentage > 0) || (MprisController.activePlayer?.trackTitle == null) || root.alwaysShowAllResources
        //     Layout.leftMargin: shown ? 4 : 0
        // }

        Resource {
            // iconName: "settings_slow_motion"
            iconName: "neurology"
            percentage: ResourceUsage.cpuUsage
            shown: Config.bar.resources.alwaysShowCpu || !(MprisController.activePlayer?.trackTitle?.length > 0) || root.alwaysShowAllResources
            // Layout.leftMargin: shown ? 4 : 0
            Layout.rightMargin: 4
        }
    }
}
