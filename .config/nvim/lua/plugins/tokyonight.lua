return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight.colors").styles.moon = function()
      return vim.tbl_extend("force", require("tokyonight.colors.moon"), {
        blue = "#90a959",
        blue0 = "#3e9e5f",
        blue1 = "#5fd38d",
        blue2 = "#1fb87a",
        blue5 = "#9ff0b8",
        blue6 = "#c6f9d4",
        blue7 = "#2f5a3e",
        magenta = "#82aaff",
        purple = "#65bcff",
      })
    end
    vim.cmd.colorscheme("tokyonight")
  end,
}
