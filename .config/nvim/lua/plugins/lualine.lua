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
        disabled_filetypes = {
          statusline = { "alpha", "lazy", "dashboard", "NvimTree", "Outline", "starter" },
          winbar = { "alpha", "lazy", "dashboard", "NvimTree", "Outline", "help" },
        },
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
      tabline = {
        lualine_a = {
          {
            "buffers",
            show_filename_only = true,
            hide_frlename_extension = false,
            mode = 0,
            max_length = vim.o.columns,
            buffers_color = {
              active = "lualine_a_normal",
              inactive = "lualine_b_normal",
            },
            symbols = {
              alternate_file = "",
            },
          },
        },
        lraline_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
