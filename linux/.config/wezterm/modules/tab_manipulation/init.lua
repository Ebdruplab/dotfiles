local wezterm = require("wezterm")

local M = {}

function M.setup_tabs()
    wezterm.on("gui-startup", function(cmd)
        local mux = wezterm.mux

        -- Create initial window/tab
        local tab1, pane1, window = mux.spawn_window(cmd or {})
        tab1:set_title("Code")

        -- Use the same window to spawn a second tab
        local tab2, pane2 = window:spawn_tab({})
        tab2:set_title("Dual")

        -- Split the second tab horizontally
        pane2:split({
            direction = "Bottom",
            size = 0.5,
        })

        -- Focus the first tab ("Code")
        window:gui_window():perform_action(
            wezterm.action({ ActivateTab = 0 }),
            pane1
        )
    end)
end

return M
