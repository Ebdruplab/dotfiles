local wezterm = require("wezterm")

return {
  color_scheme = "Catppuccin Mocha",
  font = wezterm.font("Hack Nerd Font Mono"),
  font_size = 13.0,
  enable_tab_bar = false,
  window_padding = {
    left = 10,
    right = 10,
    top = 8,
    bottom = 8,
  },
  hide_mouse_cursor_when_typing = true,
  check_for_updates = false,
  enable_wayland = false,
  window_background_opacity = 0.92,
  macos_window_background_blur = 20,
}

