return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- Register custom parser for ballerina grammar
    --local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    --parser_config.ballerina = {
    --  install_info = {
    --    url = "https://github.com/heshanpadmasiri/tree-sitter-ballerina/",
    --    files = { "src/parser.c" },
    --    branch = "module-level-defns",
    --    generate_requires_npm = false,
    --    requires_generate_from_grammar = false,
    --  },
    --  filetype = "ballerina",
    --}

    -- treesitter configs
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      highlight = {
        enable = true,
        -- disable slow treesitter highlight for large files
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end,
}
