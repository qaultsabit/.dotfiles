return {
  "github/copilot.vim",
  cmd = "Copilot",
  keys = {
    {
      "<leader>tc",
      function()
        vim.g.copilot_enabled = not vim.g.copilot_enabled
        print("copilot " .. (vim.g.copilot_enabled and "on" or "off"))
      end,
      desc = "toggle copilot",
    },
  },
  init = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_no_telemetry = true
    vim.g.copilot_enabled = false
  end,
  config = function()
    -- copilot.vim starts its client on VimEnter, which already fired before a lazy load
    vim.cmd("doautocmd <nomodeline> github_copilot VimEnter")
    vim.keymap.set("i", "<C-j>", 'copilot#Accept("<CR>")', { expr = true, silent = true, replace_keycodes = false })
  end,
}
