return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
      opts = { select = { lookahead = true } },
      config = function(_, opts)
        require("nvim-treesitter-textobjects").setup(opts)
        local keymaps = {
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
        }
        for key, capture in pairs(keymaps) do
          vim.keymap.set({ "x", "o" }, key, function()
            require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
          end, { desc = "Select " .. capture })
        end
      end,
    },
    { "nvim-treesitter/nvim-treesitter-context", opts = {} },
  },
  config = function()
    local treesitter = require("nvim-treesitter")
    treesitter.setup({})
    local parsers = {
      "bash",
      "lua",
      "python",
      "rust",
      "toml",
      "go",
      "gomod",
      "java",
      "javascript",
      "typescript",
      "c",
      "html",
      "css",
      "vue",
      "json",
      "yaml",
    }
    treesitter.install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
      callback = function(event)
        -- Keep ordinary filetype behavior for buffers without a parser.
        if not pcall(vim.treesitter.start, event.buf) then
          return
        end
        vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.keymap.set({ "n", "x" }, "<CR>", function()
          vim.treesitter.select("parent")
        end, { buffer = event.buf, desc = "Expand syntax selection" })
        vim.keymap.set("x", "<BS>", function()
          vim.treesitter.select("child")
        end, { buffer = event.buf, desc = "Shrink syntax selection" })
      end,
    })
  end,
}
