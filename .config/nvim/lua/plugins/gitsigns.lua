return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { desc = "Jump to next git change" })

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { desc = "Jump to previous git change" })

      -- Actions
      map("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end)
      map("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end)
      map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git stage hunk" })
      map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git reset hunk" })
      map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git stage buffer" })
      map("n", "<leader>hu", gitsigns.stage_hunk, { desc = "git undo stage hunk" })
      map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git reset buffer" })
      map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git preview hunk" })
      map("n", "<leader>hb", gitsigns.blame_line, { desc = "git blame line" })
      map("n", "<leader>hd", gitsigns.diffthis, { desc = "git diff against index" })
      map("n", "<leader>hD", function()
        gitsigns.diffthis("@")
      end, { desc = "git diff against last commit" })

      -- Toggles
      map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "toggle git show blame line" })
      -- map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "toggle git show deleted" })
      map("n", "<leader>td", gitsigns.preview_hunk_inline, { desc = "toggle git show deleted" })
      map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "toggle git word diff" })
    end,
  },
}
