pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    // Remove the QtObject wrapper - properties should be directly on the Singleton
    property QtObject appearance: QtObject {
        property bool extraBackgroundTint: true
        property int fakeScreenRounding: 2
        property bool transparency: false
        property QtObject wallpaperTheming: QtObject {
            property bool enableAppsAndShell: true
            property bool enableQtApps: true
            property bool enableTerminal: true
        }
        property QtObject palette: QtObject {
            property string type: "auto"
        }
    }

    property QtObject audio: QtObject {
        property QtObject protection: QtObject {
            property bool enable: true
            property real maxAllowedIncrease: 10
            property real maxAllowed: 90
        }
    }

    property QtObject apps: QtObject {
        property string bluetooth: "kcmshell6 kcm_bluetooth"
        property string network: "plasmawindowed org.kde.plasma.networkmanagement"
        property string networkEthernet: "kcmshell6 kcm_networkmanagement"
        property string taskManager: "plasma-systemmonitor --page-name Processes"
        property string terminal: "kitty -1"
    }

    property QtObject background: QtObject {
        property bool fixedClockPosition: false
        property real clockX: -500
        property real clockY: -500
        property string wallpaperPath: ""
        property string thumbnailPath: ""
        property QtObject parallax: QtObject {
            property bool enableWorkspace: true
            property real workspaceZoom: 1.07
            property bool enableSidebar: true
        }
    }

    property QtObject bar: QtObject {
        property bool bottom: false
        property int cornerStyle: 0
        property bool borderless: false
        property string topLeftIcon: "spark"
        property bool showBackground: true
        property bool verbose: true
        property QtObject resources: QtObject {
            property bool alwaysShowSwap: false
            property bool alwaysShowCpu: true
        }
        property list<string> screenList: []
        property QtObject utilButtons: QtObject {
            property bool showScreenSnip: true
            property bool showColorPicker: false
            property bool showMicToggle: false
            property bool showKeyboardToggle: true
            property bool showDarkModeToggle: true
            property bool showPerformanceProfileToggle: false
        }
        property QtObject tray: QtObject {
            property bool monochromeIcons: true
        }
        property QtObject workspaces: QtObject {
            property bool monochromeIcons: false
            property int shown: 10
            property bool showAppIcons: false
            property bool alwaysShowNumbers: false
            property int showNumberDelay: 300
        }
        property QtObject weather: QtObject {
            property bool enable: false
            property bool enableGPS: true
            property string city: ""
            property bool useUSCS: false
            property int fetchInterval: 10
        }
    }

    property QtObject battery: QtObject {
        property int low: 20
        property int critical: 5
        property bool automaticSuspend: true
        property int suspend: 3
    }

    property QtObject dock: QtObject {
        property bool enable: false
        property bool monochromeIcons: true
        property real height: 60
        property real hoverRegionHeight: 2
        property bool pinnedOnStartup: false
        property bool hoverToReveal: true
        property list<string> pinnedApps: ["org.kde.dolphin", "kitty"]
        property list<string> ignoredAppRegexes: []
    }

    property QtObject light: QtObject {
        property QtObject night: QtObject {
            property bool automatic: true
            property string from: "19:00"
            property string to: "06:30"
            property int colorTemperature: 5000
        }
    }

    property QtObject media: QtObject {
        property bool filterDuplicatePlayers: true
    }

    property QtObject networking: QtObject {
        property string userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36"
    }

    property QtObject osd: QtObject {
        property int timeout: 1000
    }

    property QtObject osk: QtObject {
        property string layout: "qwerty_full"
        property bool pinnedOnStartup: false
    }

    property QtObject overview: QtObject {
        property bool enable: true
        property real scale: 0.18
        property real rows: 2
        property real columns: 5
    }

    property QtObject resources: QtObject {
        property int updateInterval: 3000
    }

    property QtObject search: QtObject {
        property int nonAppResultDelay: 30
        property string engineBaseUrl: "https://www.google.com/search?q="
        property list<string> excludedSites: ["quora.com"]
        property bool sloppy: false
        property QtObject prefix: QtObject {
            property string action: "/"
            property string clipboard: ";"
            property string emojis: ":"
        }
    }

    property QtObject time: QtObject {
        property string format: "hh:mm"
        property string dateFormat: "ddd, dd/MM"
    }

    property QtObject windows: QtObject {
        property bool showTitlebar: true
        property bool centerTitle: true
    }

    property QtObject hacks: QtObject {
        property int arbitraryRaceConditionDelay: 20
    }

    property QtObject screenshotTool: QtObject {
        property bool showContentRegions: true
    }
}
