local wezterm = require("wezterm")

return {
  font = wezterm.font_with_fallback {
    {
      family = 'JetBrainsMono Nerd Font',
      harfbuzz_features = {
              "calt=1", -- enable standard ligatures (arrows)
              "clig=0", -- disable contextual ligatures
              "liga=0", -- disable contextual alternatives
      },
    },
    -- Add more fallback fonts here if needed
  },
  font_size = 15.0,
  color_scheme = "Snazzy",

  audible_bell = "Disabled",

  -- Transparency
  window_background_opacity = 0.95,
  text_background_opacity = 1.0,

  -- Tab bar settings
  -- enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,

  -- Window appearance
  window_decorations = "RESIZE",
  window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
  },

  -- Window close confirmation
  window_close_confirmation = "NeverPrompt",
}