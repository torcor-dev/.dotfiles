local ok, neogit = pcall(require, "neogit")
if not ok then
	return
end
local nmap = require("tc.helpers.keymap").wk_nmap

neogit.setup({
	integrations = {
		diffview = true,
	},
})

local TAG = "[Git]"
nmap({
	keys = "<leader>gd",
	action = function()
		vim.cmd(":DiffviewOpen")
	end,
	name = "Diff View",
	tag = TAG,
})
nmap({
	keys = "<leader>gh",
	action = function()
		vim.cmd(":DiffviewFileHistory")
	end,
	name = "Diff History",
	tag = TAG,
})
nmap({ keys = "<leader>gs", action = neogit.open, name = "Status", tag = TAG })
nmap({
	keys = "<leader>gc",
	action = function()
		neogit.open({ "commit" })
	end,
	name = "Commit",
	tag = TAG,
})
