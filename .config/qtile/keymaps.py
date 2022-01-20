from libqtile.config import Key, Screen, Group, Drag, Click, EzKey, Match
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

import subprocess


class kbd:
    layout = "us"


k = kbd()


@lazy.function
def set_kbd_lo(_):
    if k.layout == "us":
        subprocess.run(["setxkbmap", "no"])
        k.layout = "no"
    else:
        subprocess.run(["setxkbmap", "us"])
        k.layout = "us"


class Keymaps:
    def __init__(self, mod):
        self.mod = mod

        self.keys = [
            Key([self.mod], "j", lazy.layout.down()),
            Key([self.mod], "k", lazy.layout.up()),
            Key([self.mod], "h", lazy.layout.left()),
            Key([self.mod], "l", lazy.layout.right()),
            Key([self.mod, "shift"], "j", lazy.layout.shuffle_down()),
            Key([self.mod, "shift"], "k", lazy.layout.shuffle_up()),
            Key([self.mod, "shift"], "h", lazy.layout.shuffle_left()),
            Key([self.mod, "shift"], "l", lazy.layout.shuffle_right()),
            Key([self.mod, "control"], "j", lazy.layout.grow_down()),
            Key([self.mod, "control"], "k", lazy.layout.grow_up()),
            Key([self.mod, "control"], "h", lazy.layout.grow_left()),
            Key([self.mod, "control"], "l", lazy.layout.grow_right()),
            Key([self.mod, "shift"], "n", lazy.layout.normalize()),
            Key([self.mod, "shift"], "Return", lazy.layout.toggle_split()),
            Key([self.mod], "Return", lazy.spawn("alacritty")),
            Key([self.mod], "Tab", lazy.next_layout()),
            Key([self.mod], "w", lazy.window.kill()),
            Key([self.mod, "control"], "r", lazy.restart()),
            Key([self.mod, "control"], "q", lazy.shutdown()),
            Key([self.mod], "p", lazy.spawn("rofi -show run")),
            Key(
                [self.mod, "shift"],
                "s",
                lazy.spawn(
                    "bash -c 'maim -s -u | xclip -selection clipboard -t image/png -i'"
                ),
            ),
            Key(
                [self.mod, "shift"],
                "w",
                lazy.spawn("bash -c 'xkill'"),
            ),
            EzKey("M-S-p", set_kbd_lo),
        ]

    def map_groups(self, groups):
        for i in groups:
            self.keys.extend(
                [
                    # mod1 + letter of group = switch to group
                    Key([self.mod], i.name, lazy.group[i.name].toscreen(toggle=True)),
                    # mod1 + shift + letter of group = switch to & move focused window to group
                    # Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True)),
                    # Or, use below if you prefer not to switch to that group.
                    # # mod1 + shift + letter of group = move focused window to group
                    Key([self.mod, "shift"], i.name, lazy.window.togroup(i.name)),
                ]
            )

    def mouse_bindings(self):
        return [
            Drag(
                [self.mod, "shift"],
                "Button1",
                lazy.window.set_position_floating(),
                start=lazy.window.get_position(),
            ),
            Drag(
                [self.mod, "shift"],
                "Button3",
                lazy.window.set_size_floating(),
                start=lazy.window.get_size(),
            ),
            Click([self.mod, "shift"], "Button2", lazy.window.toggle_floating()),
            Click(
                [self.mod],
                "Button1",
                lazy.spawn("bash -c '/home/fu/.local/bin/logout_macro'"),
            ),
        ]
