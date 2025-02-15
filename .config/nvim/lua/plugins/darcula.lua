return {
  "xiantang/darcula-dark.nvim",
  priority = 999,
  init = function()
    vim.cmd("colorscheme darcula-dark")
    require("darcula").setup({
      override = function()
        return {
          background = "#333333",
          dark = "#000000",
          olive_green = "#7ca563",
        }
      end,
      opt = {
        integrations = {
          telescope = true,
          nvim_cmp = true,
          dap_nvim = true,
        },
      },
    })
  end,
}
