local wezterm = require("wezterm")

local M = {}
-- Detect hostname
local hostname = wezterm.hostname()

-- Set default home and project paths
local home = wezterm.home_dir
local code_dir
local work_proj_dir = home .. "git/work"
local ebd_proj_dir = home .. "/git/ebdruplab"
local dotfiles_dir = ebd_proj_dir .. "/dotfiles"

if hostname == "FedoraLinux" then
  code_dir = ebd_proj_dir .. "/CodeCabinet"
else
  code_dir = work_proj_dir .. "/ansible-nginx_automation"
end

function M.setup_tabs()
  wezterm.on("gui-startup", function(cmd)
    local mux = wezterm.mux

    -- Create one window to hold multiple tabs
    local tab1, pane1, window = mux.spawn_window({ cwd = home })
    tab1:set_title("Default")

    -- Create second tab: Code
    local tab2, pane2 = window:spawn_tab({ cwd = code_dir })
    tab2:set_title("Code")

    -- Create third tab: Dual
    local tab3, pane3 = window:spawn_tab({ cwd = home })
    tab3:set_title("Dual")

    -- Split the third tab horizontally
    pane3:split({
      direction = "Bottom",
      size = 0.5,
      cwd = home
    })

    -- Create 4. tab: Dotfiles
    local tab4, pane4 = window:spawn_tab({ cwd = dotfiles_dir })
    tab4:set_title("Dotfiles")

    -- Create fifth tab: 3Screens
    local tab5, pane_left = window:spawn_tab({ cwd = home })
    tab5:set_title("3Screens")

    -- Split RIGHT of the LEFT pane
    local pane_right_top = pane_left:split({
      direction = "Right",
      size = 0.5,
      cwd = home,
    })

    -- Split DOWN inside the RIGHT pane
    pane_right_top:split({
      direction = "Bottom",
      size = 0.5,
      cwd = home,
    })

    -- Focus the first tab
    window:gui_window():perform_action(
      wezterm.action({ ActivateTab = 1 }),
      pane1
    )
  end)
end

return M
