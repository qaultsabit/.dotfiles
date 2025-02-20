return {
  "github/copilot.vim",

  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_no_telemetry = true
    vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Next()", { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-h>", "copilot#Previous()", { expr = true, silent = true })
  end,
}
