return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  opts = {
    keymap = { preset = "default" },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    -- Disable for some filetypes
    enabled = function()
      return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
          and vim.bo.buftype ~= "prompt"
          and vim.b.completion ~= false
    end,
    completion = {
      menu = {
        -- draw = {
        --   columns = { { "label", "label_description", gap = 1 }, { "kind" } },
        -- },
        draw = {
          -- We don't need label_description now because label and label_description are already
          -- combined together in label by colorful-menu.nvim.
          columns = {
            { "kind_icon" }, 
            { "label", gap = 1 },
            {"kind"},
          },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
      ghost_text = { enabled = false },
    },
    cmdline = {
      sources = {},
    },
  },
  opts_extend = { "sources.default" },
}
