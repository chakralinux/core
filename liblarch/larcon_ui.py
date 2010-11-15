#!/usr/bin/env python2
#
# larcon_self.py   --  Frame for a single larcon tool

# (c) Copyright 2009-2010 Michael Towers (larch42 at googlemail dot com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#
#-------------------------------------------------------------------
# 2010.08.14

from suim import Suim

class LarconGui(Suim):
    def __init__(self, appname, backend):
        self.appname = appname
        self.backend = backend
        self._running = False
        Suim.__init__(self, appname, [appname])
        self.widgetlist(self.fss('uim_fetch', 'larcon.uim'))
        self.connect('$$$uiquit$$$', self.quit)
        self.command('larcon.title', appname)
        self.command('larcon.icon', appname + '.png')
        self.command('larcon:main.layout', ['VBOX', appname])
        self.connect('larcon:docs*clicked', self._showdocs)
        self._showdocs(init=True)


    def fss(self, func, *args):
        """Supply backend (file-system) services to the gui
        """
        if func:
            if self._running and (func[0] != '_'):
                self.busy(True)
            # (Repeated setting or unsetting of the busy state is just ignored)
            result = self.backend(func, *args)
            # When the function is not finished, it returns None, otherwise (ok, val)
        else:
            result = True
        if self._running and result != None:
            self.busy(False)
        return result


    def data(self, key):
        return self.command('larcon_data.get', key)


    def _showdocs(self, init=False):
        if init:
            self.command('larcon:docview.html', self.fss('about'))
            self.helpstate = False
        else:
            self.helpstate = not self.helpstate
        self.command('larcon:stack.set', 1 if self.helpstate else 0)
        self.command('larcon:docs.text', self.data('hidetext')
                if self.helpstate else self.data('showtext'))
        self.command('larcon:docs.tt', self.data('hidett')
                if self.helpstate else self.data('showtt'))


    def go(self):
        self.command('larcon.pack')
        self.command('larcon.show')
        self.run()


    def sigin(self, signal, *args):
        self.idle_add(getattr(self, 'sig_' + signal), *args)


    def sig_get_password(self, message):
        """This is a callback, triggered by signal 'get_password'
        to ask the user to input the password.
        """
        self.fss('sendpassword', *self.command('textLineDialog', message,
                "%s: pw" % self.appname, "", True))


    def sig_showcompleted(self, ok, message):
        """This is a callback, triggered by signal 'showcompleted'
        to display an info dialog.
        """
        self.command('infoDialog' if ok else 'warningDialog', message)
        self.fss(None)       # Tell 'fss' that the command has terminated



