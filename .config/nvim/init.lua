_G.vim = vim

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.mouse = "a"
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 200
vim.opt.timeoutlen = 250
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "move to top window" })
vim.keymap.set("n", "<Tab>", "<cmd>bn<CR>", { desc = "next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bp<CR>", { desc = "previous buffer" })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ import = "plugins" })

-- odoo setup

-- lsp-zero stanza
local lsp = require("lsp-zero").preset({})
lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

local lspconfigs = require("lspconfig.configs")

-- define our custom language server here
lspconfigs.odoo_lsp = {
  default_config = {
    name = "odoo-lsp",
    cmd = { "odoo-lsp" },
    filetypes = { "javascript", "xml", "python" },
    root_dir = require("lspconfig.util").root_pattern(".odoo_lsp", ".odoo_lsp.json", ".git"),
  },
}

local configured_lsps = {
  odoo_lsp = {},
  -- optional but recommended, requires pyright-langserver on path
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
  -- pyright = {},
  -- optional, this is the same LSP used by VSCode for XML
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lemminx
  -- lemminx = {},
  -- optional, use `odoo-lsp tsconfig` to generate a tsconfig.json
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
  -- tsserver = {},
}

local lspconfig = require("lspconfig")
for name, config in pairs(configured_lsps) do
  lspconfig[name].setup(config)
end

-- setup tab-completion
-- local cmp_action = require("lsp-zero").cmp_action()
-- require("cmp").setup({
--   mapping = {
--     ["<Tab>"] = cmp_action.luasnip_supertab(),
--     ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
--   },
-- })
