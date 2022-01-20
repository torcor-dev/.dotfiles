# Copyright (c) 2008, 2010 Aldo Cortesi
# Copyright (c) 2009 Ben Duffield
# Copyright (c) 2010 aldo
# Copyright (c) 2010-2012 roger
# Copyright (c) 2011 Florian Mounier
# Copyright (c) 2011 Kenji_Takahashi
# Copyright (c) 2011-2015 Tycho Andersen
# Copyright (c) 2012-2013 dequis
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 xarvh
# Copyright (c) 2013 Tao Sauvage
# Copyright (c) 2014 Sean Vig
# Copyright (c) 2014 Filipe Nepomuceno
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

from libqtile import bar, hook
from libqtile.log_utils import logger
from libqtile.widget import base


class CurrentLayout(base._TextBox):
    """
    Displays the current layout of the current group.
    """

    def __init__(self, callback, width=bar.CALCULATED, **config):
        base._TextBox.__init__(self, "", width, **config)
        self.callback = callback

    def _configure(self, qtile, bar):
        base._TextBox._configure(self, qtile, bar)
        layout_id = self.bar.screen.group.current_layout
        self.text = self.callback(self.bar.screen.group.layouts[layout_id].name)
        self.setup_hooks()

        self.add_callbacks(
            {
                "Button1": qtile.cmd_next_layout,
                "Button2": qtile.cmd_prev_layout,
            }
        )

    def setup_hooks(self):
        def hook_response(layout, group):
            if group.screen is not None and group.screen == self.bar.screen:
                self.text = self.callback(layout.name)
                self.bar.draw()

        hook.subscribe.layout_change(hook_response)
