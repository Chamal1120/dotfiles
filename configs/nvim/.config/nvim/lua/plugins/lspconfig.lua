local lsp_on_attach = require("lsp.on_attach").on_attach

return {
	{
		"williamboman/mason.nvim",
		lazy = "Verylazy",
		config = function()
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				}
			})
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
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							diagnostics = {
								globals = { "vim" }, -- recognize `vim` as global
							},
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true), -- Neovim runtime files
								checkThirdParty = false,
							},
							format = {
								enable = true, -- enable formatting
								indent_style = "space", -- use spaces
								indent_size = 4, -- 2 spaces per indent
								continuation_indent = 4, -- for wrapped lines
							},
						},
					},

				},
				-- hls = {},
				html = {},
				cssls = {},
				ts_ls = {},
				tailwindcss = {},
				bashls = {},
				-- jinja_lsp = {},
				clangd = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							imports = {
								granularity = {
									group = "module",
								},
								prefix = "self",
							},
							cargo = {
								buildScripts = {
									enable = true,
								},
							},
							procMacro = {
								enable = true,
							},
							rustfmt = {
								extraArgs = { "--config", "tab_spaces=2" },
							},
						},
					},
				},
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
		--
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local blink_cmp = require("blink.cmp")

			-- Setup servers
			for server, config in pairs(opts.servers) do
				config.capabilities = blink_cmp.get_lsp_capabilities(config.capabilities)
				config.on_attach = lsp_on_attach
				lspconfig[server].setup(config)
			end
		end,

	},
}
