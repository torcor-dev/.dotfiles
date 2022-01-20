M = {}

M.add_cmd = function (name, callback, opts)
  opts = opts or {}
  vim.api.nvim_add_user_command(name, callback, opts)
end

return M
