local act = require("wezterm").action

return {
  { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
  { key = "Enter", mods = "ALT", action = "ToggleFullScreen" },
  { key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab("DefaultDomain") },
  { key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
  { key = "LeftArrow", mods = "ALT", action = act.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "ALT", action = act.ActivatePaneDirection("Right") },
  { key = "UpArrow", mods = "ALT", action = act.ActivatePaneDirection("Up") },
  { key = "DownArrow", mods = "ALT", action = act.ActivatePaneDirection("Down") },
}

