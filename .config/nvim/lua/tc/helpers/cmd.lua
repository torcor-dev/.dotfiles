M = {}

M.add_cmd = function (name, callback, opts)
  opts = opts or {}
  vim.api.nvim_create_user_command(name, callback, opts)
end

return M
