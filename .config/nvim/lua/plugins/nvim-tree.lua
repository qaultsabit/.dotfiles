-- nvim-tree
return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            filters = { dotfiles = false },
            disable_netrw = true,
            view = {
                float = {
                    enable = true,
                    open_win_config = function()
                        local screen_w = vim.o.columns
                        local screen_h = vim.o.lines
                        local win_w = math.floor(screen_w * 0.5)
                        local win_h = math.floor(screen_h * 0.8)
                        local row = ((screen_h - win_h) / 2) - 1
                        local col = (screen_w - win_w) / 2
                        return {
                            relative = "editor",
                            border = "solid",
                            width = win_w,
                            height = win_h,
                            row = row,
                            col = col,
                        }
                    end,
                },
                width = function()
                    return math.floor(vim.o.columns * 0.5)
                end,
            },
            renderer = {
                root_folder_label = false,
                highlight_git = true,
                group_empty = true,
            },
            actions = {
                open_file = {
                    window_picker = { enable = false },
                },
            },
        })
    end,
}
