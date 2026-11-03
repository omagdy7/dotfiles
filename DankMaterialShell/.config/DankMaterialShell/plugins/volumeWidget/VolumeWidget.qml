import QtQuick
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    readonly property int displayPercent: AudioService.sinkVolumePercent
    readonly property bool silent: AudioService.sinkSilent

    horizontalBarPill: Component {
        Row {
            spacing: 2

            DankIcon {
                name: AudioService.sinkVolumeIconName
                size: root.iconSize
                color: root.silent ? Theme.error : Theme.widgetIconColor
                anchors.verticalCenter: parent.verticalCenter
            }

            StyledText {
                text: root.displayPercent + "%"
                font.pixelSize: root.textSize
                color: root.silent ? Theme.error : Theme.widgetTextColor
                anchors.verticalCenter: parent.verticalCenter
                wrapMode: Text.NoWrap
            }
        }
    }

    verticalBarPill: Component {
        Column {
            spacing: 1

            DankIcon {
                name: AudioService.sinkVolumeIconName
                size: root.iconSize
                color: root.silent ? Theme.error : Theme.widgetIconColor
                anchors.horizontalCenter: parent.horizontalCenter
            }

            StyledText {
                text: root.displayPercent + "%"
                font.pixelSize: root.textSize
                color: root.silent ? Theme.error : Theme.widgetTextColor
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.NoWrap
            }
        }
    }

    pillClickAction: function () {
        AudioService.toggleMute();
    }
}
