--vim.cmd "luafile ~/.secrets/vimdbs.lua"

local nmap = require('tc.helpers.keymap').wk_nmap
local buf_nmap = require('tc.helpers.keymap').wk_buf_nmap

local function db_select()
  vim.cmd "below new"
  vim.api.nvim_win_set_height(0, 10)
  vim.opt_local.buftype = "nofile"
  vim.opt_local.bufhidden = "delete"
  vim.opt_local.swapfile = false
  vim.opt_local.buflisted = false
  vim.api.nvim_buf_set_lines(0, 0, -1, true, {"========Databases========"})
  local lines = {}
  for _, db in pairs(vim.g.dbs) do
    table.insert(lines, string.format("%s\t%s", db.name, db.host))
  end
  print(lines)
  vim.api.nvim_buf_set_lines(0, -1, -1, true, lines)
  vim.opt_local.readonly = true
  buf_nmap({keys='gq', action=':bdelete<CR>', opts={silent = true}})
end

local function db_exec_line()
  local line = vim.api.nvim_get_current_line()
  local cmd = string.format("DB %s %s", vim.g.db, line)
  vim.cmd(cmd)
end

local function db_exec_sel()
  local start = vim.fn.getpos('v')
  local end_ = vim.fn.getcurpos()
  local lines = vim.api.nvim_buf_get_lines(0, start[2]-1, end_[2], false)
  local cmd = string.format("DB %s %s", vim.g.db, table.concat(lines, ' '))
  vim.cmd(cmd)
end

nmap({keys='<leader>dx', action=db_select, name="Select database", tag="[DB]", opts={mode="n"}})
nmap({keys='<leader>db', action=db_exec_line, name="Execute current line", tag="[DB]", opts={mode="n"}})
nmap({keys='<leader>db', action=db_exec_sel, name="Execute current selection", tag="[DB]", opts={mode="v"}})
