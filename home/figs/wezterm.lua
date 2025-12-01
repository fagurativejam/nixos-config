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
  color_scheme = "Catppuccin Mocha", -- or "Dracula" , "Catppuccin Mocha" , "Tokyo Night"
  window_background_opacity = 0.85,
  window_padding = { left = 8, right = 8, top = 8, bottom = 8 },
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,
  inactive_pane_hsb = { saturation = 0.9, brightness = 0.8 },
  use_fancy_tab_bar = false,
  window_decorations = "NONE",
  scrollback_lines = 10000,

  keys = {
    -- Split horizontally
    {key="|", mods="CTRL|SHIFT", action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}},
    -- Split vertically
    {key="l", mods="CTRL|SHIFT", action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"}},
    -- New tab
    {key="t", mods="CTRL|SHIFT", action=wezterm.action.SpawnTab "CurrentPaneDomain"},
    -- Switch tabs
    {key="Tab", mods="CTRL", action=wezterm.action.ActivateTabRelative(1)},
    {key="Tab", mods="CTRL|SHIFT", action=wezterm.action.ActivateTabRelative(-1)},
    {key="w", mods="CTRL|ALT", action=wezterm.action.CloseCurrentPane{confirm=true}},
  },
  -- Multiplexer persistence
  unix_domains = {
    { name = "mydomain" },
  },
  default_gui_startup_args = { "connect", "local" },
}