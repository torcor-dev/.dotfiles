# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# SCREEN_SIZE=1920x1080 ./scripts/xephyr -c ~/.config/qtile/dev_config.py

from libqtile.config import Screen, Group
from libqtile import bar, hook

from colors import ColorManager
from keymaps import Keymaps
from layouts import LayoutManager
from widgets import WidgetManager

from typing import List

import os
import subprocess

LAPTOP_MODE = False

mod = "mod4"
groups = [Group(i) for i in "1234567890"]

# colormanager = ColorManager(**color_schemes["purp_x_red"])
# colormanager = ColorManager(**color_schemes["purplebones"])
colormanager = ColorManager("candy_pink")

keymaps = Keymaps(mod)
keymaps.map_groups(groups)

keys = keymaps.keys

layoutmanager = LayoutManager(groups, colormanager)
layouts = layoutmanager.default_layouts

widgetmanager = WidgetManager(colormanager, 10)
widget_defaults = widgetmanager.widget_defaults()

widgets_s1 = widgetmanager.configure(True, LAPTOP_MODE, smoothness=10)
widgets_s2 = widgetmanager.configure(False, LAPTOP_MODE, wide=False, smoothness=10)

screens = [
    Screen(
        top=bar.Bar(
            widgets_s1,
            25,
            opacity=0.9,
        )
    ),
    Screen(
        top=bar.Bar(
            widgets_s2,
            25,
            opacity=0.9,
        )
    ),
]

mouse = keymaps.mouse_bindings()
floating_layout = layoutmanager.floating_layout()
dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])


# @hook.subscribe.layout_change
# def current_layout_icon(_, group):
#    cl = group.qtile.widgets_map['currentlayout']
#    cl.fmt = '{}'.format(icons.get(cl.text, cl.text))

wmname = "LG3D"
