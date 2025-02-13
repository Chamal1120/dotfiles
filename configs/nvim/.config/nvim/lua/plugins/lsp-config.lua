return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"tailwindcss",
					"rust_analyzer",
					"clangd",
					"pylsp",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		lazy = false,
		opts = {
			servers = {
				html = {},
				cssls = {},
				jinja_lsp = {},
				lua_ls = {},
				ts_ls = {},
				bashls = {},
				clangd = {},
				tailwindcss = {},
				rust_analyzer = {},
				pylsp = {
					settings = {
						pylsp = {
							configurationSources = { "flake8" },
						},
					},
					on_new_config = function(config, root_dir)
						local venv_path = root_dir .. "/.venv/bin/python"
						if vim.fn.filereadable(venv_path) == 1 then
							config.cmd = { venv_path, "-m", "pylsp" }
						end
					end,
					root_dir = require("lspconfig.util").root_pattern(".venv", ".git"),
				},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local blink_cmp = require("blink.cmp")
			for server, config in pairs(opts.servers) do
				config.capabilities = blink_cmp.get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
			vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set({ "n" }, "<leader>rn", vim.lsp.buf.rename, {})

			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local ignored_patterns = { "HACK", "TODO", "FIXME" }
						for _, pattern in ipairs(ignored_patterns) do
							if diagnostic.message:match(pattern) then
								return nil -- Ignore these diagnostics
							end
						end
						return diagnostic.message
					end,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
	},
}
