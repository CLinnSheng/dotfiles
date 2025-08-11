import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.widgets

Scope {
    id: root

    property real brightness: 0.5 // Current brightness (0-1)
    property real previousBrightness: 0.5 // Track previous brightness to detect changes
    property bool shouldShowOsd: false
    property bool initialized: false // Track if we've done the initial read

    // Process to get current brightness
    Process {
        id: brightnessReader
        command: ["sh", "-c", "echo \"$(brightnessctl g) $(brightnessctl m)\""]
        stdout: StdioCollector {
            onStreamFinished: {
                const values = text.trim().split(" ");
                if (values.length >= 2) {
                    const current = parseInt(values[0]);
                    const max = parseInt(values[1]);
                    const newBrightness = current / max;

                    if (root.initialized && Math.abs(root.brightness - newBrightness) > 0.001) {
                        // Only show OSD if brightness actually changed and we're initialized
                        root.brightness = newBrightness;
                    } else if (!root.initialized) {
                        // First time initialization - don't show OSD
                        root.brightness = newBrightness;
                        root.previousBrightness = newBrightness;
                        root.initialized = true;
                    }
                }
            }
        }
    }

    // Initialize brightness value
    Component.onCompleted: {
        brightnessReader.running = true;
    }

    // Timer to poll for brightness changes
    Timer {
        id: brightnessMonitor
        interval: 200 // Check every 200ms
        running: true
        repeat: true
        onTriggered: {
            brightnessReader.running = true;
        }
    }

    // Track brightness changes and show OSD (only after initialization)
    onBrightnessChanged: {
        if (root.initialized && Math.abs(root.brightness - root.previousBrightness) > 0.001) {
            root.shouldShowOsd = true;
            hideTimer.restart();
            root.previousBrightness = root.brightness;
        }
    }

    Timer {
        id: hideTimer
        interval: 1500
        onTriggered: root.shouldShowOsd = false
    }

    // Function to determine the appropriate icon based on brightness
    function getBrightnessIcon() {
        if (root.brightness === 0)
            return "brightness_1";
        if (root.brightness < 0.3)
            return "brightness_2";
        if (root.brightness < 0.7)
            return "brightness_5";
        return "brightness_7";
    }

    LazyLoader {
        active: root.shouldShowOsd

        PanelWindow {
            anchors.bottom: true
            margins.bottom: screen.height / 35
            exclusiveZone: 0
            implicitWidth: 400
            implicitHeight: 50
            color: "transparent"
            mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: "#80000000"

                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: 10
                        rightMargin: 15
                    }

                    MaterialSymbol {
                        text: root.getBrightnessIcon()
                        iconSize: 25
                        color: "#ffffff"
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 10
                        radius: 20
                        color: "#50ffffff"

                        Rectangle {
                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom
                            }
                            implicitWidth: parent.width * root.brightness
                            radius: parent.radius
                            color: "#ffffff"
                        }
                    }

                    Text {
                        text: Math.round(root.brightness * 100) + "%"
                        color: "#ffffff"
                        font.pixelSize: 14
                        Layout.preferredWidth: 40
                    }
                }
            }
        }
    }
}
