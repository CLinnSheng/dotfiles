//@ pragma UseQApplication
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Quickshell

import qs.modules.bar
import qs.modules.mediaControls
import qs.modules.osd
import qs.services
import qs.config

ShellRoot {
    Bar {}

    MediaControls {}

    AudioOSD {}
    BrightnessOSD {}
}
