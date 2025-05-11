local config = {
    cmd = {'/home/randy99/.local/share/nvim/mason/packages/jdtls/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    settings = {
    java = {
      project = {
        sourcePaths = { '.' }
      }
    }
  }
}
require('jdtls').start_or_attach(config)
