local colors_name = "pinkbones"
vim.g.colors_name = colors_name -- Required when defining a colorscheme

local lush = require "lush"
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require "zenbones.util"

local bg = vim.opt.background:get()
local base_colors = require("tc.palettes.pink")
for k, v in pairs(base_colors) do
  base_colors[k] = hsluv(v)
end

-- Define a palette. Use `palette_extend` to fill unspecified colors
local palette = util.palette_extend(base_colors, bg)

-- Generate the lush specs using the generator util
local generator = require "zenbones.specs"
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
	return {
        DiagnosticVirtualTextHint {base_specs.DiagnosticVirtualTextHint, bg = palette.bg },
        DiagnosticVirtualTextError {base_specs.DiagnosticVirtualTextError, bg = palette.bg },
        DiagnosticVirtualTextWarn {base_specs.DiagnosticVirtualTextWarn, bg = palette.bg },
        DiagnosticVirtualTextInfo {base_specs.DiagnosticVirtualTextInfo, bg = palette.bg },
        Delimiter { base_specs.Delimiter, fg = palette.rose },
		Statement { base_specs.Statement, fg = palette.rose },
		Special { fg = palette.water },
		Type { fg = palette.sky, },
        String { fg = palette.leaf } ,

        -- As far as MatchParen or Cursor colors goes
        -- Alacritty color config for cursor overwrites any config for current cursor

        --MatchParen {gui='bold,underline'},
        --Search { bg = "#8c2eea", fg = palette.rose, },
        --Cursor {gui='bold'},
        --lCursor {gui='bold'},
        --TermCursor {gui='bold'},
        --TermCursorNC {gui='bold'},
	}
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
require("zenbones.term").apply_colors(palette)

--vim.cmd([[highlight BufferLineFill guibg=]] .. palette.rose)
--vim.cmd([[highlight BufferLineTab guibg=]] .. palette.rose)
