return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        blink_cmp = true,
        copilot_vim = true,
        lsp_trouble = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
