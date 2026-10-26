return {
  "numToStr/FTerm.nvim",
  config = function()
    require("FTerm").setup({
      border = "solid",
      hl = "NormalFloat",
      dimensions = {
        height = 0.85,
        width = 0.85,
      },
    })
    vim.keymap.set("n", "<leader>j", "<cmd>lua require('FTerm').toggle()<CR>", { desc = "Terminal" })
    -- buffer-local so Esc still works in other :terminal buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "FTerm",
      callback = function(event)
        vim.keymap.set("t", "<C-[>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { buffer = event.buf })
      end,
    })
  end,
}
