return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			root_dir = require("null-ls.utils").root_pattern(".git", "package.json", ".null-ls-root"),
			sources = {
				require("none-ls.diagnostics.eslint_d").with({
					command = "node_modules/.bin/eslint_d",
				}),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.prettier.with({
					command = "node_modules/.bin/prettier",
				}),
				null_ls.builtins.formatting.clang_format,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
