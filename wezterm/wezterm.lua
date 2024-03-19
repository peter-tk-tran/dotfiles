-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = wezterm.config_builder()
-- This table will hold the configuration.
config = {
	check_for_updates = true,
	-- color_scheme = "Catppuccin Mocha",
	color_scheme = "Catppuccin Mocha",
	-- colors = { background = 'black' },
	inactive_pane_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 1.0,
	},
	default_prog = { '/bin/zsh', '-l' },
	font_size = 14.0,
	launch_menu = {},
	-- disable_default_key_bindings = true,
	keys = {
		-- 	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
		-- 	{ key = "a", mods = "LEADER|CTRL",  action = wezterm.action { SendString = "\x01" } },
		-- 	{ key = "w", mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
		-- 	{ key = "v", mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
		-- 	{ key = "z", mods = "LEADER",       action = "TogglePaneZoomState" },
		-- 	{ key = "t", mods = "LEADER",       action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
		-- 	{ key = "h", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Left" } },
		-- 	{ key = "j", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Down" } },
		-- 	{ key = "k", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Up" } },
		-- 	{ key = "l", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Right" } },
		-- 	{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
		-- 	{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },
		-- 	{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
		-- 	{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },
		-- 	{ key = "1", mods = "LEADER",       action = wezterm.action { ActivateTab = 0 } },
		-- 	{ key = "2", mods = "LEADER",       action = wezterm.action { ActivateTab = 1 } },
		-- 	{ key = "3", mods = "LEADER",       action = wezterm.action { ActivateTab = 2 } },
		-- 	{ key = "4", mods = "LEADER",       action = wezterm.action { ActivateTab = 3 } },
		-- 	{ key = "5", mods = "LEADER",       action = wezterm.action { ActivateTab = 4 } },
		-- 	{ key = "6", mods = "LEADER",       action = wezterm.action { ActivateTab = 5 } },
		-- 	{ key = "7", mods = "LEADER",       action = wezterm.action { ActivateTab = 6 } },
		-- 	{ key = "8", mods = "LEADER",       action = wezterm.action { ActivateTab = 7 } },
		-- 	{ key = "9", mods = "LEADER",       action = wezterm.action { ActivateTab = 8 } },
		-- 	{ key = "&", mods = "LEADER|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = true } } },
		-- 	{ key = "x", mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
		-- 	{ key = "n", mods = "SHIFT|CTRL",   action = "ToggleFullScreen" },
		{ key = "v",  mods = "SHIFT|CTRL", action = wezterm.action.PasteFrom 'Clipboard' },
		{ key = "c",  mods = "SHIFT|CTRL", action = wezterm.action.CopyTo 'Clipboard' },
		{ key = '\'', mods = "CMD",        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
		{ key = '"',  mods = "CMD",        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },
		-- activate pane selection mode with the default alphabet (labels are "a", "s", "d", "f" and so on)
		{ key = '8',  mods = 'CTRL',       action = wezterm.action.PaneSelect },
	},
	set_environment_variables = {},
	use_fancy_tab_bar = false,
	mouse_bindings = {
		{
			event = { Down = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = wezterm.action.CopyTo 'Clipboard',
		},
	}
}

config.window_background_opacity = 1
-- config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000

wezterm.on("update-right-status", function(window, pane)
	local cwd = pane:get_current_working_dir()

	if cwd then
		local dirname = wezterm.basename(cwd)
		window:set_title(dirname)
	else
		window:set_title("[No Directory]")
	end

	return { separator = " " }
end)


config.unix_domains = {
	{
		name = 'unix',
	},
}

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end

	local cwd = tab_info.active_pane.current_working_dir
	local folder_name = cwd:match("([^/]*)$")
	return folder_name
end

wezterm.on(
	'format-tab-title',
	function(tab, tabs, panes, config, hover, max_width)
		local title = tab_title(tab)
		return {
			-- { Background = { Color = 'blue' } },
			{ Text = ' ' .. tab.tab_index + 1 .. ': ' .. title .. ' ' },
		}
	end
)

-- and finally, return the configuration to wezterm
return config
