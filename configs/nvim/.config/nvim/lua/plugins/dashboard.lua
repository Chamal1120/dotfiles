return {
  "nvimdev/dashboard-nvim",
  lazy = false,
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      theme = "hyper",
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          {
            desc = " Apps",
            group = "DiagnosticHint",
            action = "Telescope app",
            key = "a",
          },
          {
            desc = " dotfiles",
            group = "Number",
            action = "Telescope dotfiles",
            key = "d",
          },
        },
        project = {
          enable = true,
          limit = 4,
          label = "Can't think of? Continue one from here,",
          action = "Telescope find_files cwd=",
        },
        mru = {
          enable = false,
          cwd_only = false,
        },
        footer = { "Hello Chamal 👋, Let's Code!" },
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
