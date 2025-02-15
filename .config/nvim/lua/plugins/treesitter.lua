return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
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
            "cpp",
        },
        highlight = { enable = true },
        indent = { enable = true },
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
    },
}
