return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "storm",
      terminal_colors = true,
      on_highlights = function(hl, c)
        hl.Visual = { bg = c.yellow, fg = c.black }
        hl.TelescopeSelection = { bg = c.bg_highlight, bold = true }
        hl.TelescopeMatching = { fg = c.orange }
        hl.LineNrAbove = { fg = c.yellow }
        hl.LineNrBelow = { fg = c.yellow }
        hl.LineNr = { fg = c.orange }
        hl.CursorLineNr = { fg = c.orange }
      end,
    })
    vim.cmd("colorscheme tokyonight")
  end,
}
