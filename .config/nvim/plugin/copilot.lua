--local imap = require('tc.helpers.keymap').imap

vim.cmd [[imap <silent><script><expr> <C-K> copilot#Accept("\<CR>")]]
vim.g.copilot_no_tab_map = true
