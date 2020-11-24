local lsp = require'lspconfig'

local map = function(type, key, value)
	vim.fn.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end


local custom_attach = function(client)
	print("LSP started.");
	require'completion'.on_attach(client)

	map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
	map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
	map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
	map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
	map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
	map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
	map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
	map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
	map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
	map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
	map('n','<leader>ca','<cmd>lua vim.lsp.buf.code_action()<CR>')
	map('n','<leader>ee','<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
	map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
	map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
	map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
	map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
end

lsp.tsserver.setup{on_attach=custom_attach}

lsp.pyls_ms.setup{
    on_attach=custom_attach,
    settings = {
        python = {
            formatting = {
                provider = { "black" },
                blackPath = { "black" }
            },
            linting = {
                enabled = { true },
                pylint = {
                    pylintEnabled = { false },
                },
                flake8 = {
                    flake8Enabled = { true },
                    flake8Path = { "flake8" }
                }
            },
            analysis = {
                warnings = { "unknown-parameter-name" },
                disabled = { "too-many-function-arguments", "parameter-missing" },
                errors = { "undefined-variable"  },
                info = { "unresolved-import" }
            }
        }
    }
}


-- pyls = {
--     configurationSources={enum={"pylint"},type="string"},
--     plugins = {
--         pycodestyle = { enabled=true },
--         pyflakes = { enabled=true },
--         pylint = { enabled=true }
--     }
-- },

lsp.intelephense.setup {
    on_attach=custom_attach
}

lsp.jsonls.setup {
    on_attach=custom_attach
}

lsp.jdtls.setup {
    on_attach=custom_attach
}

lsp.sumneko_lua.setup{
	on_attach=custom_attach,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
			completion = { keywordSnippet = "Disable", },
			diagnostics = { enable = true, globals = {
				"vim", "describe", "it", "before_each", "after_each" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				}
			}
		}
	}
}


lsp.diagnosticls.setup {
    filetypes = {"javascript", "typescript"},
    init_options = {
        linters = {
            eslint = {
                command = "./node_modules/.bin/eslint",
                rootPatterns = {".git"},
                debounce = 100,
                args = {
                    "--stdin",
                    "--stdin-filename",
                    "%filepath",
                    "--format",
                    "json"
                },
                sourceName = "eslint",
                parseJson = {
                    errorsRoot = "[0].messages",
                    line = "line",
                    column = "column",
                    endLine = "endLine",
                    endColumn = "endColumn",
                    message = "${message} [${ruleId}]",
                    security = "severity"
                },
                securities = {
                    [2] = "error",
                    [1] = "warning"
                }
            },
            filetypes = {
                javascript = "eslint",
                typescript = "eslint"
            }
        }
    }
}
