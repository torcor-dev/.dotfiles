icons = {
    "hdd": "",
    "cpu": "龍",
    "thermometer": "",
    "ram": "",
    "clock": "",
    "columns": "",
    "max": "",
    "matrix": "ﲡ",
    "left_triangle": "",
}

colors = {
    "foreground": "#E991CF",
    "background": "#250014",
    "normal": {
        "black": "#250014",
        "red": "#C35E9D",
        "green": "#FF88B3",
        "yellow": "#D17FC8",
        "blue": "#FF62A8",
        "magenta": "#E792D0",
        "cyan": "#FF73FE",
        "white": "#E991CF",
    },
    "bright": {
        "black": "#5F003B",
        "red": "#DC6DB2",
        "green": "#FF9FBF",
        "yellow": "#E090D7",
        "blue": "#FF83B5",
        "magenta": "#F0A3DA",
        "cyan": "#FF90FE",
        "white": "#D54FB3",
    },
}

from colour import Color

import math


class ColorManager:
    def __init__(
        self, fg, bg_left, bg_center, bg_right=None, fg_alt=None, highlight=None
    ):
        self.fg_light = Color(fg)
        self.fg_dark = Color(fg_alt) if fg_alt else Color(fg, luminance=0.1)
        self.highlight = Color(highlight) if highlight else None
        self.bg_left = Color(bg_left)
        self.bg_center = Color(bg_center)
        self.bg_right = Color(bg_right) if bg_right else Color(bg_left)

    def color_range(self, start, end, n):
        range = []
        colors = start.range_to(end, n)
        for bg in colors:
            fg, inactive_fg = self.select_fg(bg)
            if self.highlight:
                highlight = self.highlight
            else:
                highlight = self.complementary(bg)
            range.append(
                {
                    "foreground": fg.get_hex_l(),
                    "background": bg.get_hex_l(),
                    "inactive_fg": inactive_fg.get_hex_l(),
                    "highlight_bg": highlight.get_hex_l(),
                    "highlight_fg": bg.get_hex_l(),
                }
            )
        return range

    def create_spectrum(self, left, center, right, smoothness=0):
        split = math.ceil((center + smoothness) / 2)
        lhs = self.color_range(self.bg_left, self.bg_center, left + split)
        rhs = self.color_range(self.bg_center, self.bg_right, right + split)

        self.spectrum = lhs + rhs
        if smoothness > 0:
            edge = smoothness // 2
            self.spectrum = self.spectrum[edge:-edge]

    def select_fg(self, bg):
        fg, inactive_fg = self.fg_dark, Color(self.fg_light)
        inactive_fg.luminance = 0.7

        if bg.luminance < 0.5:
            fg = self.fg_light
            inactive_fg = Color(self.fg_dark)
            if bg.luminance < 0.3:
                inactive_fg.luminance = 0.5
            else:
                inactive_fg.luminance = 0.2

        return fg, inactive_fg

    def complementary(self, color):
        r, g, b = color.get_rgb()
        k = self.hilo(r, g, b)
        complement = Color()
        complement.set_rgb((k - r, k - g, k - b))
        return complement

    def hilo(self, a, b, c):
        if c < b:
            b, c = c, b
        if b < a:
            a, b = b, a
        if c < b:
            b, c = c, b
        return a + c
