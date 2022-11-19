local nmap = require('tc.helpers.keymap').wk_nmap

vim.diagnostic.config {
  underline = true,
  virtual_text = {
    severity = nil,
    source = "if_many",
    format = nil,
  },
  signs = true,

  -- options for floating windows:
  float = {
    show_header = true,
  },

  -- general purpose
  severity_sort = true,
  update_in_insert = false,
}

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local goto_opts = {
  wrap = true,
  float = true,
}

local TAG = "Diagnostic"

nmap {
  keys="<leader>dn",
  action=function ()
    vim.diagnostic.goto_next(goto_opts)
  end,
  name="Diagnostic: Next",
  tag=TAG,
}

nmap {
  keys="<leader>dp",
  action=function ()
    vim.diagnostic.goto_prev(goto_opts)
  end,
  name="Diagnostic: Prev",
  tag=TAG,
}

nmap {
  keys="<leader>dl",
  action=function ()
    vim.diagnostic.open_float(0, {
      scope = "line",
    })
  end,
  name="Diagnostic: Line",
  tag=TAG,
}
