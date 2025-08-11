import qs.services
import qs.config
import qs.widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.UPower

// import "popouts" as BarPopouts

Scope {
    id: bar

    // required property BarPopouts.Wrapper popouts

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barRoot
            property real useShortenedForm: (Appearance.sizes.barHellaShortenScreenWidthThreshold >= screen?.width) ? 2 : (Appearance.sizes.barShortenScreenWidthThreshold >= screen?.width) ? 1 : 0

            required property var modelData
            screen: modelData
            color: "transparent"
            // color: "red"

            anchors {
                top: true
                left: true
                right: true
            }

            WlrLayershell.namespace: "quickshell:bar"
            implicitHeight: 35
            // implicitHeight: Appearance.sizes.baseBarHeight

            // exclusiveZone: 30
            Item {
                id: barContent

                anchors {
                    right: parent.right
                    left: parent.left
                    top: parent.top
                    bottom: undefined
                }
                // implicitHeight: 30
                // implicitHeight: Appearance.sizes.baseBarHeight
                anchors.fill: parent

                RowLayout {
                    id: leftSection
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: Appearance.rounding.screenRounding
                    spacing: 10

                    CustomIcon {
                        id: distroIcon
                        // anchors.centerIn: parent
                        // anchors.verticalCenter: parent.verticalCenter
                        Layout.alignment: Qt.AlignVCenter
                        width: 20
                        height: 20
                        source: SystemInfo.distroIcon

                        ColorOverlay {
                            anchors.fill: distroIcon
                            source: distroIcon
                            color: "white"
                        }
                    }

                    SysTray {
                        visible: barRoot.useShortenedForm === 0
                        Layout.fillWidth: false
                        Layout.fillHeight: true
                    }
                }

                RowLayout {
                    id: middleSection
                    anchors.centerIn: parent

                    Workspaces {
                        id: workspacesWidget
                        Layout.fillHeight: true
                    }
                }

                RowLayout {
                    id: rightSection
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: Appearance.rounding.screenRounding
                    spacing: 7

                    Media {
                        visible: barRoot.useShortenedForm < 2
                        Layout.fillWidth: true
                    }

                    BatteryIndicator {
                        visible: (barRoot.useShortenedForm < 2 && UPower.displayDevice.isLaptopBattery)
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Resources {
                        alwaysShowAllResources: barRoot.useShortenedForm === 2
                        Layout.fillWidth: barRoot.useShortenedForm === 2
                    }

                    Item {
                        Layout.preferredWidth: networkIcon.width
                        Layout.preferredHeight: networkIcon.height

                        MaterialSymbol {
                            id: networkIcon
                            text: Network.materialSymbol
                            iconSize: Appearance.font.pixelSize.larger
                            color: networkMouseArea.containsMouse ? "#cccccc" : "white"
                        }

                        MouseArea {
                            id: networkMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                // Run your network script here
                                console.log("Network icon clicked!");

                                // Example: Run a script using Process
                                var process = Qt.createQmlObject('
                                    import QtQuick
                                    import Quickshell.Io
                                    Process {
                                        running: true
                                        command: ["bash", "-c", "wifimenu"]
                                        onExited: console.log("Network script finished")
                                    }
                                ', parent);
                            }
                        }
                    }

                    Item {
                        Layout.preferredWidth: bluetoothIcon.width
                        Layout.preferredHeight: bluetoothIcon.height

                        MaterialSymbol {
                            id: bluetoothIcon
                            text: Bluetooth.bluetoothConnected ? "bluetooth_connected" : Bluetooth.bluetoothEnabled ? "bluetooth" : "bluetooth_disabled"
                            iconSize: Appearance.font.pixelSize.larger
                            color: bluetoothMouseArea.containsMouse ? "#cccccc" : "white"
                        }

                        MouseArea {
                            id: bluetoothMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                // Run your bluetooth script here
                                console.log("Bluetooth icon clicked!");

                                // Example: Run a script using Process
                                var process = Qt.createQmlObject('
                                    import QtQuick
                                    import Quickshell.Io
                                    Process {
                                        running: true
                                        command: ["bash", "-c", "bluetoothmenu"]
                                        onExited: console.log("Bluetooth script finished")
                                    }
                                ', parent);

                                // Alternative: Toggle bluetooth state directly if available
                                // Bluetooth.toggle() // if this method exists in your Bluetooth service
                            }
                        }
                    }

                    ClockWidget {
                        // showDate: (Config.options.bar.verbose && barRoot.useShortenedForm < 2)
                        // showDate: true
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
