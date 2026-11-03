import QtQuick
import qs.Common
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    // ---------------------------------------------------------------------
    // Gruvbox Dark palette
    // ---------------------------------------------------------------------
    readonly property color gbBg0: "#1d2021"
    readonly property color gbBg1: "#282828"
    readonly property color gbBg2: "#3c3836"
    readonly property color gbFg: "#ebdbb2"
    readonly property color gbGray: "#a89984"
    readonly property color gbYellow: "#d79921"
    readonly property color gbGreen: "#98971a"
    readonly property color gbGreenBright: "#b8bb26"
    readonly property color gbRed: "#fb4934"
    readonly property color gbRedDark: "#cc241d"
    readonly property string arabicFont: "Noto Sans Arabic"

    // ---------------------------------------------------------------------
    // Plugin settings
    // ---------------------------------------------------------------------
    readonly property real latitude: {
        var raw = root.pluginData.latitude;
        var value = Number(raw);
        return (raw === undefined || raw === "" || isNaN(value)) ? 30.0444 : value;
    }

    readonly property real longitude: {
        var raw = root.pluginData.longitude;
        var value = Number(raw);
        return (raw === undefined || raw === "" || isNaN(value)) ? 31.2357 : value;
    }

    readonly property int method: {
        var raw = root.pluginData.method;
        var value = parseInt(raw, 10);
        return (raw === undefined || raw === "" || isNaN(value)) ? 5 : value;
    }

    // ---------------------------------------------------------------------
    // Prayer data
    // ---------------------------------------------------------------------
    readonly property var prayerDefs: [
        { key: "Fajr", ar: "الفجر" },
        { key: "Dhuhr", ar: "الظهر" },
        { key: "Asr", ar: "العصر" },
        { key: "Maghrib", ar: "المغرب" },
        { key: "Isha", ar: "العشاء" }
    ]

    property var timings: ({})
    property bool loading: false
    property bool fetched: false
    property string errorText: ""
    property double nowMs: Date.now()
    property double lastFetchMs: 0

    readonly property var nextInfo: root.computeNext()

    readonly property string remainingText: {
        var seconds = Math.max(0, Math.floor(root.nextInfo.remainingSeconds || 0));
        var hours = Math.floor(seconds / 3600);
        var minutes = Math.floor((seconds % 3600) / 60);
        if (hours > 0)
            return hours + ":" + root.pad2(minutes);
        if (minutes > 0)
            return "0:" + root.pad2(minutes);
        return "0:" + root.pad2(seconds % 60);
    }

    readonly property string barText: {
        if (!root.fetched)
            return root.loading ? "..." : "--:--";
        if (!root.nextInfo.ar)
            return "--:--";
        return root.nextInfo.ar + " " + root.remainingText;
    }

    readonly property string lastUpdatedText: root.lastFetchMs > 0 ? Qt.formatTime(new Date(root.lastFetchMs), "hh:mm") : "--:--"

    function pad2(value) {
        return value < 10 ? "0" + value : "" + value;
    }

    function makeDate(timeStr, dayOffset) {
        if (!timeStr)
            return null;
        var parts = timeStr.split(":");
        if (parts.length < 2)
            return null;
        var date = new Date(root.nowMs);
        date.setDate(date.getDate() + (dayOffset || 0));
        date.setHours(parseInt(parts[0], 10), parseInt(parts[1], 10), 0, 0);
        return date;
    }

    function computeNext() {
        var empty = {
            key: "",
            ar: "",
            time: "",
            remainingSeconds: 0,
            intervalSeconds: 0,
            progress: 0
        };

        if (!root.fetched)
            return empty;

        var defs = root.prayerDefs;
        var now = root.nowMs;
        var list = [];

        for (var i = 0; i < defs.length; i++) {
            var time = root.timings[defs[i].key];
            var date = root.makeDate(time, 0);
            if (date)
                list.push({ def: defs[i], time: time, ms: date.getTime() });
        }

        if (list.length !== defs.length)
            return empty;

        for (i = 0; i < list.length; i++) {
            if (list[i].ms > now) {
                var previousMs = i > 0 ? list[i - 1].ms : 0;
                if (previousMs === 0) {
                    var yesterdayIsha = root.makeDate(root.timings.Isha, -1);
                    previousMs = yesterdayIsha ? yesterdayIsha.getTime() : now;
                }
                var interval = list[i].ms - previousMs;
                var remaining = list[i].ms - now;
                return {
                    key: list[i].def.key,
                    ar: list[i].def.ar,
                    time: list[i].time,
                    remainingSeconds: Math.max(0, remaining / 1000),
                    intervalSeconds: Math.max(0, interval / 1000),
                    progress: interval > 0 ? Math.max(0, Math.min(1, remaining / interval)) : 0
                };
            }
        }

        // After Isha: the next prayer is Fajr tomorrow.
        var fajrTomorrow = root.makeDate(root.timings.Fajr, 1);
        var ishaToday = root.makeDate(root.timings.Isha, 0);
        if (!fajrTomorrow || !ishaToday)
            return empty;

        var overnightInterval = fajrTomorrow.getTime() - ishaToday.getTime();
        var overnightRemaining = fajrTomorrow.getTime() - now;
        return {
            key: "Fajr",
            ar: "الفجر",
            time: root.timings.Fajr,
            remainingSeconds: Math.max(0, overnightRemaining / 1000),
            intervalSeconds: Math.max(0, overnightInterval / 1000),
            progress: overnightInterval > 0 ? Math.max(0, Math.min(1, overnightRemaining / overnightInterval)) : 0
        };
    }

    function fetchPrayerTimes() {
        root.loading = true;
        root.errorText = "";

        var url = "https://api.aladhan.com/v1/timings?latitude=" + root.latitude
                + "&longitude=" + root.longitude
                + "&method=" + root.method;

        Proc.runCommand("prayerTimes.fetch", [
            "curl",
            "-L",
            "-sS",
            "--fail",
            "--connect-timeout", "5",
            "--max-time", "15",
            url
        ], function (stdout, exitCode) {
            root.loading = false;

            if (exitCode !== 0) {
                root.errorText = "تعذر تحديث المواقيت";
                return;
            }

            try {
                var response = JSON.parse(stdout);
                var raw = response.data.timings;
                var parsed = {};

                for (var i = 0; i < root.prayerDefs.length; i++) {
                    var key = root.prayerDefs[i].key;
                    var value = raw[key];
                    if (value)
                        parsed[key] = value.substring(0, 5);
                }

                for (i = 0; i < root.prayerDefs.length; i++) {
                    if (!parsed[root.prayerDefs[i].key]) {
                        root.errorText = "بيانات المواقيت غير مكتملة";
                        return;
                    }
                }

                root.timings = parsed;
                root.fetched = true;
                root.lastFetchMs = Date.now();
                root.nowMs = Date.now();
            } catch (e) {
                root.errorText = "تعذر قراءة بيانات المواقيت";
            }
        }, 100, 15000);
    }

    onPluginDataChanged: Qt.callLater(root.fetchPrayerTimes)

    Component.onCompleted: root.fetchPrayerTimes()

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: root.nowMs = Date.now()
    }

    Timer {
        interval: 3600000
        repeat: true
        running: true
        onTriggered: root.fetchPrayerTimes()
    }

    // ---------------------------------------------------------------------
    // Bar pill
    // ---------------------------------------------------------------------
    horizontalBarPill: Component {
        Row {
            spacing: Theme.spacingXS

            DankIcon {
                name: "prayer_times"
                size: root.iconSize
                color: Theme.widgetIconColor
                anchors.verticalCenter: parent.verticalCenter
            }

            StyledText {
                text: root.barText
                font.family: root.arabicFont
                font.pixelSize: root.textSize
                color: Theme.widgetTextColor
                anchors.verticalCenter: parent.verticalCenter
                wrapMode: Text.NoWrap
            }
        }
    }

    verticalBarPill: Component {
        Column {
            spacing: 1

            DankIcon {
                name: "prayer_times"
                size: root.iconSize
                color: Theme.widgetIconColor
                anchors.horizontalCenter: parent.horizontalCenter
            }

            StyledText {
                text: root.remainingText
                font.family: root.arabicFont
                font.pixelSize: root.textSize
                color: Theme.widgetTextColor
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.NoWrap
            }
        }
    }

    // ---------------------------------------------------------------------
    // Popout
    // ---------------------------------------------------------------------
    popoutWidth: 440

    popoutContent: Component {
        Column {
            id: contentColumn

            width: parent ? parent.width : implicitWidth
            spacing: 10

            // Title
            Item {
                width: contentColumn.width
                height: titleRow.implicitHeight + 12

                Row {
                    id: titleRow

                    anchors.right: parent.right
                    spacing: 10

                    DankIcon {
                        name: "mosque"
                        size: 26
                        color: root.gbYellow
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    StyledText {
                        text: "مواقيت الصلاة"
                        font.family: root.arabicFont
                        font.pixelSize: 26
                        font.weight: Font.DemiBold
                        color: root.gbFg
                        wrapMode: Text.NoWrap
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle {
                    anchors.right: parent.right
                    anchors.top: titleRow.bottom
                    anchors.topMargin: 7
                    width: titleRow.width
                    height: 2
                    radius: 1
                    color: root.gbGreenBright
                }
            }

            // Prayer rows
            Repeater {
                model: root.prayerDefs

                delegate: Rectangle {
                    id: prayerRow

                    property var prayer: modelData
                    readonly property bool isNext: root.nextInfo.key === prayer.key

                    width: contentColumn.width
                    height: isNext ? 68 : 48
                    radius: 10
                    color: root.gbBg1
                    border.width: 1
                    border.color: isNext ? "transparent" : root.gbBg2
                    clip: true

                    // Highlighted gradient for the next prayer.
                    Rectangle {
                        visible: prayerRow.isNext
                        anchors.fill: parent
                        radius: parent.radius
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: root.gbBg0 }
                            GradientStop { position: 0.45; color: "#33331a" }
                            GradientStop { position: 1.0; color: "#79740e" }
                        }
                    }

                    // Prayer name on the right.
                    StyledText {
                        id: prayerName

                        anchors.right: parent.right
                        anchors.rightMargin: 16
                        anchors.verticalCenter: parent.verticalCenter
                        text: prayerRow.prayer.ar
                        font.family: root.arabicFont
                        font.pixelSize: prayerRow.isNext ? 22 : 19
                        font.weight: Font.DemiBold
                        color: root.gbFg
                        wrapMode: Text.NoWrap
                    }

                    // Time on the left (countdown for the next prayer).
                    Row {
                        anchors.left: parent.left
                        anchors.leftMargin: 16
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 10

                        StyledText {
                            text: prayerRow.isNext ? root.remainingText : (root.timings[prayerRow.prayer.key] || "--:--")
                            font.family: root.arabicFont
                            font.pixelSize: prayerRow.isNext ? 22 : 19
                            font.weight: Font.DemiBold
                            color: root.gbFg
                            wrapMode: Text.NoWrap
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        StyledText {
                            visible: prayerRow.isNext
                            text: "متبقي على الأذان"
                            font.family: root.arabicFont
                            font.pixelSize: 14
                            color: root.gbFg
                            opacity: 0.85
                            wrapMode: Text.NoWrap
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    // Divider between the countdown and the prayer name.
                    Rectangle {
                        visible: prayerRow.isNext
                        width: 1
                        height: parent.height * 0.45
                        anchors.verticalCenter: parent.verticalCenter
                        x: prayerName.x - 14
                        color: root.gbFg
                        opacity: 0.55
                    }

                    // Remaining-time progress bar (remaining / interval).
                    Item {
                        visible: prayerRow.isNext
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 16
                        anchors.rightMargin: 16
                        anchors.bottomMargin: 10
                        height: 5

                        Rectangle {
                            anchors.fill: parent
                            radius: parent.height / 2
                            color: root.gbBg2
                        }

                        Rectangle {
                            width: Math.max(0, parent.width * root.nextInfo.progress)
                            height: parent.height
                            radius: parent.height / 2
                            color: root.gbGreenBright
                        }
                    }
                }
            }

            // Footer
            StyledText {
                width: parent.width
                text: root.errorText !== "" ? root.errorText : (root.loading ? "جارٍ تحديث المواقيت..." : "آخر تحديث: " + root.lastUpdatedText)
                font.family: root.arabicFont
                font.pixelSize: 12
                color: root.errorText !== "" ? root.gbRed : root.gbGray
                horizontalAlignment: Text.AlignRight
                wrapMode: Text.WordWrap
            }
        }
    }
}
