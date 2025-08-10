return {
  "stevearc/oil.nvim",
  lazy = false,
  ---@module 'oil'
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    local oil = require("oil")
    oil.setup({
      skip_confirm_for_simple_edits = true,
      hide_dotfiles = false,
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 2,
        border = "single",
      },
      confirmation = {
        border = "single",
      }
    })
    vim.keymap.set("n", "_", oil.toggle_float, {})
  end,
}
