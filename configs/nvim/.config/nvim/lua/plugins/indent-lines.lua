return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
  --@module "ibl"
  --@type ibl.config
	opts = {
		exclude = {
			filetypes = { "dashboard", "alpha", "startify", "NvimTree", "help" },
			buftypes = { "nofile", "terminal" },
		},
	},
	config = function(_, opts)
		require("ibl").setup(opts)
	end,
}
