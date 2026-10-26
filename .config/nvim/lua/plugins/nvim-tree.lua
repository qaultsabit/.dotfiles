return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      filters = { dotfiles = false, custom = { "^.git$" } },
      disable_netrw = true,
      view = {
        float = {
          enable = true,
          -- recomputed on every open so it follows terminal resizes
          open_win_config = function()
            local win_w, win_h = math.floor(vim.o.columns * 0.85), math.floor(vim.o.lines * 0.85)
            return {
              relative = "editor",
              border = "solid",
              width = win_w,
              height = win_h,
              row = math.floor((vim.o.lines - win_h) / 2) - 1,
              col = math.floor((vim.o.columns - win_w) / 2),
            }
          end,
        },
        width = function()
          return math.floor(vim.o.columns * 0.85)
        end,
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        group_empty = true,
        indent_markers = { enable = true },
      },
      git = { ignore = false },
      actions = { open_file = { window_picker = { enable = false } } },
    })

    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Explorer", noremap = true, silent = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NvimTree",
      callback = function()
        vim.keymap.set("n", "<Esc>", ":NvimTreeClose<CR>", { buffer = true, silent = true })
      end,
    })
  end,
}
