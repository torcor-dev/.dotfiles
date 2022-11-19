local wk_loaded, wk = pcall(require, 'which-key')

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

local function name(mapping)
  local n = mapping.name or "UNKNOWN"
  local tag = mapping.tag
  if tag then
    return n .. " " .. tag
  end
  return n

end

local function register(mapping)
  wk.register({
    [mapping.keys] = { mapping.action, name(mapping)}
  }, mapping.opts)
end

M.wk_nmap = function(mapping)
  if not wk_loaded then
    M.nmap({mapping.keys, mapping.action, mapping.opts})
    return
  end
  register(mapping)
end

M.wk_buf_nmap = function(mapping)
  if not wk_loaded then
    M.buf_nmap({mapping.keys, mapping.action, mapping.opts})
    return
  end

  if mapping.opts == nil then
    mapping.opts = {}
  end

  mapping.opts.buffer = 0
  register(mapping)
end

M.wk_map = function(modes, mapping)
  for _, m in pairs(modes) do
    mapping.opts = { mode = m }
    if wk_loaded then
      register(mapping)
    else
      M._map({mapping.keys, mapping.action, mapping.opts})
    end
  end
end

return M
