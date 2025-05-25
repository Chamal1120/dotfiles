return {
  "kiyoon/jupynium.nvim",
  build = "uv pip install . --python=$HOME/.virtualenvs/jupynium/bin/python",
  dependancies = {
    "rcarriga/nvim-notify",     -- optional
    "stevearc/dressing.nvim",   -- optional, UI for :JupyniumKernelSelect
  },
}
