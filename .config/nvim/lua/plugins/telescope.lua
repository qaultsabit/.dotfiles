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
    require("telescope.pickers.layout_strategies").my_strategy = function(picker, max_columns, max_lines, layout_config)
      local layout =
        require("telescope.pickers.layout_strategies").horizontal(picker, max_columns, max_lines, layout_config)

      layout.prompt.title = ""
      layout.results.title = ""
      layout.results.line = layout.results.line - 2
      layout.results.height = layout.results.height + 2
      -- layout.preview = false
      if type(layout.preview) == "table" then
        layout.preview.title = ""
      end

      return layout
    end

    require("telescope").setup({
      defaults = {
        layout_strategy = "my_strategy",
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy = "ascending",
        -- prompt_prefix = "",
        selection_caret = "",
        entry_prefix = "",
        multi_icon = "",
        results_title = false,
        dynamic_preview_title = "",
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
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
        buffers = { hidden = true },
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

    local map = vim.keymap.set
    map("n", "<leader>f", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true, desc = "files" })
    map("n", "<leader>g", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true, desc = "grep" })
    map("n", "<leader>k", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true, desc = "buffers" })
    map("n", "<leader>m", "<cmd>Telescope marks<CR>", { noremap = true, silent = true, desc = "marks" })
    map("n", "<leader>?", "<cmd>Telescope keymaps<CR>", { noremap = true, silent = true, desc = "keymaps" })
  end,
}
