return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  opts = function()
    local nvimbattery = {
      function()
        return require("battery").get_status_line()
      end,
    }

    return {
      theme = "catppuccin",
      options = {
        component_separators = " ",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype", nvimbattery },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    }
  end,
}
