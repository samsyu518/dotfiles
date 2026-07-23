-- This is a Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

------------------
---- MONITORS ----
------------------

-- pc
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "1920x0", scale = 1 })
hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })

-- hl.monitor({ output = "DP-1",     mode = "1920x1080@60", position = "-1920x0", scale = 1 }) -- left
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x0",     scale = 1 })

-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1, mirror = "DP-1" }) -- mirror

-- hl.monitor({ output = "DP-1", disabled = true }) -- remove monitor

---------------------
---- MY PROGRAMS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Keywords/

-- Set programs that you use
-- local terminal = "kitty"
local terminal = "ghostty"
local fileManager = "dolphin"
-- local menu = "rofi -show drun"
local menu = "hyprlauncher"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
	-- for screenshare
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")
	hl.exec_cmd("systemctl --user start hyprland-session.target")

	hl.exec_cmd("nm-applet")
	hl.exec_cmd("fcitx5")
	-- hl.exec_cmd("waybar")
	-- hl.exec_cmd("hyprpaper")
	-- hl.exec_cmd("firefox-developer-edition")
	-- hl.exec_cmd("slack")
	hl.exec_cmd("dms run")
	hl.exec_cmd("hyprsunset")
	-- hl.exec_cmd("hyprpanel")
	-- hl.exec_cmd("hyprpaper")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")

	-- Stores all clipboard history (wl-paste --watch cliphist store)
	hl.exec_cmd("wl-paste --watch cliphist store")
	-- hl.exec_cmd("wl-paste --type text --watch cliphist store")  -- stores only text data
	-- hl.exec_cmd("wl-paste --type image --watch cliphist store") -- stores only image data
	hl.exec_cmd("xwaylandvideobridge")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--     ecosystem = {
--         enforce_permissions = true,
--     },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/

-- https://wiki.hypr.land/Configuring/Variables/#general
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 20,

		border_size = 1,

		-- https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- If true, will not fall back to the next available window when moving focus in a
		-- direction where no window was found. default: false
		no_focus_fallback = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",

		-- snap = {
		--     enabled        = true,
		--     border_overlap = true,
		--     respect_gaps   = true,
		-- },
	},

	-- https://wiki.hypr.land/Configuring/Variables/#decoration
	decoration = {
		rounding = 10,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1,
		inactive_opacity = 1,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},

		-- https://wiki.hypr.land/Configuring/Variables/#blur
		blur = {
			enabled = true,
			size = 20,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	-- https://wiki.hypr.land/Configuring/Variables/#animations
	animations = {
		enabled = true,
	},
})

-- Default curves, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/#curves
--                    NAME,           X0,   Y0,   X1,   Y1
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
--                        NAME,            ONOFF,  SPEED,  CURVE,           [STYLE]
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ name = "no-gaps-wtv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ name = "no-gaps-f1",   match = { float = false, workspace = "f[1]"   }, border_size = 0, rounding = 0 })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- https://wiki.hypr.land/Configuring/Variables/#misc
hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
		mouse_move_enables_dpms = false,
		key_press_enables_dpms = true,
		enable_anr_dialog = false,
		middle_click_paste = false,
	},
})

---------------
---- INPUT ----
---------------

-- https://wiki.hypr.land/Configuring/Variables/#input
hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		numlock_by_default = true,

		follow_mouse = 2, -- keyboard focus only changes on click; mouse can move freely

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true,
		},
	},

	-- https://wiki.hypr.land/Configuring/Variables/#gestures
	gestures = {
		workspace_swipe_touch = true,
	},

	group = {
		-- group_on_movetoworkspace = true,
		-- focus_removed_window     = false,
		groupbar = {
			-- stacked = true,
		},
	},
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Keywords/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
-- hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(
	mainMod .. " + SHIFT + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit")
)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + T", hl.dsp.group.toggle())
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("hyprctl dispatch exec dms restart"))

-- Group navigation
hl.bind(mainMod .. " + ALT + J", hl.dsp.group.next())
hl.bind(mainMod .. " + ALT + K", hl.dsp.group.prev())
hl.bind(mainMod .. " + ALT + H", hl.dsp.group.next())
hl.bind(mainMod .. " + ALT + L", hl.dsp.group.prev())
hl.bind(mainMod .. " + ALT + right", hl.dsp.group.next())
hl.bind(mainMod .. " + ALT + left", hl.dsp.group.prev())

-- Move window or group (group_aware = true → moves within group if in one)
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l", group_aware = true }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r", group_aware = true }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u", group_aware = true }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d", group_aware = true }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "u", group_aware = true }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "d", group_aware = true }))

-- DPMS: use hl.timer per wiki (direct dpms in binds causes parse error)
hl.bind(mainMod .. " + SEMICOLON", function()
	hl.timer(function()
		hl.dispatch(hl.dsp.dpms({ action = "disable" }))
	end, { timeout = 1000, type = "oneshot" })
end)
hl.bind(mainMod .. " + ALT + SEMICOLON", function()
	hl.timer(function()
		hl.dispatch(hl.dsp.dpms({ action = "disable" }))
		hl.timer(function()
			hl.dispatch(hl.dsp.dpms({ action = "enable" }))
		end, { timeout = 1000, type = "oneshot" })
	end, { timeout = 1000, type = "oneshot" })
end)

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move current workspace to monitor
hl.bind("CTRL + ALT + " .. mainMod .. " + SHIFT + left", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind("CTRL + ALT + " .. mainMod .. " + SHIFT + right", hl.dsp.workspace.move({ monitor = "r" }))
hl.bind("CTRL + ALT + " .. mainMod .. " + SHIFT + H", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind("CTRL + ALT + " .. mainMod .. " + SHIFT + L", hl.dsp.workspace.move({ monitor = "r" }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + equal", hl.dsp.focus({ workspace = "e+2" }))
hl.bind(mainMod .. " + minus", hl.dsp.focus({ workspace = "e-1" }))

-- Screenshot a window
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
-- Screenshot a monitor
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
-- Screenshot a region
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

-- Clipboard history
hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy")
)

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
-- hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("hyprctl hyprsunset gamma -10"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("hyprctl hyprsunset gamma +10"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ for workspace rules

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
-- hl.window_rule({
--     name  = "fix-xwayland-drags",
--     match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
--     no_focus = true,
-- })

-- Disable blur for firefox
-- hl.window_rule({ name = "no-blur-firefox", match = { class = "firefox-developer-edition" }, no_blur = true })

-- Override opacity for JetBrains IDEs
-- Note: "override" keyword from hyprlang has no direct Lua equivalent;
-- in Lua, opacity values always apply independently per rule.
-- Three values: focused, inactive, fullscreen
--
-- JetBrains focus issue
-- hl.window_rule({ name = "jb-tag-float", match = { class = "^jetbrains-.+$", float = true }, tag = "+jb" })
hl.window_rule({
	name = "jetbrains focus issue",
	match = { class = "^jetbrains-.+$" },
	no_initial_focus = true,
	tag = "+jb",
})
-- hl.window_rule({ name = "jb-stayfocused", match = { tag = "jb" }, stay_focused = true })
-- hl.window_rule({ name = "jb", match = { tag = "jb" }, no_initial_focus = false })

-- screen share
hl.window_rule({
	name = "xwayland-video-bridge-fixes",
	match = { class = "xwaylandvideobridge" },
	no_initial_focus = true,
	no_focus = true,
	no_anim = true,
	no_blur = true,
	max_size = { 1, 1 },
	opacity = "0.0",
})

-- Hyprexpo plugin (disabled)
-- hl.config({
--     plugin = {
--         hyprexpo = {
--             columns          = 3,
--             gap_size         = 5,
--             bg_col           = "rgb(111111)",
--             workspace_method = "center current",
--             enable_gesture   = true,
--             gesture_fingers  = 3,
--             gesture_distance = 300,
--             gesture_positive = true,
--         },
--     },
-- })
-- hl.bind("SUPER + grave", hl.dsp.exec_cmd("hyprexpo:expo toggle"))
-- debug: hl.config({ debug = { disable_logs = false } })
