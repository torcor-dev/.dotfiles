local buf_nmap = require('tc.helpers.keymap').buf_nmap

vim.opt_local.spell = true
buf_nmap { "j", "gj" }
buf_nmap { "k", "gk" }
