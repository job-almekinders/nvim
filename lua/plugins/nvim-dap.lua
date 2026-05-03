-- debugger
return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "d?",
        function()
          require("dapui").eval(nil, { enter = true })
        end,
        desc = "Debugger: Eval under cursor",
      },
      {
        "<leader>db",
        function()
          require("persistent-breakpoints.api").toggle_breakpoint()
        end,
        desc = "[D]ebugger: Toggle [B]reakpoint",
      },
      {
        "<leader>dx",
        function()
          require("persistent-breakpoints.api").clear_all_breakpoints()
        end,
        desc = "[D]ebugger: Clear All Breakpoints",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "[D]ebugger: [C]ontinue",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "[D]ebugger: Step [O]ver",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "[D]ebugger: Step [I]nto",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "[D]ebugger: Step [O]ut",
      },
      {
        "<leader>dq",
        function()
          require("dap").terminate()
        end,
        desc = "[D]ebugger: [Q]uit / Terminate",
      },
      {
        "<leader>dui",
        function()
          require("dapui").toggle()
        end,
        desc = "[D]ebugger: Toggle [UI]",
      },
      {
        "<leader>dtm",
        function()
          require("dap-python").test_method()
        end,
        desc = "[D]ebugger: Debug [T]est [M]ethod",
      },
      {
        "<leader>dtc",
        function()
          require("dap-python").test_class()
        end,
        desc = "[D]ebugger: Debug [T]est [C]lass",
      },
      {
        "<leader>df",
        function()
          require("dap-python").debug_file()
        end,
        desc = "[D]ebugger: Debug [F]ile",
      },
    },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
      {
        "Weissle/persistent-breakpoints.nvim",
        config = function()
          require("persistent-breakpoints").setup({
            load_breakpoints_event = { "BufReadPost" },
          })
        end,
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_python = require("dap-python")

      require("dapui").setup({})
      require("nvim-dap-virtual-text").setup({
        commented = true, -- Show virtual text alongside comment
      })

      -- Installed debugpy with pipx and use this to launch debugger.
      -- This ensures that we do not have to install debugpy in each venv.
      dap_python.setup("~/.local/pipx/venvs/debugpy/bin/python")

      dap_python.test_runner = "pytest"

      vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapBreakpointRejected", {
        text = "", -- or "❌"
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapStopped", {
        text = "", -- or "→"
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
      })

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
    end,
  },
}
