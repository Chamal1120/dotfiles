return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",

    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup({
        options = {
            diagnostics = "nvim_lsp",
        }
      })

      vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

      for i = 1, 9 do
        vim.api.nvim_set_keymap(
          "n",
          "<leader>" .. i,
          ":BufferLineGoToBuffer " .. i .. "<CR>",
          { noremap = true, silent = true }
        )
      end
    end,
  },
}
