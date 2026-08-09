local wezterm = require("wezterm")
local config = wezterm.config_builder()

--------------------------------------------------------------------------------
-- Window Size Settings (Standard Neovim Layout)
--------------------------------------------------------------------------------
-- Sets a predictable, comfortable size on startup instead of a tiny square
config.initial_cols = 140  -- Standard columns (fits code + sidebar comfortably)
config.initial_rows = 38   -- Vertical height in text lines

--------------------------------------------------------------------------------
-- Visual & Appearance Settings
--------------------------------------------------------------------------------
config.color_scheme = "Snazzy"
config.font_size = 15.0
config.audible_bell = "Disabled"
config.window_decorations = "RESIZE"

config.font = wezterm.font_with_fallback {
  {
    family = 'JetBrainsMono Nerd Font',
    harfbuzz_features = {
      "calt=1", -- enable standard ligatures (arrows)
      "clig=0", -- disable contextual ligatures
      "liga=0", -- disable contextual alternatives
    },
  }
}

-- Transparency
config.window_background_opacity = 0.95
config.text_background_opacity = 1.0

-- Padding
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

--------------------------------------------------------------------------------
-- Tab Bar Behavior
--------------------------------------------------------------------------------
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

--------------------------------------------------------------------------------
-- System Behavior & Safety Guards
--------------------------------------------------------------------------------
config.window_close_confirmation = "AlwaysPrompt"
config.skip_close_confirmation_for_processes_named = {
  'bash', 'sh', 'zsh', 'fish', 'tmux', 'nu', 'cmd.exe', 'pwsh.exe'
}

--------------------------------------------------------------------------------
-- Keybindings & Neovim-style Leader
--------------------------------------------------------------------------------
config.leader = { key = ' ', mods = 'NONE', timeout_milliseconds = 1000 }
config.keys = {
  -- Fullscreen / Maximize Toggle (Space -> f)
  -- If you manually drag it around and need space for nvim, hit this to maximize
  {
    key = 'f',
    mods = 'LEADER',
    action = wezterm.action.ToggleFullScreen,
  },

  -- Split management (Space -> h/v)
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },

  -- Pane Zoom (Toggle Fullscreen a single split)
  {
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },

  -- Pane Navigation (Ctrl + hjkl)
  {
    key = 'h',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
}

return config
