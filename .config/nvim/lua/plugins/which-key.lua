return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    icons = {
      mappings = false,
      separator = "",
    },
    spec = {
      { "<leader>c", group = "code", mode = { "n", "x" } },
      { "<leader>d", group = "document" },
      { "<leader>r", group = "rename" },
      { "<leader>f", group = "find" },
      { "<leader>w", group = "workspace" },
      { "<leader>t", group = "toggle" },
      { "<leader>h", group = "git hunk", mode = { "n", "v" } },
    },
  },
}
