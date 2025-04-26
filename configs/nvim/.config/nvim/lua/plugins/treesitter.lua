return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- Register custom parser for ballerina grammar
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.ballerina = {
      install_info = {
        url = "~/custom-treesitter-grammar/tree-sitter-ballerina",
        files = { "src/parser.c" },
        generate_requires_npm = false,
      },
      filetype = "ballerina",
    }

    -- treesitter configs
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      highlight = {
        enable = true,
        disable = { "latex" },
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end,
}
