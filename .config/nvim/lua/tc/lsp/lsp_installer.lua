require("mason").setup()
local config = require("mason-lspconfig")
local lsp = require('tc.lsp')

config.setup {}
config.setup_handlers({
  function(server)
    require("lspconfig")[server].setup(lsp)
  end
})
