local act = require("wezterm").action

return {
  -- Font size control
  {
    key = "0",
    mods = "CTRL|SHIFT",
    action = act.ResetFontSize
  },
  {
    key = "Minus",
    mods = "CTRL|SHIFT",
    action = act.DecreaseFontSize
  },
  {
    key = "+",
    mods = "CTRL|SHIFT",
    action = act.DecreaseFontSize
  },
  -- Copy to clipboard
  {
    key = "c",
    mods = "CTRL|SHIFT",
    action = act.CopyTo("Clipboard"),
  },

  -- Paste from clipboard
  {
    key = "v",
    mods = "CTRL|SHIFT",
    action = act.PasteFrom("Clipboard"),
  },

  -- Toggle fullscreen
  {
    key = "Enter",
    mods = "ALT",
    action = act.ToggleFullScreen,
  },

  -- Open new tab
  {
    key = "t",
    mods = "CTRL|SHIFT",
    action = act.SpawnTab("DefaultDomain"),
  },

  -- Close current tab with confirmation
  {
    key = "w",
    mods = "CTRL|SHIFT",
    action = act.CloseCurrentTab({ confirm = true }),
  },

  -- Navigate pane: left
  {
    key = "LeftArrow",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection("Left"),
  },

  -- Navigate pane: right
  {
    key = "RightArrow",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection("Right"),
  },

  -- Navigate pane: up
  {
    key = "UpArrow",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection("Up"),
  },

  -- Navigate pane: down
  {
    key = "DownArrow",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection("Down"),
  },
  -- Vim-style pane navigation with CTRL+SHIFT
  {
    key = "h",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "l",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = "k",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "j",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection("Down"),
  },

  -- Split pane (auto direction)
  {
    key = "S",
    mods = "ALT|SHIFT",
    action = act.SplitPane({
      direction = "Down",
      size = {
        Percent = 50
      }
    })
  },
  {
    key = "D",
    mods = "ALT|SHIFT",
    action = act.SplitPane({
      direction = "Right",
      size = {
        Percent = 50
      }
    })
  },
  -- Tab navigation using function keys
  {
    key = "F1",
    mods = "",
    action = act.ActivateTab(0),
  },
  {
    key = "F2",
    mods = "",
    action = act.ActivateTab(1),
  },
  {
    key = "F3",
    mods = "",
    action = act.ActivateTab(2),
  },
  {
    key = "F4",
    mods = "",
    action = act.ActivateTab(3),
  },
  {
    key = "F5",
    mods = "",
    action = act.ActivateTab(4),
  },
  -- Zoom in and out of Pane
  {
    key = "z",
    mods = "CTRL|ALT",
    action = act.TogglePaneZoomState,
  },
}
