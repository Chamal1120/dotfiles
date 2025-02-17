return {
  "d-vegapunk/live-server.nvim",
  lazy = true,
  cmd = { "LiveServerStart" },
  build = "npm install -g live-server",
  config = function()
    require("live-server").setup({
      liveserver_args = {
        "--port=3621",
        "--no-css-inject",
      },
    })
  end,
}
