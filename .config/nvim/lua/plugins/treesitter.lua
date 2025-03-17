return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "bash",
      "lua",
      "rust",
      "toml",
      "go",
      "gomod",
      "javascript",
      "typescript",
      "c",
      "html",
      "css",
      "json",
      "yaml",
    },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        scope_incremental = false,
        node_decremental = "<BS>",
      },
    },
    textobjects = {
      lsp_interop = { enable = true },
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
      },
    },
    context = {
      enable = true,
      throttle = true,
    },
  },
}
