return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				require("none-ls.diagnostics.eslint_d"),
				null_ls.builtins.diagnostics.pylint.with({
          command = "/Users/randy99/miniconda/base/envs/my-venv/bin/pylint",
					diagnostics_postprocess = function(diagnostic)
						diagnostic.code = diagnostic.message_id
					end,
				}),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.blade_formatter,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
