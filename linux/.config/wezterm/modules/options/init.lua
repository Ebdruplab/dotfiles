local wezterm = require("wezterm")

return {

  color_scheme = "Catppuccin Mocha",
  font = wezterm.font("Hack Nerd Font"),
  font_size = 13.0,
  window_padding = {
    left = 10,
    right = 10,
    top = 8,
    bottom = 8,
  },
  hide_mouse_cursor_when_typing = true,
  check_for_updates = false,
  enable_wayland = false,
  enable_tab_bar = true,
  window_background_opacity = 0.92,
  macos_window_background_blur = 20,
  max_fps = 120,
  prefer_egl = true,
}

