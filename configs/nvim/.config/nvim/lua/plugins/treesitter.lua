return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      highlight = {
        enable = true,
        disable = { "latex" },
        additional_vim_regex_highlighting = false
      },
      indent = { enable = true },
    })
  end,
}
