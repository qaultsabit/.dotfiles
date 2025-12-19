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

      -- Close location list or quickfix with 'q' and 'esc'
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "qf",
        callback = function()
          vim.keymap.set("n", "q", "<cmd>lclose<CR>", { buffer = true })
          vim.keymap.set("n", "<esc>", "<cmd>lclose<CR>", { buffer = true })
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

      -- Grup autocommand agar rapi
      local augroup = vim.api.nvim_create_augroup("LspHover", { clear = true })

      vim.api.nvim_create_autocmd("CursorHold", {
        pattern = "*",
        group = augroup,
        callback = function()
          vim.diagnostic.open_float(nil, {
            focusable = false, -- Agar jendela tidak mengambil fokus
            scope = "cursor", -- Hanya tampilkan diagnostik di bawah kursor
          })
        end,
      })
    end,
  },
}

-- return {
--   {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--       { "williamboman/mason.nvim", config = true },
--       "williamboman/mason-lspconfig.nvim",
--       { "j-hui/fidget.nvim", opts = {} },
--       "hrsh7th/cmp-nvim-lsp",
--       { "mfussenegger/nvim-jdtls" },
--     },
--     config = function()
--       -- Main augroup for LSP lifecycle events
--       local lsp_lifecycle_augroup = vim.api.nvim_create_augroup("LspLifecycle", { clear = true })
--       -- Augroup for highlighting, 'clear = false' to allow accumulation
--       local highlight_augroup = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
--
--       -- This function will be called every time an LSP server attaches to a buffer
--       local function on_lsp_attach(event)
--         local client = vim.lsp.get_client_by_id(event.data.client_id)
--         local bufnr = event.buf
--         local telescope = require("telescope.builtin")
--
--         -- Local keymap options for this buffer
--         local map_opts = { buffer = bufnr, noremap = true, silent = true }
--
--         -- Set LSP keymaps
--         map_opts.desc = "Goto Definition"
--         vim.keymap.set("n", "gd", telescope.lsp_definitions, map_opts)
--         map_opts.desc = "Goto Declaration"
--         vim.keymap.set("n", "gD", vim.lsp.buf.declaration, map_opts)
--         map_opts.desc = "Goto References"
--         vim.keymap.set("n", "gr", telescope.lsp_references, map_opts)
--         map_opts.desc = "Goto Implementation"
--         vim.keymap.set("n", "gi", telescope.lsp_implementations, map_opts)
--         map_opts.desc = "Goto Type Definition"
--         vim.keymap.set("n", "gt", telescope.lsp_type_definitions, map_opts)
--         map_opts.desc = "Code Action"
--         vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, map_opts)
--         map_opts.desc = "Rename Symbol"
--         vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, map_opts)
--         map_opts.desc = "Diagnostics (Set Loclist)"
--         vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist, map_opts)
--         map_opts.desc = "Diagnostics (Telescope)"
--         vim.keymap.set("n", "<leader>q", telescope.diagnostics, map_opts)
--
--         -- Highlight symbols under cursor if supported
--         if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
--           vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--             group = highlight_augroup,
--             buffer = bufnr,
--             callback = vim.lsp.buf.document_highlight,
--           })
--           vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
--             group = highlight_augroup,
--             buffer = bufnr,
--             callback = vim.lsp.buf.clear_references,
--           })
--
--           -- Set up highlight autocmd cleanup on LspDetach
--           vim.api.nvim_create_autocmd("LspDetach", {
--             group = lsp_lifecycle_augroup, -- Use the main augroup
--             buffer = bufnr,
--             callback = function(ev)
--               vim.lsp.buf.clear_references()
--               vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = ev.buf })
--             end,
--           })
--         end
--
--         -- Toggle Inlay hints if supported
--         if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
--           map_opts.desc = "Toggle Inlay Hints"
--           vim.keymap.set("n", "<leader>th", function()
--             vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
--           end, map_opts)
--         end
--       end
--
--       -- Function to set up utility (non-LSP) autocommands
--       local function setup_utility_autocmds()
--         local utility_augroup = vim.api.nvim_create_augroup("UserUtilityAutocmds", { clear = true })
--
--         -- Close quickfix/location list with 'q' or '<esc>'
--         vim.api.nvim_create_autocmd("FileType", {
--           group = utility_augroup,
--           pattern = "qf",
--           desc = "Close qf/loclist with q or <esc>",
--           callback = function(event)
--             local map_opts = { buffer = event.buf, silent = true }
--             vim.keymap.set("n", "q", "<cmd>lclose<CR>", map_opts)
--             vim.keymap.set("n", "<esc>", "<cmd>lclose<CR>", map_opts)
--           end,
--         })
--
--         -- Tab settings for web and lua files
--         vim.api.nvim_create_autocmd("FileType", {
--           group = utility_augroup,
--           pattern = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "lua" },
--           desc = "Set 2-space tabs for web/lua files",
--           callback = function()
--             vim.opt_local.tabstop = 2
--             vim.opt_local.shiftwidth = 2
--             vim.opt_local.softtabstop = 2
--           end,
--         })
--
--         -- Show diagnostics (errors) on cursor hover
--         vim.api.nvim_create_autocmd("CursorHold", {
--           group = utility_augroup,
--           pattern = "*",
--           desc = "Show diagnostics on hover",
--           callback = function()
--             vim.diagnostic.open_float(nil, {
--               focusable = false, -- So the window doesn't take focus
--               scope = "cursor", -- Only show diagnostics under the cursor
--             })
--           end,
--         })
--       end
--
--       -- --- CONFIGURATION EXECUTION ---
--
--       -- 1. Set up all utility autocommands
--       setup_utility_autocmds()
--
--       -- 2. Set up the main LspAttach autocommand
--       vim.api.nvim_create_autocmd("LspAttach", {
--         group = lsp_lifecycle_augroup,
--         callback = on_lsp_attach,
--       })
--
--       -- 3. Get capabilities from cmp-nvim-lsp (IMPORTANT FOR AUTOCOMPLETION)
--       local capabilities = require("cmp_nvim_lsp").default_capabilities()
--
--       -- 4. Set up Mason-LSPConfig
--       local lspconfig = require("lspconfig")
--       require("mason-lspconfig").setup({
--         -- This handler function will be called for every server managed by Mason
--         handlers = {
--           function(server_name)
--             -- Set up each server with the defined capabilities
--             lspconfig[server_name].setup({
--               capabilities = capabilities,
--             })
--           end,
--
--           -- Example if you need specific customization for a server:
--           -- ["lua_ls"] = function()
--           --   lspconfig.lua_ls.setup({
--           --     capabilities = capabilities,
--           --     settings = {
--           --       Lua = { diagnostics = { globals = { "vim" } } },
--           --     },
--           --   })
--           -- end,
--         },
--       })
--     end,
--   },
-- }
