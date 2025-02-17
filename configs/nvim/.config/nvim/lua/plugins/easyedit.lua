return {
  "Chamal1120/easyedit.nvim",
  lazy = true,
  cmd = "WR",
  config = function()
    require("easyedit").setup()
  end,
}
