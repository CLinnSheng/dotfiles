import qs.config
import QtQuick
import QtQuick.Layouts

Text {
    id: root

    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    color: "white"

    font {
        hintingPreference: Font.PreferFullHinting
        family: Appearance?.font.family.main ?? "sans-serif"
        pixelSize: Appearance?.font.pixelSize.small ?? 15
    }
}
