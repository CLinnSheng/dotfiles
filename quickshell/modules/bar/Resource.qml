import qs.widgets
import qs.config
import QtQuick
import QtQuick.Layouts

Item {
    required property string iconName
    required property double percentage
    property bool shown: true
    clip: true
    visible: width > 0 && height > 0
    implicitWidth: resourceRowLayout.x < 0 ? 0 : childrenRect.width
    implicitHeight: childrenRect.height

    RowLayout {
        id: resourceRowLayout
        spacing: 4
        x: shown ? 0 : -resourceRowLayout.width

        CircularProgress {
            Layout.alignment: Qt.AlignVCenter
            lineWidth: 2
            value: percentage
            implicitSize: 28
            // colSecondary: Appearance.colors.colSecondaryContainer
            // colPrimary: Appearance.m3colors.m3onSecondaryContainer
            colPrimary: "white"
            colSecondary: "transparent"
            enableAnimation: false

            MaterialSymbol {
                anchors.centerIn: parent
                fill: 1
                text: iconName
                iconSize: Appearance.font.pixelSize.large
                // color: Appearance.m3colors.m3onSecondaryContainer
                color: "white"
            }
        }

        StyledText {
            Layout.alignment: Qt.AlignVCenter
            color: "white"
            text: `${Math.round(percentage * 100)}%`
        }

        Behavior on x {
            animation: Appearance.animation.elementMove.numberAnimation.createObject(this)
        }
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: Appearance.animation.elementMove.duration
            easing.type: Appearance.animation.elementMove.type
            easing.bezierCurve: Appearance.animation.elementMove.bezierCurve
        }
    }
}
