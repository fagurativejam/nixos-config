local wezterm = require 'wezterm'

return {
  font = wezterm.font_with_fallback {
    "JetBrains Mono Nerd Font",
    "Fira Code",
  },
  font_size = 12.0,
  color_scheme = "Catppuccin Mocha",
  window_background_opacity = 0.9,
  window_padding = { left = 5, right = 5, top = 5, bottom = 5 },
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,
  use_fancy_tab_bar = true,
  window_decorations = "RESIZE",
  scrollback_lines = 10000,
  enable_hyperlinks = true,

  keys = {
    {key="H", mods="SUPER|SHIFT", action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}},
    {key="J", mods="SUPER|SHIFT", action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"}},
    {key="H", mods="SUPER", action=wezterm.action.ActivatePaneDirection("Left")},
    {key="L", mods="SUPER", action=wezterm.action.ActivatePaneDirection("Right")},
    {key="K", mods="SUPER", action=wezterm.action.ActivatePaneDirection("Up")},
    {key="J", mods="SUPER", action=wezterm.action.ActivatePaneDirection("Down")},
    {key="H", mods="SUPER|ALT", action=wezterm.action.AdjustPaneSize{"Left", 5}},
    {key="L", mods="SUPER|ALT", action=wezterm.action.AdjustPaneSize{"Right", 5}},
    {key="K", mods="SUPER|ALT", action=wezterm.action.AdjustPaneSize{"Up", 2}},
    {key="J", mods="SUPER|ALT", action=wezterm.action.AdjustPaneSize{"Down", 2}},
    -- Tab management
    {key="T", mods="SUPER", action=wezterm.action.SpawnTab("CurrentPaneDomain")},
    {key="W", mods="SUPER", action=wezterm.action.CloseCurrentTab{confirm=true}},
    {key="Tab", mods="SUPER", action=wezterm.action.ActivateTabRelative(1)},
    {key="Tab", mods="SUPER|SHIFT", action=wezterm.action.ActivateTabRelative(-1)}
  },
}
