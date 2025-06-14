-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",
  lazyload = false,
	hl_override = {
		Comment = { italic = true, fg = "#9580FF" },
		["@comment"] = { italic = true, fg = "#9580FF" },
    AlphaHeader = { fg = "#9580FF" },
    Alphashortcut = { fg = "#9580FF"},
	},
}
-- M.nvdash = { load_on_startup = true }
 M.ui = {
       tabufline = {
          lazyload = false
      }
}

return M
