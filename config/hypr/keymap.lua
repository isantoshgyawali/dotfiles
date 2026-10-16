---@module 'hl'
------------------------
-- SWITCHING WORKSPACES |
------------------------
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))

-----------------------------------
-- MOVING WINDOW ACROSS WORKSPACES |
-----------------------------------
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind("SUPER + s", hl.dsp.workspace.toggle_special())
hl.bind("SUPER + SHIFT + n", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + s", hl.dsp.window.move({ workspace = "special" }))
hl.bind("SUPER + SHIFT + c", hl.dsp.window.center())

---------------------
-- WINDOW MANAGEMENT |
---------------------
hl.bind("SUPER + h", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("ALT + escape", hl.dsp.exit())
hl.bind("SUPER + t", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + ALT + p", hl.dsp.window.pseudo())

hl.bind("SUPER + f", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("SUPER + SHIFT + f", hl.dsp.window.fullscreen_state({ action = "toggle", internal = 0, client = 2 }))
hl.bind("SUPER + p", hl.dsp.window.float())
hl.bind("SUPER + O", hl.dsp.exec_cmd("hyprctl setprop active opaque toggle"))
hl.bind("SUPER + CTRL + Return", hl.dsp.exec_cmd(terminal .. ' --class "floating" --title "control-center"'))

---- RESIZING WINDOWS --
hl.bind("SUPER + CTRL + h", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
hl.bind("SUPER + CTRL + l", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
hl.bind("SUPER + CTRL + k", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))
hl.bind("SUPER + CTRL + j", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))
hl.bind("SUPER + SHIFT + CTRL + l", hl.dsp.window.resize({ x = 150, y = 0, relative = true }))
hl.bind("SUPER + SHIFT + CTRL + h", hl.dsp.window.resize({ x = -150, y = 0, relative = true }))

hl.bind("SUPER + g", script("togglegaps.sh"))
hl.bind("SUPER + SHIFT + g", script("noBorder.sh"))

-------------------------------------
-- EXECUTIONS - {PROGRAMS , SCRIPTS} |
-------------------------------------
hl.bind("SUPER + Tab", hl.dsp.exec_cmd("zen"))
hl.bind("SUPER + SHIFT + p", hl.dsp.exec_cmd("zen --private-window"))
hl.bind("SUPER + ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + n", script("blue.sh"))
hl.bind("ALT + F4", script("Wlogout.sh"))

hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + R", script("books.sh"))
hl.bind("SUPER + M", hl.dsp.exec_cmd('kitty --title "sysmon" -e ' .. sysMonitor))

-- hl.bind("ALT + tab", hl.dsp.hyprtasking:toggle("cursor"))

---- clipse: clipboard manager
hl.bind("SUPER + V", function()
    hl.exec_cmd(terminal .. " -e bash -c 'clipse -listen && clipse $PPID'",
        { float = true, size = "900 600", center = true })
end)

---- grim/slurp: screenshot and ocr
hl.bind("Print", script("fullss.sh"))
hl.bind("SUPER + SHIFT + Print", script("rectss.sh"))
hl.bind("SUPER + SHIFT + o", script("ocr.sh"))

---- hyprpicker: color picker
hl.bind("SUPER + c", hl.dsp.exec_cmd("notify-send $(hyprpicker -af hex)"))

---- volume controls
hl.bind("XF86AudioRaiseVolume", script("Volume.sh", "--inc"), { locked = true })
hl.bind("XF86AudioLowerVolume", script("Volume.sh", "--dec"), { locked = true })
-- toggele mute
hl.bind("XF86AudioMute", script("Volume.sh", "--toggle"), { locked = true })

---- brightness controls [fn key]
hl.bind("XF86MonBrightnessUp",   script("Brightness.sh", "--inc"), { locked = true }) -- +5
hl.bind("XF86MonBrightnessDown", script("Brightness.sh", "--dec"), { locked = true }) -- -5

-- set to 1: main screen and external monitor
hl.bind("SUPER + down", function()
    hl.dispatch(script("Brightness.sh", "--one"))
    hl.dispatch(script("Brightness_Monitor.sh", "--one"))
end)

-- home-row controls [sound and brightness]
hl.bind("SUPER + u", script("Brightness.sh", "--inc"))
hl.bind("SUPER + d", script("Brightness.sh", "--dec"))
hl.bind("SUPER + SHIFT + u", script("Volume.sh", "--inc"))
hl.bind("SUPER + SHIFT + d", script("Volume.sh", "--dec"))
hl.bind("SUPER + SHIFT + m", script("Volume.sh", "--toggle"))

-- monitor controls
hl.bind("SUPER + SHIFT + SPACE", script("scale.sh"))
hl.bind("SUPER + SHIFT + up",   script("Brightness_Monitor.sh", "--inc"))
hl.bind("SUPER + SHIFT + down", script("Brightness_Monitor.sh", "--dec"))

-- UI modifiers
hl.bind("SUPER + W", script("wallpaper.sh"))
hl.bind("SUPER + B", script("togglebar.sh"))
hl.bind("SUPER + SHIFT + Return", script("cursor.sh"))

----------------------------------
-- Move/resize windows with mouse |
----------------------------------
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
