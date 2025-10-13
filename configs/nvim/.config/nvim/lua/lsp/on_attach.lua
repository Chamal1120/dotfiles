local M = {}

M.on_attach = function(client, bufnr)
    local map = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
    end

    -- LSP keymaps
    map("n", "K", vim.lsp.buf.hover)
    map("n", "<leader>gd", vim.lsp.buf.definition)
    map("n", "<leader>gr", vim.lsp.buf.references)
    map("n", "<leader>gf", vim.lsp.buf.format)
    map("n", "<leader>ca", vim.lsp.buf.code_action)
    map("n", "<leader>rn", vim.lsp.buf.rename)
    map("n", "<leader>cl", vim.lsp.codelens.run)

    -- Enable CodeLens auto-refresh
    -- if client.server_capabilities.codeLensProvider then
    --     vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
    --         buffer = bufnr,
    --         callback = vim.lsp.codelens.refresh,
    --     })
    --     vim.lsp.codelens.refresh()
    -- end
end

return M
