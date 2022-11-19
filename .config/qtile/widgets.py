from libqtile import widget, bar


from user_widgets.cur_layout import CurrentLayout
from user_widgets.rainbow_groupbox import GroupBoxRainbow
from assets import icons


class WidgetManager:
    def __init__(self, colormanager, group_count, group_coloring=False):
        self.cm = colormanager
        self.group_coloring = group_coloring
        self.group_count = group_count

    def configure(self, systray, laptop, wide=True, smoothness=0):
        self.wide = wide
        center = self.center_widgets()
        lhs = self.lhs_widgets()
        rhs = self.rhs_widgets(systray, laptop)

        self.cm.create_spectrum(
            self.color_count(lhs) + self.group_count,
            self.color_count(center),
            self.color_count(rhs),
            smoothness=smoothness,
        )

        widgets = []
        widgets.extend(lhs)
        widgets.extend(center)
        widgets.extend(rhs)

        return self.apply_colors(widgets)

    def color_count(self, widgets):
        count = 0
        for wg in widgets:
            count += wg.count_colors()
        return count

    def apply_colors(self, widgets):
        colors = self.cm.spectrum.copy()
        colored_widgets = []

        idx = 0

        for wg in widgets:
            cwl = wg.configure(colors[idx : idx + wg.count_colors()])
            colored_widgets.extend(cwl)
            idx += wg.count_colors()
            if isinstance(wg, GroupBoxGrouping):
                if wg.rainbow_coloring:
                    gb = wg.configure_groupbox(colors[idx : idx + wg.group_count + 1])
                    idx += wg.group_count
                else:
                    gb = wg.configure_groupbox(colors[idx])
                    idx += 1
                colored_widgets.append(gb)

        return colored_widgets

    def lhs_widgets(self):
        lhs = [self.group_box()]
        return lhs

    def rhs_widgets(self, systray, laptop):
        rhs = [
            self.cpu(),
            self.thermometer(),
            self.ram(),
            self.hdd(),
        ]
        if laptop:
            rhs.append(self.battery()),
        if systray:
            rhs.append(self.systray())

        rhs.append(self.clock())

        return rhs

    def center_widgets(self):
        center_widgets = [
            self.window_title(),
        ]

        return center_widgets

    def window_title(self, center=True):
        if not self.wide:
            return WidgetGrouping([widget.Spacer()], group_coloring=self.group_coloring)
        if center:
            width = bar.CALCULATED
            widgets = [
                widget.Spacer(),
                widget.WindowName(width=width),
                widget.Spacer(),
                ]
        else:
            widgets = [widget.WindowName()]
        return WidgetGrouping(
            widgets,
            group_coloring=self.group_coloring,
        )

    def group_box(self):
        width = 8 if self.wide else 2

        return GroupBoxGrouping(
            CurrentLayout(
                callback=lambda x: icons.get(x, x),
                fontsize=24,
                padding=width,
            ),
            GroupBoxRainbow(
                disable_drag=True,
                margin_x=0,
                padding_x=width,
                highlight_method="line",
            ),
            self.group_count,
        )

    def cpu(self):
        return WidgetGrouping(
            widget.CPU(format="{load_percent}% "),
            icon("cpu"),
            group_coloring=self.group_coloring,
        )

    def thermometer(self):
        return WidgetGrouping(
            widget.ThermalSensor(
                tag_sensor="Tctl",
                threshold=80,
                foreground_alert=self.cm.highlight.get_hex_l()
            ),
            icon("thermometer", size="small"),
            group_coloring=self.group_coloring,
        )

    def ram(self):
        return WidgetGrouping(
            widget.Memory(
                format="{MemUsed: .2f}{mm}",
                measure_mem="G",
            ),
            icon("ram"),
            group_coloring=self.group_coloring,
        )

    def hdd(self):
        return WidgetGrouping(
            widget.DF(
                visible_on_warn=False,
                format="{f}/{s}{m}",
            ),
            icon("hdd", size="small"),
            group_coloring=self.group_coloring,
        )

    def systray(self):
        return WidgetGrouping(
            widget.Systray(),
            icon("systray"),
            group_coloring=self.group_coloring,
        )

    def clock(self):
        return WidgetGrouping(
            widget.Clock(
                format="%H:%M",
            ),
            icon("clock"),
            group_coloring=self.group_coloring,
        )

    def battery(self):
        return WidgetGrouping(
            widget.Battery(
                format="{percent:.0f}%",
            ),
            icon("battery"),
            group_coloring=self.group_coloring,
        )

    def widget_defaults(self):
        return dict(
            font="Source Code Pro",
            fontsize=16,
            padding=2,
            foreground=self.cm.fg.get_hex_l(),
            background=self.cm.bg_center.get_hex_l(),
        )


def icon(name="", size="medium", **kwargs):
    fmt = "{}"
    if size == "small":
        fmt = "<small>{}</small>"
    elif size == "large":
        fmt = "<big>{}</big>"

    return widget.TextBox(
        text=icons.get(name, ""),
        fontsize=18,
        padding=2,
        fmt=fmt,
        **kwargs,
    )


class WidgetGrouping:
    def __init__(self, widgets, icon=None, sep=None, group_coloring=True):
        if isinstance(widgets, list):
            self.widgets = widgets
        else:
            self.widgets = [widgets]
        self.icon = icon
        self.sep = sep
        self.group_coloring = group_coloring

    def count_colors(self):
        if self.group_coloring:
            return 1
        return self.count_items()

    def count_items(self):
        count = 1 if self.icon else 0
        count += 1 if self.sep else 0
        count += len(self.widgets)
        return count

    def configure(self, colors: list, sep_color=None):
        group = []
        if self.group_coloring:
            colors = [colors[0]] * self.count_items()

        if self.sep:
            self.apply_color(self.sep, sep_color if sep_color else colors.pop(0))
            group.append(self.sep)

        if self.icon:
            self.apply_color(self.icon, colors.pop(0))
            group.append(self.icon)

        for widget in self.widgets:
            self.apply_color(widget, colors.pop(0))
            group.append(widget)

        return group

    def apply_color(self, widget, color):
        widget.foreground = color["foreground"]
        widget.background = color["background"]


class GroupBoxGrouping(WidgetGrouping):
    def __init__(
        self,
        widgets,
        groupbox,
        group_count,
        icon=None,
        sep=None,
        group_coloring=True,
        rainbow_coloring=True,
    ):
        super().__init__(widgets, icon, sep, group_coloring)
        self.groupbox = groupbox
        self.group_count = group_count
        self.rainbow_coloring = rainbow_coloring

    def configure_groupbox(self, colors):
        if self.rainbow_coloring:
            self.groupbox.rainbow = colors
        else:
            self.apply_color(self.groupbox, colors)

        return self.groupbox
