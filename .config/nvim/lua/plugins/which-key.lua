return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    icons = {
      mappings = false,
      separator = "",
    },
    spec = {
      { "<leader>t", group = "toggle" },
      { "<leader>h", group = "git hunk", mode = { "n", "v" } },
    },
  },
}
