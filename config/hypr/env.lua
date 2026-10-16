---@module 'hl'
------------------------
-- ENVIROMENT VARIABLES |
------------------------
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- GTK/Qt Theming
hl.env("GTK_THEME", "Adwaita-dark")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")

-- Cursor
hl.env("XCURSOR_SIZE", 48)
hl.env("XCURSOR_THEME", "Banana")
hl.env("HYPRCURSOR_THEME", "Banana-green")
hl.env("HYPRCURSOR_SIZE", 48)

-- Firefox
hl.env("MOZ_ENABLE_WAYLAND", 1)
