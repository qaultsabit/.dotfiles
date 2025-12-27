return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    icons = {
      mappings = false,
      separator = "",
    },
    spec = {
      { "<leader>t", group = "Toggle" },
      { "<leader>h", group = "Git hunk", mode = { "n", "v" } },
      { "<leader>f", group = "Telescope" },
    },
  },
}
