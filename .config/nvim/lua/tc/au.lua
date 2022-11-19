local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighlightYank", {})
local fmt_onsave_group = augroup("FmtOnSave", {})
-- 22016534327
-- compile Packer file automatically
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 100,
		})
	end,
})

autocmd("BufWritePre", {
	group = fmt_onsave_group,
	pattern = { "*.go", "*.lua", "*tsx", "*.ts" },
	callback = function()
		vim.lsp.buf.format()
	end,
})
