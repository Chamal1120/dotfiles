return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      color_overrides = {
        mocha = {
          mantle = "#1e1e2e",
          base = "#181825"
        },
      },
      flavour = "mocha",
      transparent_background = false,
      no_italic = false,    -- Force no italic
      no_bold = false,      -- Force no bold
      no_underline = false, -- Force no underline
      integrations = {
        blink_cmp = true,
        copilot_vim = true,
        treesitter = true,
        lsp_trouble = true,
        gitsigns = true,
        mason = true,
        telescope = {
          enabled = true,
        },
        indent_blankline = {
          enabled = true,
          scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        },
        dropbar = {
          enabled = false,
          color_mode = false, -- enable color for kind's texts, not just kind's icons
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
