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
      local telescope = require("telescope.builtin")
      local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = 0, desc = "lsp: " .. desc })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          map("gd", telescope.lsp_definitions, "goto definition")
          map("gr", telescope.lsp_references, "goto references")
          map("gi", telescope.lsp_implementations, "goto implementation")
          map("gt", telescope.lsp_type_definitions, "goto type definition")
          map("gD", vim.lsp.buf.declaration, "goto declaration")
          map("<leader>cr", vim.lsp.buf.rename, "rename")
          map("<leader>ca", vim.lsp.buf.code_action, "code action", { "n", "x" })

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "toogle inlay hints")
          end
        end,
      })

      require("mason").setup()

      local lspconfig = require("lspconfig")
      -- require("mason-lspconfig").setup({
      --   function(server_name)
      --     lspconfig[server_name].setup({})
      --   end,
      -- })
    end,
  },
}
