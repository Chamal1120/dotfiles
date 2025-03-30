return {
	"nvimtools/none-ls.nvim",
	lazy = false,
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			root_dir = require("null-ls.utils").root_pattern(".git", "package.json", ".null-ls-root"),
			sources = {
				null_ls.builtins.formatting.djhtml,
				null_ls.builtins.diagnostics.cppcheck,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.yamlfmt,
				null_ls.builtins.formatting.prettier.with({
					command = "node_modules/.bin/prettier",
				}),
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.black.with({
					command = ".venv/bin/black",
				}),
			},
		})
		--    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		vim.keymap.set("n", "<leader>gf", function()
			vim.lsp.buf.format({ timeout_ms = 5000 }) -- Increase timeout to 5 seconds
		end, { desc = "Format code with LSP" })
	end,
}
