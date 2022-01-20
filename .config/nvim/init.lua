if require('tc.first_load')() then
	return
end

vim.g.mapleader = ' '

require('tc.options')
require('tc.keymaps')
require('tc.au')
require('tc.plugins')
require('tc.lsp.lsp_installer')
