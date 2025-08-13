return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = "│", right = "│" },
        section_separators = { left = " ", right = " " },
        icons_enabled = true,
      },
      sections = {
        lualine_a = { "branch", "diff" },
        lualine_b = { { "filename", path = 1, symbols = { modified = " [+]" } } },
        lualine_c = {},
        lualine_x = { "diagnostics", "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_c = { { "filename", path = 0 } },
        lualine_x = { "location" },
      },
      winbar = {
        lualine_a = {
          {
            "buffers",
            show_filename_only = true,
            hide_filename_extension = false,
            mode = 0,
            max_length = vim.o.columns,
            symbols = {
              alternate_file = "",
            },
            -- buffers_color = {
            --   active = "lualine_a_normal",
            --   inactive = "lualine_b_normal",
            -- },
          },
        },
        lualine_b = {},
        lualine_c = {},
      },
      inactive_winbar = {
        lualine_c = { "filename" },
      },
    })
  end,
}
