from colour import Color

import math


class ColorManager:
    COLOR_SCHEMES = {
        "default": {
            "fg": "#ffffff",
            "fg_alt": "#ffffff",
            "bg_left": "#1B0014",
            "bg_center": "#7f1f61",
            "highlight": "#f90764",
        },
        "purp_x_red": {
            "fg": "#ffffff",
            "fg_alt": "#ffffff",
            "bg_left": "#6502f9",
            "bg_center": "#f90248",
            "highlight": "#f352ff",
        },
        "purplebones": {
            "fg": "#ffffff",
            "fg_alt": "#ffffff",
            "bg_left": "#1B0014",
            "bg_center": "#7f1f61",
            "highlight": "#f90764",
        },
        "candy_pink": {
            "fg": "#ffffff",
            "fg_alt": "#ffffff",
            "bg_left": "#f90764",
            "bg_center": "#F24389",
            "bg_right": "#FF25FA",
            "highlight": "#f352ff",
        },
    }

    def __init__(self, color_scheme) -> None:
        self.color_scheme = color_scheme

    @property
    def color_scheme(self):
        return self._color_scheme

    @color_scheme.setter
    def color_scheme(self, color_scheme):
        self._color_scheme = color_scheme
        if not color_scheme in self.COLOR_SCHEMES:
            self._color_scheme = "default"
        self._apply_color_scheme()

    def _apply_color_scheme(self):
        colors = self.COLOR_SCHEMES[self.color_scheme]
        self.fg = Color(colors['fg'])
        self.fg_alt = Color(colors['fg_alt'])
        self.highlight = Color(colors['highlight'])
        self.bg_left = Color(colors['bg_left'])
        self.bg_center = Color(colors['bg_center'])
        self.bg_right = Color(colors.get('bg_right', self.bg_left))
        self.define_border_colors()

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
        rhs = self.color_range(self.bg_right, self.bg_center, right + split)
        rhs.reverse()


        self.spectrum = lhs + rhs
        if smoothness > 0:
            edge = smoothness // 2
            self.spectrum = self.spectrum[edge:-edge]

    def select_fg(self, bg):
        fg, inactive_fg = self.fg_alt, Color(self.fg)
        inactive_fg.luminance = 0.7

        if bg.luminance < 0.5:
            fg = self.fg
            inactive_fg = Color(self.fg_alt)
            if bg.luminance < 0.3:
                inactive_fg.luminance = 0.5
            else:
                inactive_fg.luminance = 0.2

        return fg, inactive_fg

    def define_border_colors(self):
        self.active_border = self.highlight
        self.inactive_border = Color(self.highlight)
        self.inactive_border.luminance = 0.3
        self.active_stack_border = self.complementary(self.highlight)
        self.inactive_stack_border = Color(self.active_stack_border)
        self.inactive_stack_border.luminance = 0.2

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
