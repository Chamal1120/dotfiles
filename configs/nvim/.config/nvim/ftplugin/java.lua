local home = vim.fn.expand("~")
local lsp_on_attach = require("lsp.on_attach").on_attach
local blink_cmp = require("blink.cmp")

local bundles = {
  vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1)
}

local config = {
  cmd = { home .. '/.local/share/nvim/mason/packages/jdtls/jdtls' },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  capabilities = blink_cmp.get_lsp_capabilities(),
  on_attach = lsp_on_attach,
  settings = {
    java = {
      project = {
        sourcePaths = { '.' }
      }
    }
  },
  init_options = {
    bundles = bundles
  }
}


require('jdtls').start_or_attach(config)
