-- utils/lsp.lua
local M = {}

function M.lsp_name()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    return ""
  end
  return "  " .. table.concat(
    vim.tbl_map(function(client)
      return client.name
    end, clients),
    ", "
  )
end

return M
