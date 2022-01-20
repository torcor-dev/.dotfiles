local nmap = require('tc.helpers.keymap').nmap
local _map = require('tc.helpers.keymap')._map
local fterm = require('FTerm')

_map {
  't',
  '<leader>tt',
  fterm.toggle,
}
nmap {
  '<leader>tt',
  fterm.toggle,
}
