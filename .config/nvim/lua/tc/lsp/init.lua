local buf_imap = require("tc.helpers.keymap").buf_imap
local buf_nmap = require("tc.helpers.keymap").wk_buf_nmap
local telescope = require("telescope.builtin")

local doc_diagnostics = function()
	telescope.diagnostics({ bufnr = 0 })
end

local ws_diagnostics = function()
	telescope.diagnostics()
end

local custom_init = function(client)
	client.config.flags = client.config.flags or {}
	client.config.flags.allow_incremental_sync = true
end

local TAG = "[LSP]"

local custom_attach = function(client)
	buf_imap({ "<c-s>", vim.lsp.buf.signature_help })

	buf_nmap({ keys = "<leader>cr", action = vim.lsp.buf.rename, name = "Rename", tag = TAG })
	buf_nmap({ keys = "<leader>cf", action = vim.lsp.buf.format, name = "Format buffer", tag = TAG })
	--buf_nmap { keys='<leader>cb', action=telescope.lsp_code_actions, name="Code actions", tag=TAG }
	buf_nmap({ keys = "<leader>ca", action = vim.lsp.buf.code_action, name = "Code actions", tag = TAG })

	buf_nmap({ keys = "gd", action = vim.lsp.buf.definition, name = "Go to definition", tag = TAG })
	buf_nmap({ keys = "gD", action = vim.lsp.buf.declaration, name = "Go to declaration", tag = TAG })
	buf_nmap({ keys = "gT", action = vim.lsp.buf.type_definition, name = "Go to type definition", tag = TAG })

	buf_nmap({ keys = "gr", action = telescope.lsp_references, name = "Go to references", tag = TAG })
	buf_nmap({ keys = "gI", action = telescope.lsp_implementations, name = "Go to implementations", tag = TAG })
	buf_nmap({ keys = "<leader>fd", action = doc_diagnostics, name = "Document diagnostics", tag = TAG })
	buf_nmap({ keys = "<leader>fw", action = ws_diagnostics, name = "Workspace diagnostics", tag = TAG })
	buf_nmap({ keys = "]d", action = vim.diagnostic.goto_next, name = "Go to next diagnostic", tag = TAG })
	buf_nmap({ keys = "[d", action = vim.diagnostic.goto_prev, name = "Go to previous diagnostic", tag = TAG })

	buf_nmap({ keys = "K", action = vim.lsp.buf.hover, name = "Help", tag = TAG })

	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.cmd([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
	end

	if client.server_capabilities.code_lens and false then
		vim.cmd([[
      augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufEnter ++once         <buffer> lua require"vim.lsp.codelens".refresh()
        autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
      augroup END
    ]])
	end
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").default_capabilities(updated_capabilities)

return {
	on_init = custom_init,
	on_attach = custom_attach,
	capabilities = updated_capabilities,
	flags = {
		debounce_text_changes = 50,
	},
}
