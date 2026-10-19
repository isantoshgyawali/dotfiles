---@module 'hl'

local function bind(key, action, opts)
    opts = opts or {}
    opts.submap_universal = true
    hl.bind(key, action, opts)
end

------------------------
-- SWITCHING WORKSPACES |
------------------------
bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))
bind("SUPER + 9", hl.dsp.focus({ workspace = 9 }))
bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))

-----------------------------------
-- MOVING WINDOW ACROSS WORKSPACES |
-----------------------------------
bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

bind("SUPER + s", hl.dsp.workspace.toggle_special())
bind("SUPER + SHIFT + n", hl.dsp.window.move({ workspace = "e+1" }))
bind("SUPER + SHIFT + s", hl.dsp.window.move({ workspace = "special" }))
bind("SUPER + SHIFT + c", hl.dsp.window.center())

---------------------
-- WINDOW MANAGEMENT |
---------------------
bind("SUPER + h", hl.dsp.focus({ direction = "left" }))
bind("SUPER + l", hl.dsp.focus({ direction = "right" }))
bind("SUPER + k", hl.dsp.focus({ direction = "up" }))
bind("SUPER + j", hl.dsp.focus({ direction = "down" }))

bind("SUPER + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
bind("SUPER + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
bind("SUPER + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
bind("SUPER + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

bind("SUPER + Q", hl.dsp.window.close())
bind("ALT + escape", hl.dsp.exit())
bind("SUPER + t", hl.dsp.layout("togglesplit"))
bind("SUPER + ALT + p", hl.dsp.window.pseudo())

bind("SUPER + f", hl.dsp.window.fullscreen({ action = "toggle" }))
bind("SUPER + SHIFT + f", hl.dsp.window.fullscreen_state({ action = "toggle", internal = 0, client = 2 }))
bind("SUPER + p", hl.dsp.window.float())
bind("SUPER + O", hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }))
bind("SUPER + CTRL + Return", hl.dsp.exec_cmd(terminal .. ' --class "floating" --title "control-center"'))

---- RESIZING WINDOWS --
bind("SUPER + CTRL + h", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
bind("SUPER + CTRL + l", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
bind("SUPER + CTRL + k", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))
bind("SUPER + CTRL + j", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))
bind("SUPER + SHIFT + CTRL + l", hl.dsp.window.resize({ x = 150, y = 0, relative = true }))
bind("SUPER + SHIFT + CTRL + h", hl.dsp.window.resize({ x = -150, y = 0, relative = true }))

bind("SUPER + g", script("togglegaps.sh"))
bind("SUPER + SHIFT + g", script("noBorder.sh"))

-------------------------------------
-- EXECUTIONS - {PROGRAMS , SCRIPTS} |
-------------------------------------
bind("SUPER + Tab", hl.dsp.exec_cmd("zen"))
bind("SUPER + SHIFT + p", hl.dsp.exec_cmd("zen --private-window"))
bind("SUPER + ALT + L", hl.dsp.exec_cmd("hyprlock"))
bind("SUPER + n", script("blue.sh"))
bind("ALT + F4", script("Wlogout.sh"))

bind("SUPER + SPACE", hl.dsp.exec_cmd(menu))
bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
bind("SUPER + R", script("books.sh"))
bind("SUPER + M", hl.dsp.exec_cmd('kitty --title "sysmon" -e ' .. sysMonitor))

-- hyprland-scroll-overview-keymaps
bind("ALT + tab", hl.plugin.scrolloverview.overview("toggle all"))
hl.define_submap("scrolloverview", function()
    hl.bind("h", hl.plugin.scrolloverview.navigate("left"))
    hl.bind("l", hl.plugin.scrolloverview.navigate("right"))
    hl.bind("k", hl.plugin.scrolloverview.navigate("up"))
    hl.bind("j", hl.plugin.scrolloverview.navigate("down"))
    hl.bind("return", hl.plugin.scrolloverview.overview("select"))
    hl.bind("escape", hl.plugin.scrolloverview.overview("off"))
    hl.bind("q", hl.plugin.scrolloverview.overview("off"))
end)

---- clipse: clipboard manager
bind("SUPER + V", function()
    hl.exec_cmd(terminal .. " -e bash -c 'clipse -listen && clipse $PPID'",
        { float = true, size = "900 600", center = true })
end)

---- grim/slurp: screenshot and ocr
bind("Print", script("fullss.sh"))
bind("SUPER + SHIFT + Print", script("rectss.sh"))
bind("SUPER + SHIFT + o", script("ocr.sh"))

---- hyprpicker: color picker
bind("SUPER + c", hl.dsp.exec_cmd("notify-send $(hyprpicker -af hex)"))

---- volume controls
bind("XF86AudioRaiseVolume", script("Volume.sh", "--inc"), { locked = true })
bind("XF86AudioLowerVolume", script("Volume.sh", "--dec"), { locked = true })
-- toggele mute
bind("XF86AudioMute", script("Volume.sh", "--toggle"), { locked = true })

---- brightness controls [fn key]
bind("XF86MonBrightnessUp", script("Brightness.sh", "--inc"), { locked = true })       -- +5
bind("XF86MonBrightnessDown", script("Brightness.sh", "--dec"), { locked = true })     -- -5

-- set to 1: main screen and external monitor
bind("SUPER + down", function()
    hl.dispatch(script("Brightness.sh", "--one"))
    hl.dispatch(script("Brightness_Monitor.sh", "--one"))
end)

-- home-row controls [sound and brightness]
bind("SUPER + u", script("Brightness.sh", "--inc"))
bind("SUPER + d", script("Brightness.sh", "--dec"))
bind("SUPER + SHIFT + u", script("Volume.sh", "--inc"))
bind("SUPER + SHIFT + d", script("Volume.sh", "--dec"))
bind("SUPER + SHIFT + m", script("Volume.sh", "--toggle"))

-- monitor controls
bind("SUPER + SHIFT + SPACE", script("scale.sh"))
bind("SUPER + SHIFT + up", script("Brightness_Monitor.sh", "--inc"))
bind("SUPER + SHIFT + down", script("Brightness_Monitor.sh", "--dec"))

-- UI modifiers
bind("SUPER + W", script("wallpaper.sh"))
bind("SUPER + B", script("togglebar.sh"))
bind("SUPER + SHIFT + Return", script("cursor.sh"))

----------------------------------
-- Move/resize windows with mouse |
----------------------------------
bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
