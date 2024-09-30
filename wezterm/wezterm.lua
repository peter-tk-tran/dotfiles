-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = wezterm.config_builder()
-- This table will hold the configuration.
config = {
	check_for_updates = true,
	-- color_scheme = "Catppuccin Mocha",
	color_scheme = 'NvimDark',
	default_prog = { '/bin/zsh', '-l' },
	font_size = 14.0,
	launch_menu = {},
	-- disable_default_key_bindings = true,
	keys = {
		{ key = "Home", action = wezterm.action { ActivateTabRelative = -1 } },  -- Previous tab
		{ key = "End", action = wezterm.action { ActivateTabRelative = 1 } },    -- Next tab
		{ key = "Insert", action = wezterm.action.ShowDebugOverlay },
	    { key = "Delete", action = wezterm.action.CloseCurrentPane { confirm = true } },
		{key="RightArrow", mods="CMD", action=wezterm.action{ActivatePaneDirection="Next"}},
		{key="LeftArrow", mods="CMD", action=wezterm.action{ActivatePaneDirection="Prev"}},
		{ key = "v",  mods = "SHIFT|CTRL", action = wezterm.action.PasteFrom 'Clipboard' },
		{ key = "c",  mods = "SHIFT|CTRL", action = wezterm.action.CopyTo 'Clipboard' },
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


-- SSH DOMAINS
config.ssh_domains = {
  {
    -- This name identifies the domain
    name = 'a100',
    remote_address = '57.154.34.184',
    username = 'azureuser',
    ssh_option = {
      identityfile = '~/.ssh/id_rsa.pem',
	  port = '50000'
    },
  },
}

-- return the configuration to wezterm
return config
