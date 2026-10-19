---@module 'hl'
------------
-- Monitors |
------------
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1.25 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@100", position = "0x0", scale = 1, mirror = "eDP-1" })
hl.monitor({ output = "DP-2", mode = "1920x1080@100", position = "0x0", scale = 1, mirror = "eDP-1" })

--------------------
-- Default programs |
--------------------
terminal    = "kitty"
sysMonitor  = "btop"
fileManager = "nautilus"
menu        = "rofi -show drun -auto-select"
scripts     = os.getenv("HOME") .. "/.config/hypr/scripts/"

function run(cmd)
    hl.dispatch(hl.dsp.exec_cmd(cmd))
end

function script(name, arg)
    return hl.dsp.exec_cmd(scripts .. name .. (arg and (" " .. arg) or ""))
end

---------------------------
-- Multifile configuration |
---------------------------
require("env")
require("rules")
require("layout")
require("keymap")
require("others")
require("animations")

------------------------------
-- Initial Programs Execution |
------------------------------
hl.on("hyprland.start", function()
    run("kitty")
    run("hyprsunset")
    run("clipse -listen")
    run("awww-daemon")
    run("systemctl --user start hyprpolkitagent")
    run("hyprpm reload -n")
    run("[workspace special silent;noanim] kitty --class floating --title controlCenter")
    run("[workspace 9 silent;noanim] kitty --title sysmon -e btop")
end)

-----------------------------
-- Theme and Cursor settings |
-----------------------------
hl.on("config.reloaded", function()
    run('gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"')
    run('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
    run('hyprctl setcursor "Banana-Green" 48')
    run('gsettings set org.gnome.desktop.interface cursor-theme "Banana-Green"')
    run("gsettings set org.gnome.desktop.interface cursor-size 48")
end)
