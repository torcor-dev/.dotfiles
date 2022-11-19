from libqtile import layout
from libqtile.config import Match


class LayoutManager:
    def __init__(self, groups, colormanager):
        self.groups = groups
        self.cm = colormanager
        self.vertical_layout(self.groups[0])
        self.matrix_layout(self.groups[9])
        self.default_layouts = [
            layout.Columns(
                num_columns=3,
                grow_amount=10,
                insert_position=0,
                split=True,
                border_focus_stack=self.cm.active_stack_border.get_hex_l(),
                border_normal_stack=self.cm.inactive_stack_border.get_hex_l(),
                **self.base_theme()
            ),
            layout.Max(**self.base_theme()),
            # layout.MonadTall(**layout_theme),
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

    def base_theme(self, border_width=1, margin=5):
        return {
            "border_width": border_width,
            "margin": margin,
            "border_focus": self.cm.active_border.get_hex_l(),
            "border_normal": self.cm.inactive_border.get_hex_l(),
        }

    def vertical_layout(self, group):
        group.layouts = [
            layout.Columns(
                num_columns=1,
                grow_amount=10,
                insert_position=0,
                split=True,
                border_focus_stack=self.cm.active_stack_border.get_hex_l(),
                border_normal_stack=self.cm.inactive_stack_border.get_hex_l(),
                **self.base_theme()
            ),
            layout.Max(**self.base_theme(1, 2)),
        ]

    def matrix_layout(self, group):
        group.layouts = [
            layout.Matrix(colums=3, **self.base_theme(1, 2)),
            layout.Max(**self.base_theme(1, 2)),
        ]

    def floating_layout(self):
        return layout.Floating(
            float_rules=[
                # Run the utility of `xprop` to see the wm class and name of an X client.
                *layout.Floating.default_float_rules,
                Match(wm_class="confirmreset"),  # gitk
                Match(wm_class="makebranch"),  # gitk
                Match(wm_class="maketag"),  # gitk
                Match(wm_class="ssh-askpass"),  # ssh-askpass
                Match(wm_class="awakened-poe-trade"),  # ssh-askpass
                Match(title="branchdialog"),  # gitk
                Match(title="pinentry"),  # GPG key password entry
            ],
            border_focus=self.cm.active_border.get_hex_l(),
            border_normal=self.cm.inactive_border.get_hex_l(),
        )
