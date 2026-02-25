return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",
    -- Required dependency for nvim-dap-ui
    "nvim-neotest/nvim-nio",
    -- Configuration for go
    "leoluz/nvim-dap-go",
    -- Integration with mason
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup mason-nvim-dap to ensure delve is installed
    require("mason-nvim-dap").setup({
      ensure_installed = { "delve" },
      handlers = {},
    })

    -- Setup dap-ui
    dapui.setup()

    -- Setup dap-go
    require("dap-go").setup()

    -- Open and close dap-ui automatically
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Key mappings for dap
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })

    -- Additional configuration for Go debugging
    table.insert(dap.configurations.go, {
      type = "go",
      name = "Debug (cmd/api)",
      request = "launch",
      program = "${workspaceFolder}/cmd/api",
    })
  end,
}
