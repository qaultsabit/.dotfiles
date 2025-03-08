return {
  "numToStr/FTerm.nvim",
  config = function()
    require("FTerm").setup({
      dimensions = {
        height = 0.8,
        width = 0.8,
      },
    })
    vim.keymap.set("n", "<leader>tt", "<cmd>lua require('FTerm').toggle()<CR>", { desc = "terminal" })
    vim.keymap.set("t", "<C-[>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
  end,
}
