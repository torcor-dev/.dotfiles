local colors_name = "pinkbones"
vim.g.colors_name = colors_name -- Required when defining a colorscheme

local lush = require "lush"
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require "zenbones.util"

local bg = vim.opt.background:get()

-- Define a palette. Use `palette_extend` to fill unspecified colors
-- Based on https://github.com/gruvbox-community/gruvbox#palette
local palette = util.palette_extend({
		bg = hsluv "#1B0014",
		fg = hsluv "#FFCEF6", -- self, functions
		rose = hsluv "#C45E9E", -- definitions / error
		leaf = hsluv "#89FFC2",
		wood = hsluv "#D17FC8", -- warning
		water = hsluv "#A5456E", --class instance
		blossom = hsluv "#E794D0",
		sky = hsluv "#cbadff",
	}, bg)

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
	}
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
require("zenbones.term").apply_colors(palette)
