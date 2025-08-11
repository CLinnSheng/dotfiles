import qs.config
import qs.widgets
import qs.services
import qs.config.utils

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Hyprland

Item {
    id: root
    property bool borderless: Config.bar.borderless
    readonly property MprisPlayer activePlayer: MprisController.activePlayer
    readonly property string cleanedTitle: StringUtils.cleanMusicTitle(activePlayer?.trackTitle) || ""

    Layout.fillHeight: true
    implicitWidth: rowLayout.implicitWidth + rowLayout.spacing * 2
    // implicitWidth: rowLayout.implicitWidth
    implicitHeight: Appearance.sizes.baseBarHeight

    Timer {
        running: activePlayer?.playbackState == MprisPlaybackState.Playing
        interval: 1000
        repeat: true
        onTriggered: activePlayer.positionChanged()
    }

    // Timer for hover exit delay (keeps it open briefly after mouse leaves)
    Timer {
        id: hoverExitTimer
        interval: 500 // 500ms delay before hiding
        repeat: false
        onTriggered: {
            GlobalStates.mediaControlsOpen = false;
            // console.log("Media controls closed via hover exit");
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.MiddleButton | Qt.BackButton | Qt.ForwardButton | Qt.RightButton | Qt.LeftButton

        hoverEnabled: true

        onEntered: {
            GlobalStates.mediaControlsOpen = true;
            hoverExitTimer.stop();
        }

        onExited: {
            GlobalStates.mediaControlsOpen = false;
            hoverExitTimer.start();
        }

        onPressed: event => {
            // if (event.button === Qt.MiddleButton) {
            //     activePlayer.togglePlaying();
            // } else if (event.button === Qt.BackButton) {
            //     activePlayer.previous();
            // } else if (event.button === Qt.ForwardButton || event.button === Qt.RightButton) {
            //     activePlayer.next();
            // } else if (event.button === Qt.LeftButton) {
            //     GlobalStates.mediaControlsOpen = !GlobalStates.mediaControlsOpen;
            //     console.log(GlobalStates.mediaControlsOpen);
            // }
            if (event.button === Qt.LeftButton) {
                activePlayer.togglePlaying();
            }
        }
    }

    RowLayout { // Real content
        id: rowLayout

        spacing: 4
        anchors.fill: parent
        // anchors.centerIn: parent

        CircularProgress {
            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: rowLayout.spacing
            lineWidth: 2
            value: activePlayer?.position / activePlayer?.length
            implicitSize: 26
            // colSecondary: Appearance.colors.colSecondaryContainer
            // colPrimary: Appearance.m3colors.m3onSecondaryContainer
            colSecondary: "transparent"
            colPrimary: "white"
            // enableAnimation: false
            enableAnimation: false

            MaterialSymbol {
                anchors.centerIn: parent
                fill: 1
                text: activePlayer?.isPlaying ? "pause" : "music_note"
                iconSize: Appearance.font.pixelSize.normal
                // color: Appearance.m3colors.m3onSecondaryContainer
                color: "white"
            }
        }

        // StyledText {
        //     visible: Config.bar.verbose
        //     width: rowLayout.width - (CircularProgress.size + rowLayout.spacing * 2)
        //     Layout.alignment: Qt.AlignVCenter
        //     Layout.fillWidth: true // Ensures the text takes up available space
        //     Layout.rightMargin: rowLayout.spacing
        //     horizontalAlignment: Text.AlignHCenter
        //     elide: Text.ElideRight // Truncates the text on the right
        //     // color: Appearance.colors.colOnLayer1
        //     color: "white"
        //     // text: `${cleanedTitle}${activePlayer?.trackArtist ? ' • ' + activePlayer.trackArtist : ''}`
        //     text: `${cleanedTitle}`
        // }
    }
}
