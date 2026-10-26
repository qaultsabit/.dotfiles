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
            icons_enabled = false,
            show_filename_only = true,
            hide_filename_extension = false,
            mode = 0,
            -- fixed-width tabs: truncate long names, center short ones
            fmt = function(name)
              local width = 20
              if vim.fn.strdisplaywidth(name) > width then
                return vim.fn.strcharpart(name, 0, width - 1) .. "…"
              end
              local pad = width - vim.fn.strdisplaywidth(name)
              return string.rep(" ", math.floor(pad / 2)) .. name .. string.rep(" ", math.ceil(pad / 2))
            end,
            max_length = function()
              return vim.o.columns
            end,
            buffers_color = {
              active = "TabLineSel",
              inactive = "TabLine",
            },
            symbols = {
              alternate_file = "",
            },
          },
        },
      }
    })
  end,
}
