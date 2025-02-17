return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      -- Helper function to dynamically resolve the Python path
      local function get_python_venv()
        local cwd = vim.fn.getcwd()
        local python_path = cwd .. "/.venv/bin/python"
        if vim.fn.filereadable(python_path) == 1 then
          return python_path
        else
          return "python" -- Fallback to system Python
        end
      end

      -- DAP setup
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      require("dap-python").setup(get_python_venv())

      dap.adapters.python = {
        type = "executable",
        command = get_python_venv(), -- Dynamic path to Python interpreter
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",     -- This runs the current file
          pythonPath = get_python_venv, -- Dynamically resolved Python path
        },
      }

      -- Auto-open and close dap-ui
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

      -- Keybindings for debugging
      local keymap = vim.keymap

      keymap.set("n", "<Leader>dt", function()
        require("dap").toggle_breakpoint()
      end, {})

      keymap.set("n", "<Leader>dc", function()
        require("dap").continue()
      end, {})

      keymap.set("n", "<Leader>ds", function()
        require("dap").step_over()
      end, {})

      keymap.set("n", "<Leader>di", function()
        require("dap").step_into()
      end, {})

      keymap.set("n", "<Leader>do", function()
        require("dap").step_out()
      end, {})

      keymap.set("n", "<Leader>dr", function()
        require("dap").repl.open()
      end, {})

      keymap.set("n", "<Leader>dl", function()
        require("dap").run_last()
      end, {})

      -- Keybindings for dap-ui
      keymap.set("n", "<Leader>du", function()
        dapui.toggle()
      end, {})

      keymap.set("n", "<Leader>de", function()
        dapui.eval()
      end, {})
    end,
  },
}
