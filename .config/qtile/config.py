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

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

from typing import List  # noqa: F401

import os
import subprocess

# COLORS
BEIGE = "#fff5d8"
RED = "#ff5e6c"
YELLOW = "#feb301"
PINK = "#ffaaab"
DARK_TEXT = "#000000"
LIGHT_TEXT = "#ffffff"

mod = "mod4"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),
    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),
    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),
    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn("termite")),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
    Key([mod], "p", lazy.spawn("dmenu_run")),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True)),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
        ]
    )

# new_group = {
#         'spawn': 'termite',
#         'layout': 'monadtall',
#         'label': 'TsTerm',
#         }
# Play Group    0
# emby = 'chromium --app=http://148.251.180.212:8096/ --new-window'
# madsonic = 'chromium --app=http://148.251.180.212:4040/ --new-window'
# groups.append(Group('play', spawn=[emby, madsonic], layout='monadtall', init=True, label='play'))
# keys.append(Key([mod], '0', lazy.group['play'].toscreen()))

# Main firefox  1
# grp1 = Group('

layout_theme = {
    "border_width": 2,
    "margin": 10,
    "border_focus": "e1acff",
    "border_normal": "1D2330",
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    #layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    #layout.Tile(shift_window=True, **layout_theme),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(font="Monospace", fontsize=14, padding=2,)
extension_defaults = widget_defaults.copy()
# cherry = "🌸"
# white_flower = "💮"
# onigiri = "🍙"
# Cooked rice: 🍚
separator_emoji = "💮"


def base_widgets():
    return [
        widget.CurrentLayoutIcon(background=PINK),
        widget.GroupBox(
            background=RED,
            active=BEIGE,
            inactive=PINK,
            block_highlight_text_color=BEIGE,
            disable_drag=True,
            highlight_color=[RED, YELLOW],
            highlight_method="line",
            other_current_screen_border=YELLOW,
            other_screen_border=YELLOW,
            this_current_screen_border=PINK,
            this_screen_border=PINK,
            urgent_alert_method="text",
            urgent_text=YELLOW,
        ),
        widget.WindowName(foreground=RED),
        widget.Cmus(background=RED, play_color=BEIGE, noplay_color=PINK, fmt="[{}]",),
        widget.TextBox(text=separator_emoji, font="Noto Color Emoji", background=PINK),
        widget.CheckUpdates(background=PINK, display_format="[up: {updates}]"),
        widget.TextBox(text=separator_emoji, font="Noto Color Emoji", background=RED),
        widget.Wlan(
            background=RED,
            foreground=BEIGE,
            interface="wlp59s0",
            format="{percent:2.0%}",
            fmt="[wifi: {}]",
        ),
        widget.TextBox(text=separator_emoji, font="Noto Color Emoji", background=PINK),
        widget.Clock(background=PINK, foreground=BEIGE, format="%H:%M", fmt="[{}]",),
        widget.TextBox(text=separator_emoji, font="Noto Color Emoji", background=RED),
        widget.Systray(background=RED),
    ]

screens = [
    Screen(top=bar.Bar(base_widgets(), 25, opacity=0.9, background=BEIGE)),
    Screen(top=bar.Bar(base_widgets(), 25, opacity=0.9, background=BEIGE)),
]
# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        {"wmclass": "confirm"},
        {"wmclass": "dialog"},
        {"wmclass": "download"},
        {"wmclass": "error"},
        {"wmclass": "file_progress"},
        {"wmclass": "notification"},
        {"wmclass": "splash"},
        {"wmclass": "toolbar"},
        {"wmclass": "confirmreset"},  # gitk
        {"wmclass": "makebranch"},  # gitk
        {"wmclass": "maketag"},  # gitk
        {"wname": "branchdialog"},  # gitk
        {"wname": "pinentry"},  # GPG key password entry
        {"wmclass": "ssh-askpass"},  # ssh-askpass
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"

@hook.subscribe.startup_once
def start_once():
   home = os.path.expanduser('~')
   subprocess.call([home + '/.config/qtile/autostart.sh'])


# @hook.subscribe.client_new
# def float_keepass(window):
#     if window.window.get_name() == "KeePass":
#         window.floating = True


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
# # We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
