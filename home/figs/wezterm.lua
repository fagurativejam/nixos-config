local wezterm = require 'wezterm'

wezterm.on("update-right-status", function(window, pane)
  local date = wezterm.strftime("%Y-%m-%d %H:%M")
  window:set_right_status(date)
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title
  if tab.is_active then
    return {
      {Background={Color="#1e1e2e"}},
      {Foreground={Color="#cdd6f4"}},
      {Text=" " .. title .. " "},
    }
  end
  return title
end)

return {
  font = wezterm.font_with_fallback {
    "JetBrains Mono Nerd Font",
    "Fira Code",
  },
  font_size = 12.0,
  color_scheme = "Catppuccin Mocha",
  window_background_opacity = 0.85,
  window_padding = { left = 8, right = 8, top = 8, bottom = 8 },
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,
  inactive_pane_hsb = { saturation = 0.9, brightness = 0.8 },
  use_fancy_tab_bar = false,
  window_decorations = "RESIZE",
  scrollback_lines = 10000,

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
