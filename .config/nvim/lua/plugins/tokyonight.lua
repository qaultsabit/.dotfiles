return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "storm",
      terminal_colors = true,
      on_highlights = function(highlights, colors)
        highlights.Visual = { bg = colors.blue, fg = colors.black }
        highlights.TelescopeSelection = { bg = colors.bg_highlight, fg = colors.fg, bold = true }
        highlights.TelescopeMatching = { fg = colors.orange }
      end,
    })
    vim.cmd("colorscheme tokyonight")
  end,
}
