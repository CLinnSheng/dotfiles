pragma Singleton
pragma ComponentBehavior: Bound
import qs.config
import QtQuick
import Quickshell
import Quickshell.Io

/**
 * Aggressive time service that always uses fresh system time
 */
Singleton {
    // // Always get fresh time - no caching
    // readonly property string time: Qt.locale().toString(new Date(), "hh:mm")
    // readonly property string date: Qt.locale().toString(new Date(), "dddd, dd/MM")
    // readonly property string collapsedCalendarFormat: Qt.locale().toString(new Date(), "dd MMMM yyyy")
    // property string uptime: "0h, 0m"
    //
    // // Fast update timer - updates every second
    // Timer {
    //     id: fastTimer
    //     interval: 1000
    //     running: true
    //     repeat: true
    //
    //     onTriggered: {
    //         // Force property change notifications by touching a dummy property
    //         dummyTrigger = !dummyTrigger;
    //         updateUptime();
    //     }
    // }
    //
    // // Dummy property to force updates
    // property bool dummyTrigger: false
    //
    // // Function to update uptime
    // function updateUptime() {
    //     fileUptime.reload();
    //     const textUptime = fileUptime.text();
    //     const uptimeSeconds = Number(textUptime.split(" ")[0] ?? 0);
    //
    //     // Convert seconds to days, hours, and minutes
    //     const days = Math.floor(uptimeSeconds / 86400);
    //     const hours = Math.floor((uptimeSeconds % 86400) / 3600);
    //     const minutes = Math.floor((uptimeSeconds % 3600) / 60);
    //
    //     // Build the formatted uptime string
    //     let formatted = "";
    //     if (days > 0)
    //         formatted += `${days}d`;
    //     if (hours > 0)
    //         formatted += `${formatted ? ", " : ""}${hours}h`;
    //     if (minutes > 0 || !formatted)
    //         formatted += `${formatted ? ", " : ""}${minutes}m`;
    //
    //     uptime = formatted;
    // }
    //
    // FileView {
    //     id: fileUptime
    //     path: "/proc/uptime"
    // }
    //
    // Component.onCompleted: {
    //     console.log("Aggressive TimeService initialized - time will always be fresh");
    // }

    property alias enabled: clock.enabled
    readonly property date date: clock.date
    readonly property int hours: clock.hours
    readonly property int minutes: clock.minutes
    readonly property int seconds: clock.seconds

    function format(fmt: string): string {
        return Qt.formatDateTime(clock.date, fmt);
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
