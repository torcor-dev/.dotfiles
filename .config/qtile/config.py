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

from libqtile.config import Key, Screen, Group, Drag, Click, EzKey, Match
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

from typing import List  # noqa: F401

import os
import subprocess

# COLORS
DARKEST_PURPLE = "#11021A"
DARKER_PURPLE = "#190526"
DARK_PURPLE = "#220932"  # 201f23"#100c18"#fff5d8"
LIGHT_PURPLE = "#5c4788"  # ff5e6c"
MUTED_DARK_PURPLE = "#695988"
MUTED_LIGHT_PURPLE = "#ad8fe5"
LIGHT_PINK = "#efafce"  # ffaaab"
ORANGE = "#9A5900"  # "#FF8E00"
LIGHT_ORANGE = "#FFB800"
PINK = "#FF06FB"
LIGHT_BLUE = "#53A9CC"

DARK_TEXT = "#000000"
LIGHT_TEXT = "#ffffff"

ICON_PATH = "~/.icons/"

mod = "mod4"

# why doesnt a variable work?
class kbd:
    layout = "us"


k = kbd()


@lazy.function
def set_kbd_lo(qtile):
    if k.layout == "us":
        subprocess.run(["setxkbmap", "no"])
        k.layout = "no"
    else:
        subprocess.run(["setxkbmap", "us"])
        k.layout = "us"


keys = [
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "control"], "j", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_up()),
    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),
    Key([mod, "shift"], "n", lazy.layout.normalize()),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn("alacritty")),
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "p", lazy.spawn("rofi -show run")),
    Key(
        [mod, "shift"],
        "s",
        lazy.spawn("bash -c 'maim -s -u | xclip -selection clipboard -t image/png -i'"),
    ),
    Key(
        [mod, "shift"],
        "w",
        lazy.spawn("bash -c 'xkill'"),
    ),
    EzKey("M-S-p", set_kbd_lo),
]

groups = [Group(i) for i in "1234567890"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key([mod], i.name, lazy.group[i.name].toscreen(toggle=True)),
            # mod1 + shift + letter of group = switch to & move focused window to group
            #Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True)),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
        ]
    )

layout_theme = {
    "border_width": 1,
    "margin": 5,
    "border_focus": ORANGE,
    "border_normal": DARK_PURPLE,
}

matrix_theme = {
    "border_width": 1,
    "margin": 2,
    "border_focus": ORANGE,
    "border_normal": DARK_PURPLE,
}

groups[0].layouts = [
    layout.VerticalTile(columns=3, **matrix_theme),
    layout.Max(**matrix_theme),
]
groups[9].label = "serv"

groups[9].layouts = [
    layout.Matrix(columns=3, **matrix_theme),
    layout.Max(**matrix_theme),
]
groups[9].label = "serv"

layouts = [
    layout.Columns(
        num_columns=3,
        grow_amount=10,
        insert_position=0,
        split=True,
        border_focus_stack=PINK,
        border_normal_stack=LIGHT_BLUE,
        **layout_theme,
    ),
    # layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Stack(num_stacks=3),
    # Try more layouts by unleashing below layouts.
    # layout.Matrix(columns=3, **layout_theme),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(shift_window=True, **layout_theme),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]


widget_defaults = dict(
    font="Source Code Pro",
    fontsize=14,
    padding=2,
)
extension_defaults = widget_defaults.copy()


def base_widgets(
        group=True,
        wname=True,
        cpu=True,
        therm=True,
        mem=True,
        dspace=True,
        sys=True,
        clk=True,
        ):

    group_layout = [
        widget.CurrentLayoutIcon(foreground=LIGHT_ORANGE, background=DARKEST_PURPLE),
        widget.GroupBox(
            background=DARKER_PURPLE,
            active=LIGHT_ORANGE,
            inactive=MUTED_LIGHT_PURPLE,
            block_highlight_text_color=LIGHT_ORANGE,
            disable_drag=True,
            highlight_color=[ORANGE, LIGHT_ORANGE],
            highlight_method="line",
            other_current_screen_border=LIGHT_ORANGE,
            other_screen_border=LIGHT_ORANGE,
            this_current_screen_border=LIGHT_ORANGE,
            this_screen_border=LIGHT_ORANGE,
            urgent_alert_method="text",
            urgent_text=LIGHT_ORANGE,
        )]

    window_name = [
        widget.WindowName(foreground=LIGHT_PURPLE),
            ]
    cpu = [
        widget.Image(
            filename=f"{ICON_PATH}speedometer.png", margin=6, background=DARKER_PURPLE
        ),
        widget.CPU(
            background=DARKER_PURPLE,
            foreground=LIGHT_ORANGE,
            format="{load_percent}% ",
        )]

    thermo = [
        widget.Image(
            filename=f"{ICON_PATH}thermometer.png", margin=6, background=DARKER_PURPLE
        ),
        widget.ThermalSensor(
            background=DARKER_PURPLE,
            foreground=LIGHT_ORANGE,
            tag_sensor="Tctl",
            fmt="{}",
        )]

    memory = [
        widget.Image(
            filename=f"{ICON_PATH}encryption.png", margin=6, background=DARKER_PURPLE
        ),
        widget.Memory(
            background=DARKER_PURPLE,
            foreground=LIGHT_ORANGE,
            format="{MemUsed: .2f}{mm}",
            measure_mem="G"
        )]

    disk_space = [
        widget.Image(
            filename=f"{ICON_PATH}database.png", margin=6, background=DARKEST_PURPLE
        ),
        widget.DF(
            background=DARKEST_PURPLE,
            foreground=LIGHT_ORANGE,
            visible_on_warn=False,
            format="{f}/{s}{m}",
        ),]
    
    sys_tray = [
        widget.Systray(background=DARKEST_PURPLE),
    ]
    
    clock = [
        widget.Image(
            filename=f"{ICON_PATH}clock-line.png", margin=6, background=DARKEST_PURPLE
        ),
        widget.Clock(
            background=DARKEST_PURPLE,
            foreground=LIGHT_ORANGE,
            format="%H:%M",
        )]
    widgets = []
    if group:
        widgets.extend(group_layout)
    if wname:
        widgets.extend(window_name)
    if cpu:
        widgets.extend(cpu)
    if therm:
        widgets.extend(thermo)
    if mem:
        widgets.extend(memory)
    if dspace:
        widgets.extend(disk_space)
    if sys:
        widgets.extend(sys_tray)
    if clk:
        widgets.extend(clock)

    return widgets


laptop_widgets = base_widgets()
laptop_widgets.extend(
    (
        widget.Image(
            filename=f"{ICON_PATH}battery-charging.png",
            margin=6,
            background=DARKEST_PURPLE,
        ),
        widget.Battery(background=DARKEST_PURPLE, foreground=LIGHT_ORANGE),
        widget.Systray(background=DARKEST_PURPLE),
    )
)

screens = [
    Screen(top=bar.Bar(base_widgets(), 25, opacity=1, background=DARK_PURPLE)),
    Screen(top=bar.Bar(base_widgets(sys=False), 25, opacity=0.9, background=DARK_PURPLE)),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod, "shift"],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod, "shift"], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod, "shift"], "Button2", lazy.window.toggle_floating()),
    Click([mod], "Button1", lazy.spawn("bash -c '/home/fu/.local/bin/logout_macro'")),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
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


#@hook.subscribe.startup
#def start_always():
#    libqtile.qtile.cmd_restart()


# @libqtile.hook.subscribe.screen_change
# def restart_on_randr(ev):
#    libqtile.qtile.cmd_restart()


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
