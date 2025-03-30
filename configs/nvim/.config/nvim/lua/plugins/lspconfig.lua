return {
	{
		"williamboman/mason.nvim",
		lazy = "VeryLazy",
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
					"jinja_lsp",
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
							plugins = {
								pycodestyle = {
									enabled = true,
									ignore = { "W391", "E501" },
									maxLineLength = 100,
								},
								pylint = {
									enabled = false,
								},
								flake8 = {
									enabled = false,
								},
							},
						},
					},
				},
			},
		},
		--		config = function(_, opts)
		--			local lspconfig = require("lspconfig")
		--			local blink_cmp = require("blink.cmp")
		--
		--			for server, config in pairs(opts.servers) do
		--				config.capabilities =
		--					vim.tbl_deep_extend("force", blink_cmp.get_lsp_capabilities(), config.capabilities or {})
		--				lspconfig[server].setup(config)
		--			end
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				-- `opts[server].capabilities, if you've defined it
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end
			local map = vim.keymap.set
			map("n", "K", vim.lsp.buf.hover, {})
			map("n", "<leader>gd", vim.lsp.buf.definition, {})
			map("n", "<leader>gr", vim.lsp.buf.references, {})
			map("n", "<leader>gf", vim.lsp.buf.format, {})
			map("n", "<leader>ca", vim.lsp.buf.code_action, {})
			map("n", "<leader>rn", vim.lsp.buf.rename, {})
		end,
	},
}
