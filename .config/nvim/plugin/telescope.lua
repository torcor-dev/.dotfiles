require("telescope").setup({
	defaults = {
		results_title = false,

		sorting_strategy = "ascending",
		layout_strategy = "center",
		layout_config = {
			preview_cutoff = 1, -- Preview should always show (unless previewer = false)

			width = function(_, max_columns, _)
				return math.min(max_columns, 80)
			end,

			height = function(_, _, max_lines)
				return math.min(max_lines, 25)
			end,
		},

		border = true,
		borderchars = {
			prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
			results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
			preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		},
	},
})

local builtin = require("telescope.builtin")
local add_cmd = require("tc.helpers.cmd").add_cmd
local nmap = require("tc.helpers.keymap").wk_nmap

local find = function(opts)
	opts = opts or {
		no_ignore = true,
		hidden = false,
	}
	builtin.find_files(opts)
end

local project_files = function()
	local ok = pcall(builtin.git_files)
	if not ok then
		find()
	end
end

local TAG = "[Telescope]"

nmap({ keys = "<leader><leader>", action = project_files, name = "Project files", tag = TAG })
nmap({ keys = "<leader>ff", action = find, name = "Find files", tag = TAG })
nmap({ keys = "<leader>fb", action = builtin.buffers, name = "Buffers", tag = TAG })
nmap({ keys = "<leader>ft", action = builtin.tags, name = "Tags", tag = TAG })
nmap({ keys = "<leader>fm", action = builtin.marks, name = "Marks", tag = TAG })
nmap({ keys = "<leader>fr", action = builtin.registers, name = "Registers", tag = TAG })
nmap({ keys = "<leader>qf", action = builtin.quickfix, name = "Quickfix", tag = TAG })
nmap({ keys = "<leader>rg", action = builtin.live_grep, name = "Live grep", tag = TAG })
nmap({ keys = "<leader>*", action = builtin.grep_string, name = "Grep string", tag = TAG })
nmap({ keys = "<leader>b", action = builtin.resume, name = "Resume", tag = TAG })
nmap({ keys = "<c-g><c-r>", action = builtin.command_history, name = "Command history", tag = TAG })

add_cmd("Rg", builtin.live_grep)
add_cmd("Registers", builtin.registers)
