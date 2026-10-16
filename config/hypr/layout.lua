---@module 'hl'

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 10,
        border_size = 1,
        layout = "scrolling",
        allow_tearing = false,
        col = {
            active_border = "rgba(f0f0f0a0)",
            inactive_border = "rgba(595959aa)",
        },
    },
})

hl.config({
    decoration = {
        rounding = 7,
        blur = {
            enabled = false,
        },
    },

    scrolling = {
        direction="down",
        column_width=0.97,
    }
})
