-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

--https://awesomewm.org/doc/api/documentation/05-awesomerc.md.html
-- Standard awesome library
local gears = require("gears") --Utilities such as color parsing and objects
local awful = require("awful") --Everything related to window managment
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
naughty.config.defaults["icon_size"] = 100

--local menubar       = require("menubar")

local lain = require("lain")
local freedesktop = require("freedesktop")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi = require("beautiful.xresources").apply_dpi
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
	for _, cmd in ipairs(cmd_arr) do
		awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
	end
end

run_once({ "unclutter -root" }) -- entries must be comma-separated
-- }}}

-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]
-- }}}

-- {{{ Variable definitions

local themes = {
	"multicolor", -- 1
	"powerarrow", -- 2
	"powerarrow-blue", -- 3
	"blackburn", -- 4
	"copland", -- 5
	"minmalist", --6
	"powerarrow-black", --7
}

-- choose your theme here
local chosen_theme = themes[7]

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

-- modkey or mod4 = super key
local modkey = "Mod4"
local altkey = "Mod1"
local modkey1 = "Control"

-- personal variables
--change these variables if you want
local browser1 = "brave"
local browser2 = "FireDragon"
local editor = os.getenv("EDITOR") or "nano"
local editorgui = "neovide"
local filemanager = "pcmanfm"
local mailclient = "mailspring"
local mediaplayer = "spotify"
local terminal = "alacritty"
local virtualmachine = "virtualbox"

-- awesome variables
awful.util.terminal = terminal
-- awful.util.tagnames = {  "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒" }
awful.util.tagnames = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
--awful.util.tagnames = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" }
--awful.util.tagnames = { "⌘", "♐", "⌥", "ℵ" }
-- awful.util.tagnames = { " WWW ", " DEV ", " STUDY ", " MUSIC ", " MAIL ", " LEISURE " }
-- awful.util.tagnames = {"  ", "  ", " 龎 ", "  ", "  "}
-- Use this : https://fontawesome.com/cheatsheet
-- awful.util.tagnames = { "", "", "", "", "" }
awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	-- awful.layout.suit.tile.left,
	-- awful.layout.suit.tile.bottom,
	-- awful.layout.suit.tile.top,
	-- awful.layout.suit.fair,
	-- awful.layout.suit.fair.horizontal,
	-- awful.layout.suit.spiral,
	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.max,
	-- awful.layout.suit.max.fullscreen,
	-- awful.layout.suit.magnifier,
	-- awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
	-- lain.layout.cascade,
	-- lain.layout.cascade.tile,
	-- lain.layout.centerwork,
	-- lain.layout.centerwork.horizontal,
	-- lain.layout.termfair,
	-- lain.layout.termfair.center,
}

awful.util.taglist_buttons = my_table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

awful.util.tasklist_buttons = my_table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			--c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

			-- Without this, the following
			-- :isvisible() makes no sense
			c.minimized = false
			if not c:isvisible() and c.first_tag then
				c.first_tag:view_only()
			end
			-- This will also un-minimize
			-- the client, if needed
			client.focus = c
			c:raise()
		end
	end),
	awful.button({}, 3, function()
		local instance = nil

		return function()
			if instance and instance.wibox.visible then
				instance:hide()
				instance = nil
			else
				instance = awful.menu.clients({ theme = { width = dpi(250) } })
			end
		end
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1
lain.layout.termfair.center.nmaster = 3
lain.layout.termfair.center.ncol = 1
lain.layout.cascade.tile.offset_x = dpi(2)
lain.layout.cascade.tile.offset_y = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster = 5
lain.layout.cascade.tile.ncol = 2

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- }}}

-- {{{ Menu
local myawesomemenu = {
	{
		"hotkeys",
		function()
			return false, hotkeys_popup.show_help
		end,
	},
	{ "arandr", "arandr" },
}

awful.util.mymainmenu = freedesktop.menu.build({
	before = {
		{ "Awesome", myawesomemenu },
	},
	after = {
		{ "Terminal", terminal },
		{
			"Log out",
			function()
				awesome.quit()
			end,
		},
		{ "Sleep", "systemctl suspend" },
		{ "Restart", "systemctl reboot" },
		{ "Shutdown", "systemctl poweroff" },
		-- other triads can be put here
	},
})

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function(s)
	local only_one = #s.tiled_clients == 1
	for _, c in pairs(s.clients) do
		if only_one and not c.floating or c.maximized then
			c.border_width = 2
		else
			c.border_width = beautiful.border_width
		end
	end
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
	beautiful.at_screen_connect(s)
	s.systray = wibox.widget.systray()
	s.systray.visible = true
end)
-- }}}

-- {{{ Mouse bindings
-- root.buttons(my_table.join(
--     awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
--     awful.button({ }, 4, awful.tag.viewnext),
--     awful.button({ }, 5, awful.tag.viewprev)
-- ))
-- }}}

-- {{{ Key bindings
globalkeys = my_table.join(
	-- super + ... function keys
	awful.key({ modkey }, "d", function()
		awful.spawn(
			string.format(
				"dmenu_run -l 15 -i",
				beautiful.bg_normal,
				beautiful.fg_normal,
				beautiful.bg_focus,
				beautiful.fg_focus
			)
		)
	end, { description = "show dmenu", group = "hotkeys" }),
	awful.key({ modkey }, "b", function()
		awful.util.spawn(browser1)
	end, { description = browser1, group = "function keys" }),
	awful.key({ modkey }, "r", function()
		awful.util.spawn(terminal .. " -e ranger")
	end, { description = "launch ranger", group = "function keys" }),
	awful.key({ modkey }, "f", function()
		awful.util.spawn(filemanager)
	end, { description = filemanager, group = "alt+ctrl" }),
	awful.key({ altkey }, "d", function()
		awful.spawn("/home/omar/.scripts/dmenuscripts.sh")
	end, { description = "all scripts", group = "hotkeys" }),
	awful.key({ altkey }, "b", function()
		awful.spawn("/home/omar/.scripts/books.sh")
	end, { description = "Books", group = "hotkeys" }),
	awful.key({ altkey }, "p", function()
		awful.spawn("/home/omar/.scripts/power.sh")
	end, { description = "books", group = "hotkeys" }),
	awful.key({ modkey }, "p", function()
		awful.spawn("/home/omar/.scripts/execute_shell.sh")
	end, { description = "execute arbitrary shell commands", group = "hotkeys" }),
	awful.key({ modkey }, "o", function()
		awful.util.spawn("rofi -show drun")
	end, { description = "rofi application launcher", group = "function keys" }),
	awful.key({ modkey }, "w", function()
		awful.util.spawn("rofi -show window")
	end, { description = "rofi fuzzy find windows", group = "function keys" }),

	-- super + ...
	awful.key({ modkey }, "v", function()
		awful.util.spawn("pavucontrol")
	end, { description = "pulseaudio control", group = "super" }),
	awful.key({ modkey }, "Escape", function()
		awful.util.spawn("xkill")
	end, { description = "Kill proces", group = "hotkeys" }),

	-- super + shift + ...
	awful.key({ modkey, "Shift" }, "Return", function()
		awful.util.spawn(filemanager)
	end),
	awful.key({ modkey, "Shift" }, "t", function()
		awful.util.spawn("/home/omar/.scripts/create_tmp.sh")
	end, { description = "launch a temp file in nvim", group = "super+shift" }),
	awful.key({ modkey, "Shift" }, "c", function()
		awful.util.spawn("/home/omar/.scripts/config_files.sh")
	end, { description = "dmenu with config files", group = "super+shift" }),

	-- ctrl+alt +  ...
	awful.key({ modkey1, altkey }, "t", function()
		awful.util.spawn(terminal)
	end, { description = terminal, group = "alt+ctrl" }),

	-- screenshots
	awful.key({}, "Print", function()
		awful.util.spawn("scrot 'ArcoLinux-%Y-%m-%d-%s_screenshot_$wx$h.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)'")
	end, { description = "Scrot", group = "screenshots" }),
	awful.key({ modkey, "Shift" }, "s", function()
		awful.util.spawn("/home/omar/.scripts/screenshot.sh")
	end, { description = "take a screenshot", group = "screenshots" }),

	-- Personal keybindings}}}

	-- Hotkeys Awesome
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	-- Tag browsing with modkey
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ altkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	-- Tag browsing alt + tab
	-- awful.key({ altkey,           }, "Tab",   awful.tag.viewnext,
	--     {description = "view next", group = "tag"}),
	-- awful.key({ altkey, "Shift"   }, "Tab",  awful.tag.viewprev,
	--     {description = "view previous", group = "tag"}),

	awful.key({ altkey }, "Tab", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			client.focus = c
			c:raise()
		end
	end),
	awful.key({ altkey, "Shift" }, "Tab", function()
		-- awful.client.focus.history.previous()
		awful.client.focus.byidx(1)
		if client.focus then
			client.focus:raise()
		end
	end),

	-- Tag browsing modkey + tab
	awful.key({ modkey }, "Tab", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey, "Shift" }, "Tab", awful.tag.viewprev, { description = "view previous", group = "tag" }),

	--Keyboard layout
	awful.key({ altkey }, "2", function()
		awful.spawn("/home/omar/.scripts/klayoutar.sh")
	end, { description = "change keyboardlayout to arabic", group = "hotkeys" }),
	awful.key({ altkey }, "1", function()
		awful.spawn("/home/omar/.scripts/klayoutus.sh")
	end, { description = "change keyboardlayout to english", group = "hotkeys" }),
	awful.key({ modkey }, "y", function()
		awful.spawn("/home/omar/.scripts/youtube.sh")
	end, { description = "change keyboardlayout to english", group = "hotkeys" }),

	-- By direction client focus
	awful.key({ modkey }, "j", function()
		awful.client.focus.global_bydirection("down")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus down", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.global_bydirection("up")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus up", group = "client" }),
	awful.key({ modkey }, "h", function()
		awful.client.focus.global_bydirection("left")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus left", group = "client" }),
	awful.key({ modkey }, "l", function()
		awful.client.focus.global_bydirection("right")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus right", group = "client" }),

	-- By direction client focus with arrows
	awful.key({ modkey1, modkey }, "Down", function()
		awful.client.focus.global_bydirection("down")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus down", group = "client" }),
	awful.key({ modkey1, modkey }, "Up", function()
		awful.client.focus.global_bydirection("up")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus up", group = "client" }),
	awful.key({ modkey1, modkey }, "Left", function()
		awful.client.focus.global_bydirection("left")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus left", group = "client" }),
	awful.key({ modkey1, modkey }, "Right", function()
		awful.client.focus.global_bydirection("right")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus right", group = "client" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	awful.key({ modkey1 }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Show/Hide Wibox
	awful.key({ modkey, "Shift" }, "b", function()
		for s in screen do
			s.mywibox.visible = not s.mywibox.visible
			if s.mybottomwibox then
				s.mybottomwibox.visible = not s.mybottomwibox.visible
			end
		end
	end, { description = "toggle wibox", group = "awesome" }),

	-- Show/Hide Systray
	awful.key({ modkey }, "-", function()
		awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
	end, { description = "Toggle systray visibility", group = "awesome" }),

	-- Show/Hide Systray
	awful.key({ modkey }, "KP_Subtract", function()
		awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
	end, { description = "Toggle systray visibility", group = "awesome" }),

	-- On the fly useless gaps change
	awful.key({ altkey, "Control" }, "j", function()
		lain.util.useless_gaps_resize(1)
	end, { description = "increment useless gaps", group = "tag" }),
	awful.key({ altkey, "Control" }, "h", function()
		lain.util.useless_gaps_resize(-1)
	end, { description = "decrement useless gaps", group = "tag" }),

	-- Dynamic tagging
	awful.key({ modkey, "Shift" }, "n", function()
		lain.util.add_tag()
	end, { description = "add new tag", group = "tag" }),
	awful.key({ modkey, "Control" }, "r", function()
		lain.util.rename_tag()
	end, { description = "rename tag", group = "tag" }),
	awful.key({ modkey, "Shift" }, "y", function()
		lain.util.delete_tag()
	end, { description = "delete tag", group = "tag" }),

	-- Standard programs
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = terminal, group = "super" }),
	awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ altkey, "Shift" }, "l", function()
		awful.tag.incmwfact(0.03)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ altkey, "Shift" }, "h", function()
		awful.tag.incmwfact(-0.03)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	--awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
	-- {description = "select previous", group = "layout"}),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			client.focus = c
			c:raise()
		end
	end, { description = "restore minimized", group = "client" }),

	-- Brightness
	awful.key({}, "XF86MonBrightnessUp", function()
		os.execute("xbacklight -inc 10")
	end, { description = "+10%", group = "hotkeys" }),
	awful.key({}, "XF86MonBrightnessDown", function()
		os.execute("xbacklight -dec 10")
	end, { description = "-10%", group = "hotkeys" }),

	-- ALSA volume control
	--awful.key({ modkey1 }, "Up",
	awful.key({}, "XF86AudioRaiseVolume", function()
		os.execute(string.format("amixer -q set %s 5%%+", beautiful.volume.channel))
		beautiful.volume.update()
	end),
	--awful.key({ modkey1 }, "Down",
	awful.key({}, "XF86AudioLowerVolume", function()
		os.execute(string.format("amixer -q set %s 5%%-", beautiful.volume.channel))
		beautiful.volume.update()
	end),
	awful.key({}, "XF86AudioMute", function()
		os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
		beautiful.volume.update()
	end),
	awful.key({ modkey1, "Shift" }, "m", function()
		os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
		beautiful.volume.update()
	end),
	awful.key({ modkey1, "Shift" }, "0", function()
		os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
		beautiful.volume.update()
	end),

	--Media keys supported by vlc, spotify, audacious, xmm2, ...
	awful.key({}, "XF86AudioPlay", function()
		awful.util.spawn("playerctl play-pause", false)
	end),
	awful.key({}, "XF86AudioNext", function()
		awful.util.spawn("playerctl next", false)
	end),
	awful.key({}, "XF86AudioPrev", function()
		awful.util.spawn("playerctl previous", false)
	end),
	awful.key({}, "XF86AudioStop", function()
		awful.util.spawn("playerctl stop", false)
	end),

	awful.key({ altkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" })
	--]]
)

clientkeys = my_table.join(
	awful.key({ altkey, "Shift" }, "m", lain.util.magnify_client, { description = "magnify client", group = "client" }),
	awful.key({ modkey, "Shift" }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey, "Shift" }, "q", function(c)
		c:kill()
	end, { description = "close", group = "hotkeys" }),
	awful.key({ modkey }, "c", function(c)
		c:kill()
	end, { description = "close", group = "hotkeys" }),
	awful.key(
		{ modkey, "Shift" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ modkey, "Shift" }, "Left", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ modkey, "Shift" }, "Right", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	--awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
	--{description = "toggle keep on top", group = "client"}),
	awful.key({ modkey }, "n", function(c)
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "maximize", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	-- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
	local descr_view, descr_toggle, descr_move, descr_toggle_focus
	if i == 1 or i == 9 then
		descr_view = { description = "view tag #", group = "tag" }
		descr_toggle = { description = "toggle tag #", group = "tag" }
		descr_move = { description = "move focused client to tag #", group = "tag" }
		descr_toggle_focus = { description = "toggle focused client on tag #", group = "tag" }
	end
	globalkeys = my_table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, descr_view),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, descr_toggle),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
					tag:view_only()
				end
			end
		end, descr_move),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, descr_toggle_focus)
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			size_hints_honor = false,
		},
	},

	{
		rule_any = { type = { "dialog", "normal" } },
		properties = { titlebars_enabled = false },
	},

	{
		rule = { class = editorgui },
		properties = { maximized = true },
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
			},
			class = {
				"Arandr",
				"Arcolinux-welcome-app.py",
				"Blueberry",
				"Galculator",
				"Gnome-font-viewer",
				"Gpick",
				"Imagewriter",
				"Font-manager",
				"Kruler",
				"MessageWin", -- kalarm.
				"arcolinux-logout",
				"Peek",
				"Skype",
				"System-config-printer.py",
				"Sxiv",
				"Unetbootin.elf",
				"Wpa_gui",
				"pinentry",
				"veromix",
				"xtightvncviewer",
				"Xfce4-terminal",
			},
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
				"Preferences",
				"setup",
			},
		},
		properties = { floating = true },
	},

	-- Floating clients but centered in screen
	{
		rule_any = {
			class = {
				"Polkit-gnome-authentication-agent-1",
				"Arcolinux-calamares-tool.py",
			},
		},
		properties = { floating = true },
		callback = function(c)
			awful.placement.centered(c, nil)
		end,
	},
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- Custom
	if beautiful.titlebar_fun then
		beautiful.titlebar_fun(c)
		return
	end

	-- Default
	-- buttons for the titlebar
	local buttons = my_table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c, { size = dpi(21) }):setup({
		{
			-- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{
			-- Middle
			{
				-- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{
			-- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

-- }}}

-- Autostart applications
awful.spawn.with_shell("picom --config  $HOME/.config/awesome/picom.conf")
awful.spawn.with_shell("$HOME/.config/awesome/autostart.sh")
awful.spawn.with_shell("$HOME/.scripts/force_full_composition_nvidia.sh")
awful.spawn.with_shell("nitrogen --restore")
