return {
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			"mfussenegger/nvim-dap-python", --optional
			{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
		},
		lazy = false,
		branch = "regexp", -- This is the regexp branch, use this for the new version
		config = function()
			require("venv-selector").setup({
				require("venv-selector").setup({
					settings = {
						search = {
							anaconda_base = {
								command = "fd /python$ /Users/randy99/miniconda/base/envs --full-path --color never -E /proc",
								type = "anaconda",
							},
						},
					},
				}),
			})
		end,
		keys = {
			{ "<Leader>vs", "<cmd>VenvSelect<cr>" },
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()
			require("dap-python").setup("/usr/local/Caskroom/miniconda/base/envs/my-venv/bin/python") -- Default Python path

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

			local keymap = vim.keymap

			-- Keybindings for nvim-dap
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

			-- Keybindings for nvim-dap-ui
			keymap.set("n", "<Leader>du", function()
				dapui.toggle()
			end, {})

			keymap.set("n", "<Leader>de", function()
				dapui.eval()
			end, {})
		end,
	},
}
