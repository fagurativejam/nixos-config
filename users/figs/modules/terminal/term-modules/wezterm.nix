{ config, pkgs, myTheme, ... }:

let
  colors = myTheme.colors;
  hex = myTheme.toHashHex; 
in
{
  systemd.user.services.wezterm-mux-server = {
    Unit = {
      Description = "WezTerm Multiplexer Server Daemon";
      Documentation = [ "https://wezterm.org/multiplexing.html" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.wezterm}/bin/wezterm mux-server --daemonize";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
  programs.wezterm = {
    enable = true;
    extraConfig = /*lua*/ ''
      local wezterm = require("wezterm")
      local config = wezterm.config_builder()
      local act = wezterm.action
      --Glitch & rendering fixes
        config.front_end="WebGpu"
        config.webgpu_power_preference="HighPerformance"
        config.animation_fps=1 
        config.prefer_to_spawn_tabs = true
      --Domain multiplexing
        config.unix_domains = {{name = "nixos-live-backend",},}
        config.default_gui_startup_args = { "connect", "nixos-live-backend" }
      --Font & typography
        config.font = wezterm.font_with_fallback({"JetBrains Mono Nerd Font", "Fira Code"})
        config.font_size = 12.0
      --Window & layout  
        config.window_background_opacity = 0.85
        config.window_padding = {left=8, right=8, top=8, bottom=8}
        config.inactive_pane_hsb = {saturation=0.9, brightness=0.8}
        config.window_decorations="NONE"
        config.switch_to_last_active_tab_when_closing_tab=true
        config.scrollback_lines=10000
        config.enable_scroll_bar=true
      --Cursor
        config.default_cursor_style="BlinkingBar"
        config.cursor_thickness="2.5pt"
        config.cursor_blink_rate=500
        config.force_reverse_video_cursor=true
      --Tab Bar
        config.enable_tab_bar=true
        config.use_fancy_tab_bar=true
        config.hide_tab_bar_if_only_one_tab=false
        config.tab_max_width=32
        config.window_frame = {
          font = wezterm.font{family="JetBrains Mono"},
          active_titlebar_bg = "${hex colors.bg}",
          inactive_titlebar_bg = "${hex colors.bg}",
          font_size = 11,
        }
      --Theme Color Palette
        config.colors = {
          foreground = "${hex colors.fg0}",
          background = "${hex colors.bg}",
          cursor_bg  = "${hex colors.purple1}",
          cursor_fg  = "${hex colors.crust}",
          cursor_border = "${hex colors.purple1}",
          selection_bg = "${hex colors.surface1}",
          selection_fg = "${hex colors.fg0}",
          ansi = {
            "${hex colors.surface2}",       -- black
            "${hex colors.red2}",        -- red
            "${hex colors.green2}",      -- green
            "${hex colors.yellow2}",     -- yellow
            "${hex colors.blue2}",       -- blue
            "${hex colors.purple2}",     -- magenta
            "${hex colors.cyan2}",       -- cyan
            "${hex colors.subtext1}",    -- white
          },
          brights = {
            "${hex colors.surface0}",    -- bright black
            "${hex colors.red1}",        -- bright red
            "${hex colors.green1}",      -- bright green
            "${hex colors.yellow1}",     -- bright yellow
            "${hex colors.blue1}",       -- bright blue
            "${hex colors.purple1}",     -- bright magenta
            "${hex colors.cyan1}",       -- bright cyan
            "${hex colors.white}",       -- bright white
          },
          tab_bar = {
            inactive_tab_edge = "${hex colors.fg0}",
            background = "${hex colors.bg}",
            active_tab = {
              bg_color = "${hex colors.purple1}",
              fg_color = "${hex colors.bg}",
            },
            inactive_tab = {
              bg_color = "${hex colors.surface0}",
              fg_color = "${hex colors.fg0}",
            },
            inactive_tab_hover = {
              bg_color = "${hex colors.surface1}",
              fg_color = "${hex colors.fg0}",
            },
            new_tab = {
              bg_color = "${hex colors.surface0}",
              fg_color = "${hex colors.fg0}",
            },
            new_tab_hover = {
              bg_color = "${hex colors.purple1}",
              fg_color = "${hex colors.surface0}",
            },
          },
        }
      --Keybinds
        config.disable_default_key_bindings=true
        config.keys={
          -- Split Domain
            {key="|", mods="CTRL|SHIFT", action=act.SplitHorizontal {domain="CurrentPaneDomain"}},
            {key="_", mods="CTRL|SHIFT", action=act.SplitVertical {domain="CurrentPaneDomain"}},
          -- Pane navigation
            {key="h", mods="CTRL", action=act.ActivatePaneDirection("Left")},
            {key="j", mods="CTRL", action=act.ActivatePaneDirection("Down")},
            {key="k", mods="CTRL", action=act.ActivatePaneDirection("Up")},
            {key="l", mods="CTRL", action=act.ActivatePaneDirection("Right")},
          -- Pane Resizing
            {key="h", mods="CTRL|ALT", action=act.AdjustPaneSize {"Left", 5}},
            {key="j", mods="CTRL|ALT", action=act.AdjustPaneSize {"Down", 5}},
            {key="k", mods="CTRL|ALT", action=act.AdjustPaneSize {"Up", 5}},
            {key="l", mods="CTRL|ALT", action=act.AdjustPaneSize {"Right", 5}},
          -- Workspaces
            {key="w", mods="CTRL", action=act.ShowLauncherArgs {flags="FUZZY|WORKSPACES"}},
            {key="n", mods="CTRL", action=act.SwitchToWorkspace, name="new"},
            {key="n", mods="CTRL|SHIFT", action=act.SwitchWorkspaceRelative(1)},
            {key="p", mods="CTRL|SHIFT", action=act.SwitchWorkspaceRelative(-1)},
            {key="r", mods="CTRL|ALT", action=act.PromptInputLine {description="Rename Workspace:",
                action=wezterm.action_callback(function(window,pane,line)
                  if line then
                    wezterm.mux.rename_workspace(
                      wezterm.mux.get_active_workspace(),
                      line
                    )
                  end
                end),
            },},
          -- Tab Control
            {key="t", mods="CTRL", action=act.SpawnTab("CurrentPaneDomain")},
            {key="Tab", mods="CTRL", action=act.ActivateTabRelative(1)},
            {key="Tab", mods="CTRL|SHIFT", action=act.ActivateTabRelative(-1)},
          -- Close tabs/pains
            {key="x", mods="CTRL|ALT", action=act.CloseCurrentPane {confirm=true}},
            {key="q", mods="CTRL|ALT", action=act.CloseCurrentTab {confirm=true}},
          -- Resizing
            { key = '=', mods = 'CTRL|ALT', action = act.IncreaseFontSize },
            { key = '-', mods = 'CTRL|ALT', action = act.DecreaseFontSize },
            { key = '0', mods = 'CTRL|ALT', action = act.ResetFontSize },
          -- Copy Paste 
            { key = 'c', mods = 'CTRL', action = act.CopyTo 'Clipboard' },
            { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
            { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
            { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
          -- Arrow Selection
            {key="LeftArrow",mods="SHIFT",action=act.Multiple{act.ActivateCopyMode,act.CopyMode {SetSelectionMode="Cell"},act.CopyMode'MoveLeft'}},
            {key="RightArrow",mods="SHIFT",action=act.Multiple{act.ActivateCopyMode,act.CopyMode {SetSelectionMode="Cell"},act.CopyMode'MoveRight'}},
            {key="DownArrow",mods="SHIFT",action=act.Multiple{act.ActivateCopyMode,act.CopyMode {SetSelectionMode="Cell"},act.CopyMode'MoveDown'}},
            {key="UpArrow",mods="SHIFT",action=act.Multiple{act.ActivateCopyMode,act.CopyMode {SetSelectionMode="Cell"},act.CopyMode'MoveUp'}},
          }
        config.mouse_bindings={
          {event={Down={streak=1,button ="Left"}}, mods="ALT", action=act.StartWindowDrag},
          {event={Down={streak=1,button="Middle"}}, mods="NONE", action=act.PasteFrom("Clipboard")},
        }
        --Alternative Modes for wezterm bindings
          config.key_tables={
            copy_mode={
              --Navigation
                {key="LeftArrow",mods="NONE",action=act.CopyMode 'MoveLeft'},
                {key="RightArrow",mods="NONE",action=act.CopyMode 'MoveRight'},
                {key="DownArrow",mods="NONE",action=act.CopyMode 'MoveDown'},
                {key="UpArrow",mods="NONE",action=act.CopyMode 'MoveUp'},
              --Copy & Exit CopyMode
                {key="c",mods="CTRL|SHIFT",action=act.Multiple{act.CopyTo 'Clipboard',act.CopyMode'Close'}},
                {key="y",mods="NONE",action=act.Multiple{act.CopyTo 'Clipboard',act.CopyMode'Close'}},
              --Exit CopyMode
                {key="Escape",mods="NONE",action=act.CopyMode 'Close'},
                {key="q",mods="NONE",action=act.CopyMode 'Close'},
            },
          } 
      --Events  
        wezterm.on("update-right-status", function(window, pane)
          local date = wezterm.strftime("%Y-%m-%d %H:%M")
          local ws = window:active_workspace()
          window:set_right_status(ws .. " | " .. date)
        end)
        wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
          local title = tab.active_pane.title
          if tab.is_active then
            return {
              {Text=" " .. title .. " "},
            }
          end
          return title
        end)
      return config
    '';
  };
}
