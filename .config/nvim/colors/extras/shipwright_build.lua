local util = require "zenbones.util"
local lush = require "lush"
local hsluv = lush.hsluv -- Human-friendly hsl
local bg = vim.opt.background:get()

local palette = util.palette_extend({
		bg = hsluv "#250014",
		--bg = hsluv "#250D1A",
		fg = hsluv "#EA93D0", -- self, functions
		rose = hsluv "#C45E9E", -- definitions / error
		leaf = hsluv "#FF8AB3",
		wood = hsluv "#D25FC5", -- warning
		water = hsluv "#FF65A8", --class instance
		blossom = hsluv "#E794D0",
		sky = hsluv "#FF74FD",
	}, bg)

run(palette,
  function(p)
    return {
      fg = p.fg,
      bg = p.bg,
      cursor_fg = p.bg,
      cursor_bg = p.fg,
      black = p.bg,
      red = p.rose,
      green = p.leaf,
      yellow = p.wood,
      blue = p.water,
      magenta = p.blossom,
      cyan = p.sky,
      white = p.fg,
      bright_black = p.bg1,
      bright_red = p.rose1,
      bright_green = p.leaf1,
      bright_yellow = p.wood1,
      bright_blue = p.water1,
      bright_magenta = p.blossom1,
      bright_cyan = p.sky1,
      bright_white = p.fg1,
    }
  end,
  contrib.alacritty,
  {overwrite, 'alacritty.yaml'}
)
