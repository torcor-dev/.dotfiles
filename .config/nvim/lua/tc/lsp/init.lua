local buf_imap = require('tc.helpers.keymap').buf_imap
local buf_nmap = require('tc.helpers.keymap').buf_nmap
local telescope = require('telescope.builtin')

local nvim_status = require('lsp-status')
local status = require('tc.lsp.status')
status.activate()



local doc_diagnostics = function()
  telescope.diagnostics({bufnr=0})
end

local ws_diagnostics = function()
  telescope.diagnostics()
end


local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local custom_attach = function(client)
  nvim_status.on_attach(client)

  buf_imap { '<c-s>', vim.lsp.buf.signature_help }
  buf_nmap { '<leader>cr', vim.lsp.buf.rename }
  buf_nmap { '<leader>ca', telescope.lsp_code_actions }

  buf_nmap { 'gd', vim.lsp.buf.definition }
  buf_nmap { 'gD', vim.lsp.buf.declaration }
  buf_nmap { 'gT', vim.lsp.buf.type_definition }

  buf_nmap { 'gr', telescope.lsp_references }
  buf_nmap { 'gI', telescope.lsp_implementations }
  buf_nmap { '<leader>fd', doc_diagnostics }
  buf_nmap { '<leader>fw', ws_diagnostics }

  buf_nmap { 'K', vim.lsp.buf.hover }

  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  if client.resolved_capabilities.code_lens and false then
    vim.cmd [[
      augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufEnter ++once         <buffer> lua require"vim.lsp.codelens".refresh()
        autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
      augroup END
    ]]
  end
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

return {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,
  flags = {
    debounce_text_changes = 50,
  }
}
