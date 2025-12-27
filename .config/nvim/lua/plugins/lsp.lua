return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      vim.api.nvim_create_autocmd("lspattach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local opts = { buffer = event.buf, silent = true, noremap = true }

          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
          end

          -- Navigation
          map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
          map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")

          -- Diagnostics
          map("n", "<leader>d", vim.diagnostic.setloclist, "Diagnostics to Loclist")

          -- highlight symbols under cursor if supported
          if client and client.server_capabilities.documentHighlightProvider then
            local group = vim.api.nvim_create_augroup("lsp-highlight", { clear = true })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              group = group,
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              group = group,
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = group,
              callback = function()
                vim.lsp.buf.clear_references()
                vim.api.nvim_del_augroup_by_id(group)
              end,
            })
          end

          -- Inlay Hints (toggle)
          if client and client.server_capabilities.inlayHintProvider then
            map("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "Toggle Inlay Hints")
          end

          -- Diagnostic hover
          local augroup = vim.api.nvim_create_augroup("LspHover", { clear = true })
          vim.api.nvim_create_autocmd("CursorHold", {
            pattern = "*",
            group = augroup,
            callback = function()
              vim.diagnostic.open_float(nil, {
                focusable = false,
                scope = "cursor",
              })
            end,
          })
        end,
      })

      -- Mason Setup
      require("mason").setup()
      require("mason-lspconfig").setup({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
      })

      -- Keymap Quickfix window
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "qf",
        callback = function()
          vim.keymap.set("n", "q", "<cmd>lclose<CR>", { buffer = true })
          vim.keymap.set("n", "<esc>", "<cmd>lclose<CR>", { buffer = true })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "lua" },
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.softtabstop = 2
        end,
      })
    end,
  },
}
