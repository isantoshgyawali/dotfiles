return {
    "https://github.com/brianhuster/live-preview.nvim",
    events = "LazyFile",
    config = function()
        require('livepreview.config').set()
        vim.api.nvim_create_user_command("Preview", function()
            vim.cmd("LivePreview start")
        end, {})
    end
}
