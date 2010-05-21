#!/usr/bin/python
###########################################################################
#   Copyright (C) 2008 by Lukas Appelhans                                 #
#   l.appelhans@gmx.de                                                    #
#                                                                         #
#   This program is free software; you can redistribute it and/or modify  #
#   it under the terms of the GNU General Public License as published by  #
#   the Free Software Foundation; either version 2 of the License, or     #
#   (at your option) any later version.                                   #
#                                                                         #
#   This program is distributed in the hope that it will be useful,       #
#   but WITHOUT ANY WARRANTY; without even the implied warranty of        #
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
#   GNU General Public License for more details.                          #
#                                                                         #
#   You should have received a copy of the GNU General Public License     #
#   along with this program; if not, write to the                         #
#   Free Software Foundation, Inc.,                                       #
#   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.          #
###########################################################################

import Arxin
import sip
from PyQt4.QtCore import *
from PyQt4.QtGui import *
from PyQt4.QtNetwork import *
from ui_arxinLocale import Ui_ArxinLocale

class ArxinLocale(QWidget, Ui_ArxinLocale):
    def __init__(self, parent):
        QWidget.__init__(self, parent)
        self.setupUi(self)

        self.procParser = Arxin.processParser()

        self.dirParser = Arxin.directoryParser()

    def parse(self):
        fileParser = Arxin.fileParser()
        fileParser.openFile("/etc/rc.conf")

        self.procParser.loadProcess("locale -a")
        self.procParser.startProcess()
        self.procParser.slotWaitForFinished()

        #LOCALE
        for loc in self.procParser.readAllStdOut():
            if (loc != None):
                self.localeCombo.addItem(loc);

        self.localeCombo.setCurrentIndex(self.localeCombo.findText(fileParser.getOption("LOCALE", fileParser.getOptionType("LOCALE"))))

        #Hardwareclock
        self.hardwareclockCombo.addItem("UTC")
        self.hardwareclockCombo.addItem("localtime")
        self.hardwareclockCombo.setCurrentIndex(self.hardwareclockCombo.findText(fileParser.getOption("HARDWARECLOCK", 
                                                                                  fileParser.getOptionType("HARDWARECLOCK"))))
        #Timezones
        self.dirParser.loadDirectory("/usr/share/zoneinfo")
        for zone in self.dirParser.getAllDirectoryEntries():
	    self.timeCombo.addItem(zone)

        self.timeCombo.setCurrentIndex(self.timeCombo.findText(fileParser.getOption("TIMEZONE", fileParser.getOptionType("TIMEZONE"))))

        #Keymap
        self.dirParser.resetConfiguration([self.dirParser.Recursive, self.dirParser.filesOnly, self.dirParser.trimExtension], ".map.gz")
        self.dirParser.loadDirectory("/usr/share/kbd/keymaps")
        for key in self.dirParser.getAllDirectoryEntries():
            self.keymapCombo.addItem(key)
        self.keymapCombo.setCurrentIndex(self.keymapCombo.findText(fileParser.getOption("KEYMAP", fileParser.getOptionType("KEYMAP"))))
        self.dirParser.resetConfiguration()

        #Consolefont
        self.dirParser.resetConfiguration([self.dirParser.Recursive, self.dirParser.filesOnly, self.dirParser.trimExtension], ".gz");
        self.dirParser.loadDirectory("/usr/share/kbd/consolefonts")
        for font in self.dirParser.getAllDirectoryEntries():
            self.consoleFont.addItem(font)
        self.consoleFont.setCurrentIndex(self.consoleFont.findText(fileParser.getOption("CONSOLEFONT", 
                                                                       fileParser.getOptionType("CONSOLEFONT"))))
        self.dirParser.resetConfiguration()

        #Consolemap
        self.dirParser.resetConfiguration([self.dirParser.Recursive, self.dirParser.filesOnly, self.dirParser.trimExtension], ".trans")
        self.dirParser.loadDirectory("/usr/share/kbd/consoletrans")
        for consolemap in self.dirParser.getAllDirectoryEntries():
            self.consoleMap.addItem(consolemap)
        self.consoleMap.setCurrentIndex(self.consoleMap.findText(fileParser.getOption("CONSOLEMAP", fileParser.getOptionType("CONSOLEMAP"))))
        self.dirParser.resetConfiguration()

        #USECOLOR
        if fileParser.getOption("USECOLOR", fileParser.getOptionType("USECOLOR")) == "yes":
            self.colorCheck.setChecked(True)

        fileParser.deleteLater()
        

    def save(self):
        fileParser = Arxin.fileParser()
        fileParser.openFile("/etc/rc.conf")
        fileParser.closeFile()
        fileParser.openFile("/etc/rc.conf")
        fileParser.setOption("LOCALE", str(self.localeCombo.currentText()), fileParser.IniLine)
        fileParser.setOption("HARDWARECLOCK", str(self.hardwareclockCombo.currentText()), fileParser.IniLine)
        fileParser.setOption("TIMEZONE", str(self.timeCombo.currentText()), fileParser.IniLine)
        fileParser.setOption("KEYMAP", str(self.keymapCombo.currentText()), fileParser.IniLine)
        fileParser.setOption("CONSOLEFONT", str(self.consoleFont.currentText()), fileParser.IniLine)
        fileParser.setOption("CONSOLEMAP", str(self.consoleMap.currentText()), fileParser.IniLine)
        if self.colorCheck.isChecked() == True:
            fileParser.setOption("USECOLOR", "yes", fileParser.IniLine)
        else:
            fileParser.setOption("USECOLOR", "no", fileParser.IniLine)
        fileParser.writeChangesToFile()
        fileParser.deleteLater()

localeWidget = 0

def parseSection():
    global localeWidget
    localeWidget = ArxinLocale(None)
    localeWidget.parse()
    Arxin.setWidget(localeWidget)


def saveSection():
    print "Save locale"
    global localeWidget
    localeWidget.save()
