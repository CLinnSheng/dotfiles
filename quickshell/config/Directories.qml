pragma Singleton
pragma ComponentBehavior: Bound

import qs.config.utils
import Qt.labs.platform
import QtQuick
import Quickshell

Singleton {
    // XDG Dirs, with "file://"
    readonly property string config: StandardPaths.standardLocations(StandardPaths.ConfigLocation)[0]
    readonly property string state: StandardPaths.standardLocations(StandardPaths.StateLocation)[0]
    readonly property string cache: StandardPaths.standardLocations(StandardPaths.CacheLocation)[0]
    readonly property string pictures: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
    readonly property string downloads: StandardPaths.standardLocations(StandardPaths.DownloadLocation)[0]

    // Other dirs used by the shell, without "file://"
    property string scriptPath: Quickshell.shellPath("scripts")
    property string coverArt: FileUtils.trimFileProtocol(`${Directories.cache}/media/coverart`)
    // property string favicons: FileUtils.trimFileProtocol(`${Directories.cache}/media/favicons`)

}
