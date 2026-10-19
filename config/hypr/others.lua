---@module 'hl'
hl.config({
    -- required for togglesplit
    dwindle = { preserve_split = true },
    xwayland = { force_zero_scaling = true },
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
        },
        -- -1.0 to 1.0, 0 means no modification.
        sensitivity = 0.7,
    },
    plugin = {
        scrolloverview = {
            scale = 0.4,
            workspace_gap = 50,
            layout = "horizontal",    -- vertical, horizontal, or auto (per-monitor orientation)
            wallpaper = 2,            -- 0: global only, 1: per-workspace only, 2: both
            blur = true,              -- blur only the main overview wallpaper
            shadow = {
                enabled = false,
                range = 50,
            },
        },
    }
})

-- gesture-config [https://wiki.hypr.land/configuring/core/binds/gestures]
hl.gesture({
    fingers = 3,
    direction = "up",
    action = function()
        hl.exec_cmd("cheese")
    end,
})

hl.gesture({
    fingers = 3,
    direction = "down",
    action = function()
        hl.exec_cmd("obs")
    end,
})

-- system_wide_zoom toggle
system_wide_zoom = false
hl.bind("SUPER + Z", function()
    system_wide_zoom = not system_wide_zoom
    if system_wide_zoom then
        hl.gesture({ fingers = 2, direction = "pinch", action = "cursor_zoom", zoom_level = 1, mode = "live" })
    else
        hl.gesture({ fingers = 2, direction = "pinch", action = "unset" })
    end
    hl.exec_cmd("notify-send -t 1500 'System wide zoom " .. (system_wide_zoom and "enabled" or "disabled") .. "'")
end)

-- initialize tmux session and applications
hl.gesture({
    fingers = 4,
    direction = "right",
    action = function()
        local restore = os.getenv("HOME")
            .. "/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh"

        local script = table.concat({
            "if ! tmux has-session 2>/dev/null; then",
            "  tmux new-session -d -s editor -n editor 2>/dev/null;",
            '  ( sleep 1; tmux run-shell "' .. restore .. '" ) >/dev/null 2>&1 &',
            "fi;",
            "exec tmux attach",
        }, " ")

        hl.exec_cmd("zen")
        hl.exec_cmd("obsidian")
        hl.exec_cmd(terminal .. " -e bash -c '" .. script .. "'")
    end,
})
