import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import qs.widgets

Scope {
    id: root
    property bool initialized: false

    // Bind the pipewire node so its volume will be tracked
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio
        function onVolumeChanged() {
            if (root.initialized) {
                root.shouldShowOsd = true;
                hideTimer.restart();
            }
        }

        // Add handler for mute state changes
        function onMutedChanged() {
            if (root.initialized) {
                root.shouldShowOsd = true;
                hideTimer.restart();
            }
        }
    }

    property bool shouldShowOsd: false

    Timer {
        id: hideTimer
        interval: 800
        onTriggered: root.shouldShowOsd = false
    }

    Timer {
        id: initTimer
        interval: 100
        onTriggered: root.initialized = true
    }

    Component.onCompleted: {
        initTimer.start();
    }

    // Function to determine the appropriate icon based on volume
    function getVolumeIcon() {
        if (!Pipewire.defaultAudioSink?.audio)
            return "volume_off";

        if (Pipewire.defaultAudioSink.audio.muted)
            return "volume_off";

        let volume = Pipewire.defaultAudioSink.audio.volume;
        if (volume === 0)
            return "volume_off";
        if (volume < 0.5)
            return "volume_down";
        return "volume_up";
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
                        text: root.getVolumeIcon() // Dynamically set the icon
                        iconSize: 25
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
                            implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                            radius: parent.radius
                        }
                    }
                }
            }
        }
    }
}
