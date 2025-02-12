return {
  "nvimtools/none-ls.nvim",
  lazy = false,
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      root_dir = require("null-ls.utils").root_pattern(".git", "package.json", ".null-ls-root"),
      sources = {
        null_ls.builtins.diagnostics.pylint.with({
          command = (function()
            local venv_pylint = vim.fn.getcwd() .. "/.venv/bin/pylint"
            if vim.fn.executable(venv_pylint) == 1 then
              return venv_pylint
            else
              return "pylint"
            end
          end)(),
        }),
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.djhtml,
        null_ls.builtins.diagnostics.cppcheck,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          command = "node_modules/.bin/prettier",
        }),
        null_ls.builtins.formatting.clang_format,
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
