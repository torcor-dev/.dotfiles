lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,

    signs = true,

    underline = false,
  }
)
EOF

call sign_define("LspDiagnosticsSignError", {"text" : "", "texthl" : "RedSign"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "", "texthl" : "YellowSign"})
call sign_define("LspDiagnosticsSignInformation", {"text" : "", "texthl" : "BlueSign"})
call sign_define("LspDiagnosticsSignHint", {"text" : "", "texthl" : "AquaSign"})

hi! link LspDiagnosticsDefaultError Red
hi! link LspDiagnosticsDefaultWarning Yellow
hi! link LspDiagnosticsDefaultInformation Blue
hi! link LspDiagnosticsDefaultHint Aqua

autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
