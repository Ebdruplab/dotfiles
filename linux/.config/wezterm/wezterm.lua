local wezterm = require("wezterm")

-- Import modular configuration
local options = require("modules.options")
local key_mappings = require("modules.keymapping")
local commands = require("modules.command")
local wsl = require("modules.wsl")
local tab_manipulation = require("modules.tab_manipulation")

-- Initialize config builder
local config = wezterm.config_builder()

-- Apply appearance and behavior settings
for key, value in pairs(options) do
  config[key] = value
end

-- Apply key mappings
if type(key_mappings) == "table" then
  config.keys = key_mappings
end

-- Apply WSL-specific settings (Windows only)
if wezterm.target_triple:find("windows") then
  local wsl_config = wsl.get_config()
  for key, value in pairs(wsl_config) do
    config[key] = value
  end
end

-- Register command palette items
wezterm.on("augment-command-palette", function()
  return commands
end)

-- Set up initial tabs and panes
tab_manipulation.setup_tabs()

-- Return final config
return config
