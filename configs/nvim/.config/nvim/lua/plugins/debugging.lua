return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
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

      -- .NET helper functions
      vim.g.dotnet_build_project = function()
        local default_path = vim.fn.getcwd() .. '/'
        if vim.g['dotnet_last_proj_path'] ~= nil then
          default_path = vim.g['dotnet_last_proj_path']
        end
        local path = vim.fn.input('Path to your *proj file', default_path, 'file')
        vim.g['dotnet_last_proj_path'] = path
        local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
        print('')
        print('Cmd to execute: ' .. cmd)
        local f = os.execute(cmd)
        if f == 0 then
          print('\nBuild: ✔️ ')
        else
          print('\nBuild: ❌ (code: ' .. f .. ')')
        end
      end

      vim.g.dotnet_get_dll_path = function()
        local request = function()
          return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end

        if vim.g['dotnet_last_dll_path'] == nil then
          vim.g['dotnet_last_dll_path'] = request()
        else
          if vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
            vim.g['dotnet_last_dll_path'] = request()
          end
        end

        return vim.g['dotnet_last_dll_path']
      end

      -- DAP setup
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes",      size = 0.65 },
              { id = "watches",     size = 0.15 },
              { id = "breakpoints", size = 0.1 },
              { id = "stacks",      size = 0.1 },
            },
            size = 30,          --total width in columns
            position = "right", -- can be left or right
          },
          {
            elements = {
              "repl",
            },
            size = 0.25,
            position = "bottom",
          },
        },
      })

      -- Python debugging
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
          program = "${file}",          -- This runs the current file
          pythonPath = get_python_venv, -- Dynamically resolved Python path
        },
      }

      -- .NET debugging setup
      dap.adapters.coreclr = {
        type = 'executable',
        command = 'netcoredbg',
        args = { '--interpreter=vscode' }
      }

      -- .NET build function
      local function build_dotnet_project()
        -- Try to find project file automatically first
        local cwd = vim.fn.getcwd()
        local proj_files = vim.fn.glob(cwd .. "/*.csproj", false, true)
        local proj_path = nil

        if #proj_files == 1 then
          -- Found exactly one project file, use it
          proj_path = proj_files[1]
          print("Auto-detected project: " .. vim.fn.fnamemodify(proj_path, ":t"))
        elseif #proj_files > 1 then
          -- Multiple project files, use stored path or ask
          if vim.g['dotnet_last_proj_path'] ~= nil then
            proj_path = vim.g['dotnet_last_proj_path']
            print("Using stored project: " .. vim.fn.fnamemodify(proj_path, ":t"))
          else
            print("Multiple project files found, please specify:")
            for i, file in ipairs(proj_files) do
              print(i .. ". " .. vim.fn.fnamemodify(file, ":t"))
            end
            local default_path = proj_files[1]
            proj_path = vim.fn.input('Path to your *proj file: ', default_path, 'file')
            vim.g['dotnet_last_proj_path'] = proj_path
          end
        else
          -- No project files found, ask user or use stored
          local default_path = vim.g['dotnet_last_proj_path'] or (cwd .. '/')
          proj_path = vim.fn.input('Path to your *proj file: ', default_path, 'file')
          vim.g['dotnet_last_proj_path'] = proj_path
        end

        local cmd = 'dotnet build -c Debug ' .. proj_path
        print('Building: ' .. vim.fn.fnamemodify(proj_path, ":t"))
        local result = os.execute(cmd .. ' > /dev/null 2>&1')
        if result == 0 then
          print('✅ Build successful')
        else
          print('❌ Build failed (code: ' .. result .. ')')
        end
      end

      -- Function to find the DLL automatically
      local function find_dll_path()
        local cwd = vim.fn.getcwd()
        -- Look for any .dll in bin/Debug/net*/
        local glob_pattern = cwd .. "/bin/Debug/net*/*.dll"
        local dll_files = vim.fn.glob(glob_pattern, false, true)

        if #dll_files > 0 then
          -- Return the first DLL found (usually there's only one)
          return dll_files[1]
        else
          -- Fallback: try to guess from project file
          local proj_files = vim.fn.glob(cwd .. "/*.csproj", false, true)
          if #proj_files > 0 then
            local proj_name = vim.fn.fnamemodify(proj_files[1], ":t:r") -- Get filename without extension
            -- Try common target frameworks
            local common_frameworks = { "net9.0", "net8.0", "net6.0", "net7.0" }
            for _, fw in ipairs(common_frameworks) do
              local dll_path = cwd .. "/bin/Debug/" .. fw .. "/" .. proj_name .. ".dll"
              if vim.fn.filereadable(dll_path) == 1 then
                return dll_path
              end
            end
          end
          return nil
        end
      end

      local dotnet_config = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            local dll_path = find_dll_path()
            if dll_path then
              print("Auto-detected DLL: " .. dll_path)
              return dll_path
            else
              print("Could not find DLL. Make sure project is built.")
              return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
            end
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = false,
          console = "integratedTerminal",
        },
      }

      -- Create build command
      vim.api.nvim_create_user_command('DapSetupDotnet', build_dotnet_project,
        { desc = 'Build .NET project (asks for project path)' })

      dap.configurations.cs = dotnet_config
      dap.configurations.fsharp = dotnet_config

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
      vim.keymap.set("n", "<Leader>aw", function()
        local var = vim.fn.expand("<cword>")
        require("dapui").elements.watches.add(var)
        print("Added watch: " .. var)
      end, {})

      -- Optional: Add keybinding for .NET build (as suggested in the original config)
      keymap.set('n', '<C-b>', ':lua vim.g.dotnet_build_project()<CR>', { noremap = true, silent = true })
    end,
  },
}
