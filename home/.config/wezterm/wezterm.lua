local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

--------------------------------------------------------------------------------
-- Appearance
--------------------------------------------------------------------------------

local themes = {
	"Catppuccin Mocha",
	"Tokyo Night",
	"Kanagawa (Gogh)",
	"Gruvbox Dark",
	"rose-pine-moon",
	"Snazzy",
}

config.color_scheme = themes[1]

-- config.font = wezterm.font("Hack Nerd Font")
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 15.0

config.window_background_opacity = 0.8
-- config.text_background_opacity = 1.0
config.macos_window_background_blur = 50

--------------------------------------------------------------------------------
-- Window & tab bar
--------------------------------------------------------------------------------

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.initial_cols = 140 -- fits code + sidebar comfortably
config.initial_rows = 38

-- config.window_padding = { left = 2, right = 2, top = 2, bottom = 2 }

-- Place a window on the left or right half of the active screen, full height.
local function snap_half(gui_window, side)
	local screen = wezterm.gui.screens().active
	local half_width = math.floor(screen.width / 2)
	local x = screen.x
	if side == "right" then
		x = x + half_width
	end
	gui_window:set_position(x, screen.y)
	gui_window:set_inner_size(half_width, screen.height)
end

--------------------------------------------------------------------------------
-- Dim unfocused windows so the focused one is obvious at a glance
--------------------------------------------------------------------------------

local UNFOCUSED_FOREGROUND_TEXT_HSB = { hue = 1.0, saturation = 0.25, brightness = 0.45 }
local UNFOCUSED_WINDOW_BACKGROUND_OPACITY = 0.62

-- get_config_overrides() returns a copy, so compare fields instead of identity.
local function same_text_hsb(actual, expected)
	if actual == nil or expected == nil then
		return actual == expected
	end
	return actual.hue == expected.hue
		and actual.saturation == expected.saturation
		and actual.brightness == expected.brightness
end

wezterm.on("window-focus-changed", function(window)
	local overrides = window:get_config_overrides() or {}
	local text_hsb, opacity
	if not window:is_focused() then
		text_hsb = UNFOCUSED_FOREGROUND_TEXT_HSB
		opacity = UNFOCUSED_WINDOW_BACKGROUND_OPACITY
	end

	-- Only write on a real change; every set_config_overrides() reloads the config.
	if same_text_hsb(overrides.foreground_text_hsb, text_hsb) and overrides.window_background_opacity == opacity then
		return
	end

	overrides.foreground_text_hsb = text_hsb
	overrides.window_background_opacity = opacity
	window:set_config_overrides(overrides)
end)

--------------------------------------------------------------------------------
-- Prefix mode (herdr/tmux style)
--   Ctrl+A, then one key. No timeout; Esc or any unmapped key cancels.
--   Ctrl+A, then h/j/k/l enters MOVE mode, which stays on until Esc.
--------------------------------------------------------------------------------

local PREFIX_TABLE = "prefix"
local MOVE_TABLE = "move"

-- Hint bar colors come from the active color scheme, so they follow theme changes.
local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme] or {}
local ansi = scheme.ansi or {}
local colors = {
	bg = scheme.background or "#1e1e2e",
	fg = scheme.foreground or "#cdd6f4",
	key = ansi[4] or "#f9e2af", -- yellow
	prefix = ansi[2] or "#f38ba8", -- red
	move = ansi[3] or "#a6e3a1", -- green
}

local modes = {
	[PREFIX_TABLE] = {
		label = " PREFIX ",
		color = colors.prefix,
		hints = {
			{ "v/-", "split" },
			{ "c", "tab" },
			{ "z", "zoom" },
			{ "x", "close" },
			{ "[/]", "snap" },
			{ "hjkl", "move" },
		},
	},
	[MOVE_TABLE] = {
		label = " MOVE ",
		color = colors.move,
		hints = {
			{ "hjkl", "move" },
			{ "HJKL", "resize" },
			{ "Esc", "done" },
		},
	},
}

-- Refresh often so the hint bar disappears promptly after a mode ends.
config.status_update_interval = 250

-- Show the hint bar for `mode_name`, or hide it when no mode is active.
local function render_mode_hints(window, mode_name)
	local mode = modes[mode_name]

	-- Force the tab bar on while a mode is active so hints show even with one tab.
	local overrides = window:get_config_overrides() or {}
	local want_hide = nil
	if mode then
		want_hide = false
	end
	if overrides.hide_tab_bar_if_only_one_tab ~= want_hide then
		overrides.hide_tab_bar_if_only_one_tab = want_hide
		window:set_config_overrides(overrides)
	end

	if not mode then
		window:set_left_status("")
		return
	end

	local cells = {
		{ Background = { Color = mode.color } },
		{ Foreground = { Color = colors.bg } },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = mode.label },
		"ResetAttributes",
		{ Text = " " },
	}
	for _, hint in ipairs(mode.hints) do
		table.insert(cells, { Foreground = { Color = colors.key } })
		table.insert(cells, { Attribute = { Intensity = "Bold" } })
		table.insert(cells, { Text = hint[1] })
		table.insert(cells, "ResetAttributes")
		table.insert(cells, { Foreground = { Color = colors.fg } })
		table.insert(cells, { Text = " " .. hint[2] .. "  " })
	end
	window:set_left_status(wezterm.format(cells))
end

wezterm.on("update-status", function(window)
	render_mode_hints(window, window:active_key_table())
end)

-- Activate a key table and show its hints immediately (not on the next status tick).
local function enter_mode(name, one_shot)
	return wezterm.action_callback(function(window, pane)
		render_mode_hints(window, name)
		window:perform_action(act.ActivateKeyTable({ name = name, one_shot = one_shot, until_unknown = true }), pane)
	end)
end

-- Snap the current window to one half of the screen.
local function snap_action(side)
	return wezterm.action_callback(function(window)
		snap_half(window, side)
	end)
end

-- Move once, then stay in MOVE mode.
local function move_then_enter_move_mode(direction)
	return act.Multiple({
		act.ActivatePaneDirection(direction),
		enter_mode(MOVE_TABLE, false),
	})
end

config.key_tables = {
	[PREFIX_TABLE] = {
		{ key = "v", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "c", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "z", action = act.TogglePaneZoomState },
		{ key = "x", action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "[", action = snap_action("left") },
		{ key = "]", action = snap_action("right") },
		{ key = "h", action = move_then_enter_move_mode("Left") },
		{ key = "j", action = move_then_enter_move_mode("Down") },
		{ key = "k", action = move_then_enter_move_mode("Up") },
		{ key = "l", action = move_then_enter_move_mode("Right") },
		-- Ctrl+A twice sends a real Ctrl+A (shell "start of line").
		{ key = "a", mods = "CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
		{ key = "Escape", action = act.PopKeyTable },
	},

	[MOVE_TABLE] = {
		{ key = "h", action = act.ActivatePaneDirection("Left") },
		{ key = "j", action = act.ActivatePaneDirection("Down") },
		{ key = "k", action = act.ActivatePaneDirection("Up") },
		{ key = "l", action = act.ActivatePaneDirection("Right") },
		{ key = "H", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
		{ key = "J", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
		{ key = "K", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "L", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
		{ key = "Escape", action = act.PopKeyTable },
	},
}

--------------------------------------------------------------------------------
-- Key bindings
--------------------------------------------------------------------------------

config.keys = {
	-- Prefix
	{ key = "a", mods = "CTRL", action = enter_mode(PREFIX_TABLE, true) },

	-- Split: Ctrl+Shift+H stacks panes, Ctrl+Shift+V puts them side by side
	{ key = "h", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- Move between panes: Alt + arrows
	{ key = "LeftArrow", mods = "ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "ALT", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "ALT", action = act.ActivatePaneDirection("Down") },

	-- Resize panes: Alt + Shift + arrows
	{ key = "LeftArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
}

return config
