-- Configure LSP clients

-- Set default root markers for all clients
vim.lsp.config('*', {
  root_markers = { '.git' },
})

-- List of LSPs
local servers = {
  ts_ls = {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  },
  lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        telemetry = { enable = false },
      },
    },
  },
  html = {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html' },
  },
  tailwindcss = {
    cmd = {'tailwindcss-language-server', '--stdio'},
    filetypes = { 'html', 'razor', 'tsx', 'jsx' },
  },
  rust_analyzer = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
  },
  jtdls = {},
}

-- Enable the LSPs
for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end

-- Setup buffer-local LSP keymaps on attach
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf

    -- Clear unwanted defaults
    vim.bo[bufnr].formatexpr = nil
    vim.bo[bufnr].omnifunc = nil

    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Go to definition
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- Hover documentation
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- Rename symbol
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    -- Code actions
    vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, opts)
    -- Show references
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- Implementation
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- Type definition
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    -- Signature help
    vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts)
    -- Diagnostics
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  end,
})
