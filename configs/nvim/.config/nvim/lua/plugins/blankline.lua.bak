return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = false,
  main = "ibl",
  --@module "ibl"
  --@type ibl.config
  opts = {
    indent = {
      char = "▏",
    },
    exclude = {
      filetypes = { "dashboard", "alpha", "startify", "NvimTree", "help" },
      buftypes = { "nofile", "terminal" },
    },
  },
  config = function(_, opts)
    require("ibl").setup(opts)
  end,
}
