local nmap = require('tc.helpers.keymap').nmap

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

nmap {
  "<leader>dn",
  function ()
    vim.diagnostic.goto_next(goto_opts)
  end,
}

nmap {
  "<leader>dp",
  function ()
    vim.diagnostic.goto_prev(goto_opts)
  end,
}

nmap {
  "<leader>sl",
  function ()
    vim.diagnostic.open_float(0, {
      scope = "line",
    })
  end,
}
