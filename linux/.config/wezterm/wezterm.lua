local wezterm = require("wezterm")

-- Load modules
local options = require("modules.options")
local keys = require("modules.keymapping")

-- Apply settings
for k, v in pairs(options) do
  wezterm.config[k] = v
end

wezterm.config.keys = keys

return wezterm.config

