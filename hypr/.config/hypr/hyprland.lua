-- Hyprland Configuration (Lua)
-- https://wiki.hypr.land/Configuring/Start/

local home = os.getenv("HOME")
local mainMod = "SUPER"
local localBin = home .. "/.local/bin"
local scriptsDir = home .. "/.config/hypr/scripts"
local hyprDir = home .. "/.config/hypr"
local term = "ghostty"
local menu = scriptsDir .. "/menu"
local fullmenu = scriptsDir .. "/fullmenu"
local volume = scriptsDir .. "/volume"
local backlight = scriptsDir .. "/brightness"
local screenshot = scriptsDir .. "/screenshot"
local lock = scriptsDir .. "/lockscreen"
local colorpicker = scriptsDir .. "/colorpicker"
local wofi_beats = scriptsDir .. "/wofi-beats"
local files = "pcmanfm"
local browser = "brave-origin"
local editor = "nvim"
-- NOTE: the old config referenced $alt but never defined it; added here so
-- the ALT+b / ALT+m binds keep working.
local alt = "ALT"

-------------------
-- MONITOR CONFIG --
-------------------
hl.monitor({ output = "DP-3", mode = "1920x1080@60", position = "0x0", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "1920x0", scale = 1 })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

hl.workspace_rule({ workspace = "1", monitor = "DP-3" })
hl.workspace_rule({ workspace = "2", monitor = "DP-3" })
hl.workspace_rule({ workspace = "3", monitor = "DP-3" })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-1" })

-------------------
-- ENVIRONMENT VARS
-------------------
hl.env("XCURSOR_THEME", "breeze_cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "breeze_cursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("QT_QPA_PLATFORMTHEME_QT6", "gtk3")
hl.env("TERMINAL", "alacritty")

-------------------
-- STARTUP APPS ----
-------------------
hl.on("hyprland.start", function()
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd(scriptsDir .. "/portal")
	hl.exec_cmd('bash -c "wl-paste --watch cliphist store &"')
	hl.exec_cmd("dms run")
	hl.exec_cmd("/usr/lib/mate-polkit/polkit-mate-authentication-agent-1")

	hl.exec_cmd(browser .. " --disable-features=WaylandWpColorManagerV1", { workspace = "1 silent" })
	hl.exec_cmd(term, { workspace = "2 silent" })
	hl.exec_cmd("zennotes", { workspace = "4 silent" })
	hl.exec_cmd("ticktick", { workspace = "5 silent" })
end)

-------------------
-- INPUT CONFIG ----
-------------------
hl.config({
	input = {
		kb_layout = "us,eg",
		kb_options = "grp:alt_shift_toggle, caps:escape",
		kb_model = "",
		kb_rules = "",

		follow_mouse = 1,
		numlock_by_default = true,

		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
			drag_lock = true,
			disable_while_typing = true,
		},
	},
})

-------------------
-- MISC ------------
-------------------
hl.config({
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		mouse_move_enables_dpms = true,
		vrr = 1,
	},
})

hl.config({
	binds = {
		workspace_back_and_forth = false,
	},
})

-------------------
-- GENERAL LAYOUT --
-------------------
hl.config({
	general = {
		gaps_in = 1,
		gaps_out = 2,
		border_size = 2,

		col = {
			active_border = "rgba(fa282dEE)",
			inactive_border = "rgba(414868aa)",
		},

		layout = "master",
	},
})

-------------------
-- DECORATION ------
-------------------
hl.config({
	decoration = {
		rounding = 0,

		blur = {
			enabled = true,
			size = 4,
			passes = 4,
		},

		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
	},
})

hl.layer_rule({ match = { namespace = "waybar" }, blur = true })

-------------------
-- ANIMATIONS ------
-------------------
hl.config({ animations = { enabled = false } })

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

-- The following mirror the old animation entries. They are inert while
-- `animations.enabled` is false (set enabled = true to re-enable per-leaf).
hl.animation({ leaf = "windows", enabled = false, speed = 3, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = false, speed = 3, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = false, speed = 5, bezier = "default" })
hl.animation({ leaf = "fade", enabled = false, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = false, speed = 3, bezier = "default" })

-------------------
-- LAYOUTS ---------
-------------------
hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master",
		mfact = 0.5,
	},
})

-- gestures {
--     workspace_swipe = false
--     workspace_swipe_fingers = 3
-- }

-------------------
-- WINDOW RULES ----
-------------------
-- Fix weird blurry edges on chromium browsers
hl.window_rule({ match = { class = "^$", title = "^$" }, no_blur = true })
hl.window_rule({ match = { class = "^Spotify$" }, tile = true })
hl.window_rule({ match = { class = "^org\\.wezfurlong\\.wezterm$" }, tile = true })
hl.window_rule({ match = { class = "^org\\.gnome\\." }, rounding = 12 })
hl.window_rule({ match = { class = "^org\\.gnome\\." }, border_size = 0 })
hl.window_rule({ match = { class = "^gnome-control-center$" }, tile = true })
hl.window_rule({ match = { class = "^pavucontrol$" }, tile = true })
hl.window_rule({ match = { class = "^nm-connection-editor$" }, tile = true })
hl.window_rule({ match = { class = "^gnome-calculator$" }, float = true })
hl.window_rule({ match = { class = "^galculator$" }, float = true })
hl.window_rule({ match = { class = "^blueman-manager$" }, float = true })
hl.window_rule({ match = { class = "^org\\.gnome\\.Nautilus$" }, float = true })
hl.window_rule({ match = { class = "^steam$" }, float = true })
hl.window_rule({ match = { class = "^xdg-desktop-portal$" }, float = true })
hl.window_rule({ match = { class = "^firefox$", title = "^Picture-in-Picture$" }, float = true })
hl.window_rule({ match = { class = "^zoom$" }, float = true })
-- for waybar yay update click
hl.window_rule({ match = { class = "^update$", title = "^update$" }, animation = "popin" })
hl.window_rule({ match = { class = "^update$", title = "^update$" }, float = true })
hl.window_rule({ match = { class = "^update$", title = "^update$" }, size = { "60%", "50%" } })
hl.window_rule({ match = { class = "^update$", title = "^update$" }, center = true })
-- for ttyclock
hl.window_rule({ match = { class = "^clock$", title = "^clock$" }, float = true })
hl.window_rule({ match = { class = "^clock$", title = "^clock$" }, size = { "33%", "27%" } })
hl.window_rule({ match = { class = "^clock$", title = "^clock$" }, center = true })
-- NOTE: original line "match:float oning 0" was malformed; interpreted as
-- non-floating + unfocused windows

hl.layer_rule({ match = { namespace = "vicinae" }, no_anim = true })

-------------------
-- KEYBINDINGS -----
-------------------

-- === Application Launchers ===
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd(fullmenu))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("neovide"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser .. " --disable-features=WaylandWpColorManagerV1"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("pavucontrol"))
hl.bind("CTRL + ALT + R", hl.dsp.exec_cmd("rofi-theme-selector"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("archlinux-logout"))

-- DMS launchers
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("dms ipc call notifications toggle"))
-- hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("dms ipc call notepad toggle"))

-- Rofi bindings
hl.bind(mainMod .. " + d", hl.dsp.exec_cmd("rofi -show run"))
hl.bind(mainMod .. " + o", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind(mainMod .. " + i", hl.dsp.exec_cmd("rofi -show calc"))
hl.bind(mainMod .. " + w", hl.dsp.exec_cmd("rofi -show window"))
hl.bind(mainMod .. " + SHIFT + e", hl.dsp.exec_cmd("rofi -show emoji"))

-- Mainmod + Function keys
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd("inkscape"))
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd("gimp"))
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd("meld"))
hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd("vlc"))
hl.bind(mainMod .. " + F7", hl.dsp.exec_cmd("virtualbox"))
hl.bind(mainMod .. " + F8", hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + F9", hl.dsp.exec_cmd("lollypop"))
hl.bind(mainMod .. " + F10", hl.dsp.exec_cmd("spotify"))

-- === Cheat sheet ===
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("dms ipc call keybinds toggle hyprland"))

-- === Security ===
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("dms ipc call lock lock"))
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("dms ipc call processlist toggle"))

-- === Audio Controls ===
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call audio increment 5"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call audio decrement 5"), { repeating = true, locked = true })
-- hl.bind("XF86AudioMute", hl.dsp.exec_cmd("dms ipc call audio mute"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("dms ipc call audio micmute"), { locked = true })

-- === Brightness Controls ===
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(backlight .. " --inc"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(backlight .. " --dec"))
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd('dms ipc call brightness increment 5 ""'),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd('dms ipc call brightness decrement 5 ""'),
	{ repeating = true, locked = true }
)

-- Backlight control submap
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.submap("backlight"))
hl.define_submap("backlight", function()
	hl.bind("equal", hl.dsp.exec_cmd(backlight .. " --inc"))
	hl.bind("minus", hl.dsp.exec_cmd(backlight .. " --dec"))
	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Volume control submap
hl.bind(mainMod .. " + equal", hl.dsp.submap("volume"))
hl.define_submap("volume", function()
	hl.bind("equal", hl.dsp.exec_cmd(volume .. " --inc"))
	hl.bind("minus", hl.dsp.exec_cmd(volume .. " --dec"))
	hl.bind("0", hl.dsp.exec_cmd(volume .. " --toggle"))
	hl.bind("9", hl.dsp.exec_cmd(volume .. " --toggle-mic"))
	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- === Window Management ===
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(scriptsDir .. "/changeLayout"))
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())

-- === Focus Navigation ===
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))

-- === Window Movement ===
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))

-- Move active window to the next/previous monitor
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.window.move({ monitor = "+1" }))
hl.bind(mainMod .. " + SHIFT + bracketleft", hl.dsp.window.move({ monitor = "-1" }))

-- === Resize ===
-- hl.dsp.window.resize only accepts pixel values, so compute percentage
-- deltas from the active window's size at dispatch time.
local function resizeByPercent(xPct, yPct)
	return function()
		local win = hl.get_active_window()
		if not win or not win.size then
			return
		end
		local dx = math.floor(win.size.x * xPct / 100)
		local dy = math.floor(win.size.y * yPct / 100)
		hl.dispatch(hl.dsp.window.resize({ x = dx, y = dy, relative = true }))
	end
end

-- Resize the active window to exactly 100% of its monitor's width
local function resizeToExactMonitorWidth()
	return function()
		local win = hl.get_active_window()
		if not win or not win.monitor then
			return
		end
		hl.dispatch(hl.dsp.window.resize({ x = win.monitor.width, y = win.size.y }))
	end
end

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + minus", resizeByPercent(-10, 0), { repeating = true })
hl.bind(mainMod .. " + equal", resizeByPercent(10, 0), { repeating = true })
hl.bind(mainMod .. " + SHIFT + minus", resizeByPercent(0, -10), { repeating = true })
hl.bind(mainMod .. " + SHIFT + equal", resizeByPercent(0, 10), { repeating = true })

-- === Column Navigation ===
hl.bind(mainMod .. " + Home", hl.dsp.focus({ window = "first" }))
hl.bind(mainMod .. " + End", hl.dsp.focus({ window = "last" }))

-- === Monitor Navigation ===
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ monitor = "r" }))

-- === Move to Monitor ===
hl.bind(mainMod .. " + SHIFT + CTRL + left", hl.dsp.window.move({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + CTRL + down", hl.dsp.window.move({ monitor = "d" }))
hl.bind(mainMod .. " + SHIFT + CTRL + up", hl.dsp.window.move({ monitor = "u" }))
hl.bind(mainMod .. " + SHIFT + CTRL + right", hl.dsp.window.move({ monitor = "r" }))
hl.bind(mainMod .. " + SHIFT + CTRL + H", hl.dsp.window.move({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + CTRL + J", hl.dsp.window.move({ monitor = "d" }))
hl.bind(mainMod .. " + SHIFT + CTRL + K", hl.dsp.window.move({ monitor = "u" }))
hl.bind(mainMod .. " + SHIFT + CTRL + L", hl.dsp.window.move({ monitor = "r" }))

-- === Workspace Navigation ===
hl.bind(mainMod .. " + tab", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.focus({ workspace = "m-1" }))
hl.bind("ALT + tab", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("ALT + SHIFT + tab", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + Page_Down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + Page_Up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + comma", hl.dsp.focus({ workspace = "e-1" }))

-- === Move Workspaces ===
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + Page_Up", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.window.move({ workspace = "e-1" }))

-- === Mouse Wheel Navigation ===
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + mouse_down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + mouse_up", hl.dsp.window.move({ workspace = "e-1" }))

-- === Numbered Workspaces ===
for i = 1, 10 do
	local key = i % 10 -- 0 maps to workspace 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move active window to the previous/next workspace
hl.bind(mainMod .. " + bracketleft", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. " + bracketright", hl.dsp.window.move({ workspace = "+1" }))

-- === Column Management ===
hl.bind(mainMod .. " + R", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + CTRL + F", resizeToExactMonitorWidth())

-- === Special workspace ===
hl.bind(mainMod .. " + N", hl.dsp.window.move({ workspace = "special", follow = false }))
hl.bind(mainMod .. " + U", hl.dsp.workspace.toggle_special(""))

-- === Move/resize windows with mainMod + LMB/RMB and dragging ===
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

-- === Move/resize windows with mainMod + LMB/RMB and dragging ===
hl.bind(
	mainMod .. " + code:20",
	hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
	{ description = "Expand window left" }
)
hl.bind(
	mainMod .. " + code:21",
	hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
	{ description = "Shrink window left" }
)

-- === Screenshots ===
hl.bind("Print", hl.dsp.exec_cmd(screenshot .. " --now"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(screenshot .. " --in5"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(screenshot .. " --in10"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd(screenshot .. " --win"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("XF86Launch1", hl.dsp.exec_cmd("grimblast copy area"))
hl.bind("CTRL + XF86Launch1", hl.dsp.exec_cmd("grimblast copy screen"))
hl.bind("ALT + XF86Launch1", hl.dsp.exec_cmd("grimblast copy active"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("grimblast copy active"))

-- === Utilities ===
hl.bind(mainMod .. " + q", hl.dsp.exec_cmd(colorpicker))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(term .. " --class hyprpicker --hold -e hyprpicker"))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd(wofi_beats))

-- === System Controls ===
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.dpms({ action = "off" }))

hl.bind(mainMod .. " + SHIFT + t", hl.dsp.exec_cmd("handy --toggle-transcription"))

-- === Personal scripts ===
hl.bind(alt .. " + b", hl.dsp.exec_cmd(home .. "/.scripts/books.sh"))
hl.bind(alt .. " + m", hl.dsp.exec_cmd(home .. "/.scripts/movies.sh"))
hl.bind(mainMod .. " + p", hl.dsp.exec_cmd(home .. "/.scripts/toggle_waybar.sh"))
hl.bind(mainMod .. " + y", hl.dsp.exec_cmd(home .. "/.scripts/config_files.sh"))
hl.bind(mainMod .. " + t", hl.dsp.exec_cmd(home .. "/.scripts/create_tmp.sh"))
hl.bind(mainMod .. " + SHIFT + p", hl.dsp.exec_cmd(scriptsDir .. "/pomodoro.sh menu"))

-- autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("vicinae server")
end)

-- blur
hl.layer_rule({
	match = { namespace = "vicinae" },
	name = "vicinae-blur",
	blur = true,
	ignore_alpha = 0,
})

-- disable animation for vicinae only
hl.layer_rule({
	match = { namespace = "vicinae" },
	name = "vicinae-no-animation",
	no_anim = true,
})
