local wezterm = require("wezterm")
local act = wezterm.action

return {
    {
        brief = "Split Pane Right",
        action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        brief = "Split Pane Down",
        action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        brief = "Reload config",
        action = act.ReloadConfiguration,
    },
    {
        brief = "Show debug overlay",
        action = act.ShowDebugOverlay,
    },
    {
        brief = "Toggle full screen",
        action = act.ToggleFullScreen,
    },
    {
        brief = "Clear scrollback",
        action = act.ClearScrollback("ScrollbackAndViewport"),
    },
}
