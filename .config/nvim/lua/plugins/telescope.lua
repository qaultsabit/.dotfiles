return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        file_ignore_patterns = { "%.git/", "node_modules/" },
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
            ["<Tab>"] = require("telescope.actions").move_selection_next,
            ["<S-Tab>"] = require("telescope.actions").move_selection_previous,
          },
        },
      },
      pickers = {
        find_files = { hidden = true },
        live_grep = { theme = "dropdown" },
        current_buffer_fuzzy_find = { theme = "dropdown" },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
        },
      },
    })

    require("telescope").load_extension("fzf")

    local keymap = vim.keymap.set
    keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true, desc = "find files" })
    keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true, desc = "live grep" })
    keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true, desc = "find buffers" })
    keymap("n", "<leader>fs", "<cmd>Telescope builtin<CR>", { noremap = true, silent = true, desc = "find telescope" })
    keymap("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { noremap = true, silent = true, desc = "find keymaps" })
    keymap(
      "n",
      "<leader>f/",
      "<cmd>Telescope current_buffer_fuzzy_find<CR>",
      { noremap = true, silent = true, desc = "find current buffer" }
    )
    keymap("n", "<leader>fm", "<cmd>Telescope marks<CR>", { noremap = true, silent = true, desc = "find marks" })
    keymap("n", "<leader>fq", "<cmd>Telescope quickfix<CR>", { noremap = true, silent = true, desc = "find quickfix" })
  end,
}
