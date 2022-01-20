local M = {}

M.imap = function(tbl)
  vim.keymap.set("i", tbl[1], tbl[2], tbl[3])
end

M.nmap = function(tbl)
  vim.keymap.set("n", tbl[1], tbl[2], tbl[3])
end

M._map = function (tbl)
  vim.keymap.set(tbl[1], tbl[2], tbl[3], tbl[4])
end


M.buf_nmap = function(opts)
  opts.buffer = 0
  M.nmap(opts)
end

M.buf_imap = function(opts)
  opts.buffer = 0
  M.imap(opts)
end

return M
