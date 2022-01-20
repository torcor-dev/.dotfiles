require('telescope').setup{
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
}

local builtin = require('telescope.builtin')
local add_cmd = require('tc.helpers.cmd').add_cmd
local nmap = require('tc.helpers.keymap').nmap

local find = function (opts)
  opts = opts or {
     no_ignore = true,
     hidden = true,
  }
  builtin.find_files(opts)
end

local project_files = function()
  local ok = pcall(builtin.git_files)
  if not ok then
   find()
  end
end


nmap { '<leader><leader>', project_files }
nmap { '<leader>ff', find }
nmap { '<leader>fb', builtin.buffers }
nmap { '<leader>ft', builtin.tags }
nmap { '<leader>fm', builtin.marks }
nmap { '<leader>fr', builtin.registers }
nmap { '<leader>qf', builtin.quickfix }
nmap { '<leader>rg', builtin.live_grep }
nmap { '<leader>*', builtin.grep_string }
nmap { '<c-g><c-r>', builtin.command_history }

add_cmd('Rg', builtin.live_grep)
add_cmd('Registers', builtin.registers)

