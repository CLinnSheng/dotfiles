import qs.config
import qs.widgets
import qs.services
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    property bool borderless: Config.bar.borderless
    readonly property var chargeState: Battery.chargeState
    readonly property bool isCharging: Battery.isCharging
    readonly property bool isPluggedIn: Battery.isPluggedIn
    readonly property bool isFullyCharged: Battery.isFullyCharged
    readonly property real percentage: Battery.percentage
    readonly property bool isLow: percentage <= Config.battery.low / 100
    readonly property color batteryLowBackground: Appearance.m3colors.darkmode ? Appearance.m3colors.m3error : Appearance.m3colors.m3errorContainer
    readonly property color batteryLowOnBackground: Appearance.m3colors.darkmode ? Appearance.m3colors.m3errorContainer : Appearance.m3colors.m3error

    implicitWidth: rowLayout.implicitWidth - rowLayout.spacing * 3
    implicitHeight: 30
    // Dynamic properties based on charging status
    readonly property string batteryIcon: {
        if (isFullyCharged) {
            return "battery_charging_full";
        } else if (isPluggedIn || isCharging) {
            return "power";
        } else if (isLow) {
            return "battery_alert";
        } else {
            // Return different battery icons based on percentage
            if (percentage > 0.9)
                return "battery_full";
            else if (percentage > 0.6)
                return "battery_6_bar";
            else if (percentage > 0.5)
                return "battery_5_bar";
            else if (percentage > 0.3)
                return "battery_3_bar";
            else if (percentage > 0.2)
                return "battery_2_bar";
            else
                return "battery_1_bar";
        }
    }

    readonly property color progressColor: {
        if (isFullyCharged || isPluggedIn || isCharging) {
            return "light green";
        } else if (isLow) {
            return "red";
        } else {
            return "dark orange";
        }
    }

    RowLayout {
        id: rowLayout

        spacing: 4
        anchors.centerIn: parent

        CircularProgress {
            id: progressRing

            enableAnimation: isCharging
            Layout.alignment: Qt.AlignVCenter
            lineWidth: 2
            value: percentage
            implicitSize: 28
            // colSecondary: (isLow && !isCharging) ? batteryLowBackground : Appearance.colors.colSecondaryContainer
            // colPrimary: (isLow && !isCharging) ? batteryLowOnBackground : Appearance.m3colors.m3onSecondaryContainer
            colSecondary: "transparent"
            // colPrimary: (isLow && !isCharging) ? batteryLowOnBackground : (isCharging || isPluggedIn) ? "light green" : "dark orange"

            colPrimary: progressColor
            fill: (isLow && !isCharging)

            Connections {
                target: root
                function onIsChargingChanged() {
                    progressRing.colPrimary = progressColor;
                }
                function onIsPluggedInChanged() {
                    progressRing.colPrimary = progressColor;
                }
                function onIsLowChanged() {
                    progressRing.colPrimary = progressColor;
                    // progressRing.colSecondary = (isLow && !isCharging) ? batteryLowBackground : "Transparent";
                    progressRing.fill = (isLow && !isCharging);
                }
            }

            MaterialSymbol {
                id: batterySymbol

                anchors.centerIn: parent
                fill: 1
                // text: "battery_charging_full"
                text: batteryIcon
                iconSize: Appearance.font.pixelSize.large
                // color: (isLow && !isCharging) ? batteryLowOnBackground : Appearance.m3colors.m3onSecondaryContainer
                // color: (isLow && !isCharging) ? batteryLowOnBackground : (isCharging || isPluggedIn) ? "light green" : "dark orange"
                color: progressColor

                Connections {
                    target: root
                    function onIsChargingChanged() {
                        batterySymbol.color = progressColor;
                    }
                    function onIsPluggedInChanged() {
                        batterySymbol.color = progressColor;
                    }
                    function onIsLowChanged() {
                        batterySymbol.color = progressColor;
                    }
                }
            }
        }

        StyledText {
            Layout.alignment: Qt.AlignVCenter
            // color: Appearance.colors.colOnLayer1
            color: "white"
            text: `${Math.round(percentage * 100)}%`
        }
    }

    // Loader {
    //     active: true
    //
    //     Connections {
    //         target: root
    //         function onIsChargingChanged() {
    //             if (isCharging)
    //                 boltIconLoader.active = true;
    //         }
    //     }
    // }

    // sourceComponent: MaterialSymbol {
    //     id: boltIcon
    //
    //     text: "bolt"
    //     iconSize: Appearance.font.pixelSize.large
    //     color: Appearance.m3colors.m3onSecondaryContainer
    //     visible: opacity > 0 // Only show when charging
    //     opacity: isCharging ? 1 : 0 // Keep opacity for visibility
    //     onVisibleChanged: {
    //         if (!visible)
    //             boltIconLoader.active = false;
    //     }
    //
    //     Behavior on opacity {
    //         animation: Appearance.animation.elementMove.numberAnimation.createObject(this)
    //     }
    // }
    // }
}
