local trouble = require("trouble")
trouble.setup()

local nmap = require("tc.helpers.keymap").nmap

nmap {"<leader>xx", trouble.toggle }
