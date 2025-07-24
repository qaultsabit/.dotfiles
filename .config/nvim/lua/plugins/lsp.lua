return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "hrsh7th/cmp-nvim-lsp",
      { "mfussenegger/nvim-jdtls" },
    },
    config = function()
      local telescope = require("telescope.builtin")
      local lspconfig = require("lspconfig")
      local jdtls = require("jdtls")

      -- Autocmd to set up LSP-specific keymaps and highlighting
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          -- LSP keymaps
          pcall(vim.keymap.del, "n", "gra")
          pcall(vim.keymap.del, "n", "grn")
          pcall(vim.keymap.del, "n", "grr")
          pcall(vim.keymap.del, "n", "gri")

          vim.keymap.set("n", "gd", telescope.lsp_definitions, { desc = "goto definition" })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "goto declaration" })
          vim.keymap.set("n", "gr", telescope.lsp_references, { desc = "goto references" })
          vim.keymap.set("n", "gi", telescope.lsp_implementations, { desc = "goto implementation" })
          vim.keymap.set("n", "gt", telescope.lsp_type_definitions, { desc = "goto type definition" })

          vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "code action" })
          vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "rename" })
          vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist, { desc = "diagnostics" })
          vim.keymap.set("n", "<leader>q", telescope.diagnostics, { desc = "diagnostics" })

          -- Highlight symbols under cursor if supported
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              group = highlight_group,
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              group = highlight_group,
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({
                  group = highlight_group,
                  buffer = event2.buf,
                })
              end,
            })
          end

          -- Inlay hints toggle if supported
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, { desc = "toggle inlay hints" })
          end
        end,
      })

      -- Mason setup
      require("mason").setup()

      -- Mason LSPConfig bridge
      require("mason-lspconfig").setup({
        function(server_name)
          lspconfig[server_name].setup({})
        end,
      })

      -- Close location list or quickfix with 'q'
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "qf",
        callback = function()
          vim.keymap.set("n", "q", "<cmd>lclose<CR>", { buffer = true })
        end,
      })

      -- Tab settings for specific file types
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "lua" },
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.softtabstop = 2
        end,
      })

      -- Java LSP setup
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          local home = os.getenv("HOME")
          local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

          local config = {
            cmd = { "jdtls", "-data", workspace_folder },
            root_dir = require("jdtls.setup").find_root({
              ".git",
              "mvnw",
              "gradlew",
            }),
          }

          jdtls.start_or_attach(config)
        end,
      })
    end,
  },
}
