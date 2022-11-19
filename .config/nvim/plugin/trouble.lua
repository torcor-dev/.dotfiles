local trouble = require("trouble")
trouble.setup()

local nmap = require("tc.helpers.keymap").wk_nmap

nmap { keys="<leader>xx", action=trouble.toggle, name="Trouble", tag="Diagnostics" }
