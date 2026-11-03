import QtQuick
import qs.Common
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
    id: root

    pluginId: "prayerTimes"

    StyledText {
        width: parent.width
        text: "Prayer Times"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Theme.fontWeightMedium
        color: Theme.surfaceText
    }

    StyledText {
        width: parent.width
        text: "The next prayer is shown in the bar. Click it for the full prayer times panel. Times come from the Aladhan API and use your system timezone."
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
        wrapMode: Text.WordWrap
    }

    StringSetting {
        settingKey: "latitude"
        label: "Latitude"
        description: "e.g. 30.0444"
        defaultValue: "30.0444"
    }

    StringSetting {
        settingKey: "longitude"
        label: "Longitude"
        description: "e.g. 31.2357"
        defaultValue: "31.2357"
    }

    SelectionSetting {
        settingKey: "method"
        label: "Calculation method"
        description: "Aladhan calculation method. Egyptian General Authority is the default for Cairo."
        options: [
            { label: "Egyptian General Authority", value: "5" },
            { label: "Muslim World League", value: "3" },
            { label: "Umm Al-Qura (Makkah)", value: "4" },
            { label: "Islamic Society of North America", value: "2" },
            { label: "University of Islamic Sciences, Karachi", value: "1" },
            { label: "Moonsighting Committee", value: "8" },
            { label: "Dubai", value: "9" },
            { label: "Qatar", value: "10" },
            { label: "Kuwait", value: "11" }
        ]
        defaultValue: "5"
    }
}
