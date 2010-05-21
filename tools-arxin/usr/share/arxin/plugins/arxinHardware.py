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
from PyKDE4.kdeui import *
from PyKDE4.kdecore import *
from ui_arxinHardware import Ui_ArxinHardware
from ui_arxinAddModule import Ui_ArxinAddModuleWidget

class ArxinAddModuleDialog(KDialog):
    def __init__(self, parent):
        KDialog.__init__(self, parent)
        widget = QWidget(self)
        self.ui = Ui_ArxinAddModuleWidget()
        self.ui.setupUi(widget)
        self.ui.ktreewidgetsearchlinewidget.searchLine().addTreeWidget(self.ui.modulesTreeWidget)
        self.setMainWidget(widget)
        procParser = Arxin.processParser()
        procParser.loadProcess("modprobe -l")
        procParser.startProcess()
        procParser.slotWaitForFinished()
        modules = procParser.readAllStdOut()
        for mod in modules:
            if mod == None:
                continue
            item = QTreeWidgetItem(self.ui.modulesTreeWidget, QStringList() << mod.split("/")[-1].split(".")[0] << QString() << mod)
            procParser.loadProcess("modinfo -F description " + mod.split("/")[-1].split(".")[0])
            procParser.startProcess()
            procParser.slotWaitForFinished()
            desc = procParser.readAllStdOut()
            if desc[0] == None:
                continue
            desc = QString(desc[0]).trimmed()
            item.setText(1, desc)

    def modulesToAdd(self):
        mod = {}
        for item in self.ui.modulesTreeWidget.selectedItems():
            mod[item.text(0)] = item.text(1)
        return mod

class ArxinHardware(QWidget, Ui_ArxinHardware):
    def __init__(self, parent):
        QWidget.__init__(self, parent)
        self.setupUi(self)
        self.addModuleDialog = None
        self.addModButton.setIcon(KIcon("list-add"))
        self.removeModButton.setIcon(KIcon("list-remove"))
        self.addModblackButton.setIcon(KIcon("list-add"))
        self.removeModblackButton.setIcon(KIcon("list-remove"))
        self.loadModButton.setIcon(KIcon("media-playback-start"))
        self.unloadModButton.setIcon(KIcon("media-playback-stop"))
        self.procParser = Arxin.processParser()

        self.connect(self.addModButton, SIGNAL("clicked()"), self.showAddModuleDialog)
        self.connect(self.removeModButton, SIGNAL("clicked()"), self.removeModule)
        self.connect(self.addModblackButton, SIGNAL("clicked()"), self.showAddBlackModuleDialog)
        self.connect(self.removeModblackButton, SIGNAL("clicked()"), self.removeBlackModule)
        self.connect(self.loadModButton, SIGNAL("clicked()"), self.loadModule)
        self.connect(self.unloadModButton, SIGNAL("clicked()"), self.unloadModule)

    def parse(self):
        fileParser = Arxin.fileParser()
        fileParser.openFile("/etc/rc.conf")
        if fileParser.getOption("MOD_AUTOLOAD", fileParser.getOptionType("MOD_AUTOLOAD")) == "yes":
            self.scanHardwareCheck.setChecked(1)

        if fileParser.getOption("USELVM", fileParser.getOptionType("USELVM")) == "yes":
            self.scanLVMCheck.setChecked(True)

        mods = QStringList()
        mods << QString(fileParser.getOption("MODULES", fileParser.ParLine)).split(" ")
        for mod in mods:
            item = None
            black = False
            if mod.startsWith("!") == True:
                black = True
                mod.remove(0, 1)
            if mod.isEmpty() == True:
                continue
            self.procParser.loadProcess(str("modinfo -F description " + mod))
            self.procParser.startProcess()
            self.procParser.slotWaitForFinished()
            desc = self.procParser.readAllStdOut()
            if desc[0] == None:
                continue
            desc = QString(desc[0]).trimmed()
            self.addModule(mod, desc, black)

        fileParser.deleteLater()

    def save(self):
        fileParser = Arxin.fileParser()
        fileParser.openFile("/etc/rc.conf")
        #Save modules
        modules = []
        while self.modWidget.topLevelItem(0) != None:
            modules.append(str(self.modWidget.takeTopLevelItem(0).text(0)))

        while self.modblackWidget.topLevelItem(0) != None:
            modules.append(str("!" + self.modblackWidget.takeTopLevelItem(0).text(0)))

        fileParser.setOption("MODULES", " ".join(modules), fileParser.ParLine)

        #MOD_AUTOLOAD
        if self.scanHardwareCheck.isChecked() == True:
            fileParser.setOption("MOD_AUTOLOAD", "yes", fileParser.IniLine)
        else:
            fileParser.setOption("MOD_AUTOLOAD", "no", fileParser.IniLine)

        #USELVM
        if self.scanLVMCheck.isChecked() == True:
            fileParser.setOption("USELVM", "yes", fileParser.IniLine)
        else:
            fileParser.setOption("USELVM", "no", fileParser.IniLine)

        fileParser.writeChangesToFile()
        fileParser.deleteLater()

    def addModule(self, name, description, black):
        self.procParser.loadProcess(str("modprobe -n -v " + name))
        self.procParser.startProcess()
        self.procParser.slotWaitForFinished()
        if len(self.procParser.readAllStdOut()) == 1:
            state = i18n("Loaded")
        else:
            state = i18n("Not loaded")
        item = QTreeWidgetItem(QStringList() << name << description << state)
        if black == True:
            self.modblackWidget.addTopLevelItem(item)
        else:
            self.modWidget.addTopLevelItem(item)

    def showAddModuleDialog(self):
        if self.addModuleDialog == None:
            self.addModuleDialog = ArxinAddModuleDialog(self)
        self.addModuleDialog.exec_()
        if self.addModuleDialog.result() == 1: #QDialog::accepted
            for name, description in self.addModuleDialog.modulesToAdd().items():
                self.addModule(name, description, False)

    def removeModule(self):
        for item in self.modWidget.selectedItems():
            self.modWidget.takeTopLevelItem(self.modWidget.indexOfTopLevelItem(item))

    def showAddBlackModuleDialog(self):
        if self.addModuleDialog == None:
            self.addModuleDialog = ArxinAddModuleDialog(self)
        self.addModuleDialog.exec_()
        if self.addModuleDialog.result() == 1: #QDialog::accepted
            for name, description in self.addModuleDialog.modulesToAdd().items():
                self.addModule(name, description, True)

    def removeBlackModule(self):
        for item in self.modblackWidget.selectedItems():
            self.modblackWidget.takeTopLevelItem(self.modblackWidget.indexOfTopLevelItem(item))

    def loadModule(self):
        for item in self.modWidget.selectedItems():
            self.procParser.loadProcess("modprobe " + str(item.text(0)))
            self.procParser.startProcess()
            self.procParser.slotWaitForFinished()
            out = self.procParser.readAllStdOut()
            if  out[0] != None:
                KMessageBox.error(self, i18n("Arxin failed loading ") + item.text(0), "Loading Module")
                #FIXME: i18nstuff
            else:
                item.setText(2, i18n("Loaded"))

    def unloadModule(self):
        for item in self.modWidget.selectedItems():
            self.procParser.loadProcess("modprobe -r " + str(item.text(0)))
            self.procParser.startProcess()
            self.procParser.slotWaitForFinished()
            out = self.procParser.readAllStdOut()
            if  out[0] != None:
                KMessageBox.error(self, i18n("Arxin failed unloading ") + item.text(0), "Unloading Module")
                #FIXME: i18n
            else:
                item.setText(2, i18n("Not loaded"))

hardwareWidget = 0

def parseSection():
    global hardwareWidget
    hardwareWidget = ArxinHardware(None)
    hardwareWidget.parse()
    Arxin.setWidget(hardwareWidget)
    

def saveSection():
    global hardwareWidget
    hardwareWidget.save()
