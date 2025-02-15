return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local screen_w, screen_h = vim.o.columns, vim.o.lines
    local win_w, win_h = math.floor(screen_w * 0.5), math.floor(screen_h * 0.8)
    local row, col = ((screen_h - win_h) / 2) - 1, (screen_w - win_w) / 2

    require("nvim-tree").setup({
      filters = { dotfiles = false, custom = { "^.git$" } },
      disable_netrw = true,
      view = {
        float = {
          enable = true,
          open_win_config = {
            relative = "editor",
            border = "solid",
            width = win_w,
            height = win_h,
            row = row,
            col = col,
          },
        },
        width = function()
          return win_w
        end,
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        group_empty = true,
        indent_markers = { enable = true },
      },
      actions = { open_file = { window_picker = { enable = false } } },
    })

    vim.keymap.set("n", "\\", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
  end,
}
