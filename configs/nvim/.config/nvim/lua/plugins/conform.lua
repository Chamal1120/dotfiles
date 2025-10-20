return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = { "rustfmt", lsp_format = "fallback" },
      -- Conform will run the first available formatter
      javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)

    -- Format with leader key
    vim.keymap.set("n", "<leader>gf", function()
      require("conform").format()
    end, { desc = "Format code with Conform" })
  end,
}
