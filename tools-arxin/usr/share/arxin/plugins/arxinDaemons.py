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
from PyKDE4.kdeui import *
from ui_arxinDaemons import Ui_ArxinDaemons
from ui_arxinAddDaemonsWidget import Ui_ArxinAddDaemonsWidget

class AddDaemonDialog(KDialog):
    def __init__(self, parent):
        KDialog.__init__(self, parent)
        self.ui = Ui_ArxinAddDaemonsWidget()
        widget = QWidget(self)
        self.ui.setupUi(widget)
        self.setMainWidget(widget)
        #self.ui.treeWidget.hideColumn(1)
        self.connect(self, SIGNAL("accepted()"), self.accepted)

    def addDaemon(self, name, description):
        item = QTreeWidgetItem(self.ui.treeWidget, QStringList() << name << description)
        pass

    def accepted(self):
        if self.ui.treeWidget.currentItem == None:
            return
        self.emit(SIGNAL("addDaemon"), self.ui.treeWidget.currentItem().text(0), self.ui.treeWidget.currentItem().text(1))

class Daemon(QTreeWidgetItem):
    def __init__(self, name, description, startInBackground, parent):
        QTreeWidget.__init__(self, parent)
        self.procParser = Arxin.processParser()
        self.setText(0, name)
        self.setText(1, description)

        if (startInBackground == True):
            self.setCheckState(2, Qt.Checked)
        else:
            self.setCheckState(2, Qt.Unchecked)

    def startDaemon(self):
        daemon = self.text(0)
        print "/etc/rc.d/" + daemon + " start"
        self.procParser.loadProcess(str("/etc/rc.d/" + daemon + " start"))
        self.procParser.startProcess()
        self.procParser.slotWaitForFinished()
        output = self.procParser.readAllStdOut()
        print output[0]
        if output[0] == None or output[0].find("FAIL") != -1:#TODO: Use a KMessageBox, as well in stopDaemon
            print "error while starting " + daemon
        else:
            print daemon + " started successfully"

    def stopDaemon(self):
        daemon = self.text(0)
        print "/etc/rc.d/" + daemon + " stop"
        self.procParser.loadProcess(str("/etc/rc.d/" + daemon + " stop"))
        self.procParser.startProcess()
        self.procParser.slotWaitForFinished()
        output = self.procParser.readAllStdOut()
        if output[0] == None or output[0].find("FAIL") != -1:
            print "error while stopping " + daemon
        else:
            print daemon + " stopped successfully"
        

class ArxinDaemons(QWidget, Ui_ArxinDaemons):
    def __init__(self, parent):
        QWidget.__init__(self, parent)
        self.setupUi(self)
        #self.treeWidget.hideColumn(1)
        self.addButton.setIcon(KIcon("list-add"))
        self.removeButton.setIcon(KIcon("list-remove"))
        self.procParser = Arxin.processParser()
        self.dirParser = Arxin.directoryParser()
        self.addDialog = AddDaemonDialog(self)
        self.checkRunning()
        self.connect(self.addDialog, SIGNAL("addDaemon"), self.addNewDaemon)
        self.connect(self.treeWidget, SIGNAL("currentItemChanged(QTreeWidgetItem *,QTreeWidgetItem *)"), 
                     self.selectionChanged)
        self.connect(self.startButton, SIGNAL("clicked()"), self.startDaemon)
        self.connect(self.stopButton, SIGNAL("clicked()"), self.stopDaemon)
        self.connect(self.addButton, SIGNAL("clicked()"), self.showAddDaemonDialog)
        self.connect(self.removeButton, SIGNAL("clicked()"), self.removeCurrentDaemon)

    def parse(self):
        fileParser = Arxin.fileParser()
        fileParser.openFile("/etc/rc.conf")
        enabled = fileParser.getOption("DAEMONS", fileParser.ParLine).split(" ")
        #print fileParser.getOption("DAEMONS", fileParser.getOptionType("DAEMONS"))
        print enabled
        self.dirParser.loadDirectory("/etc/rc.d/")
        disabled = self.dirParser.getAllDirectoryEntries()
        for daemon in enabled:
            background = False
            if daemon.startswith("@") == True:
                background = True
                daemon = daemon[1:len(daemon)]
            if daemon in disabled:
                disabled.remove(daemon)
            self.addDaemon(daemon, self.description(daemon), background)
        
        for daemon in disabled:
            self.addDialog.addDaemon(daemon, self.description(daemon))

        fileParser.deleteLater()


    def save(self):
        fileParser = Arxin.fileParser()
        fileParser.openFile("/etc/rc.conf")
        line = QString()
        i = 0
        while self.treeWidget.topLevelItem(i) != None:
            item = self.treeWidget.topLevelItem(i)
            linePart = item.text(0)
            if item.checkState(2) == Qt.Checked:
                linePart.prepend("@")
            line.append(linePart + " ")
            i = i + 1

        print line
        fileParser.setOption("DAEMONS", str(line), fileParser.ParLine)
        fileParser.writeChangesToFile()
        fileParser.deleteLater()

    def addDaemon(self, name, description, background):
        if len(name) == 0:
            return
        print name
        item = Daemon(name, description, background, self.treeWidget)
        item.setFlags(item.flags() & ~Qt.ItemIsDropEnabled)

    def addNewDaemon(self, name, description):
        if len(name) == 0:
            return
        print name
        item = Daemon(name, description, False, self.treeWidget)
        item.setFlags(item.flags() & ~Qt.ItemIsDropEnabled)
        

    def checkRunning(self):
        self.dirParser.loadDirectory("/var/run/daemons")
        self.running = self.dirParser.getAllDirectoryEntries()
        self.selectionChanged()

    def selectionChanged(self):
        if self.treeWidget.currentItem() == None:
            return
        itemRunning = self.treeWidget.currentItem().text(0) in self.running
        self.startButton.setDisabled(itemRunning)
        self.stopButton.setEnabled(itemRunning)

    def startDaemon(self):
        self.treeWidget.currentItem().startDaemon()
        self.checkRunning()

    def stopDaemon(self):
        self.treeWidget.currentItem().stopDaemon()
        self.checkRunning()

    def showAddDaemonDialog(self):
        self.addDialog.show()
        pass

    def removeCurrentDaemon(self):
        if self.treeWidget.currentItem() == None:
            return
        self.addDialog.addDaemon(self.treeWidget.currentItem().text(0), self.treeWidget.currentItem().text(1))
        self.treeWidget.takeTopLevelItem(self.treeWidget.indexOfTopLevelItem(self.treeWidget.currentItem()))
        pass

    def description(self, name):
        self.procParser.loadProcess(str("pacman -Qqo /etc/rc.d/" + name.strip('!')))
        self.procParser.startProcess()
        self.procParser.slotWaitForFinished()
        package = self.procParser.readAllStdOut()
        print package
        info = [] #FIXME: Do some proper error-handling
        if ' ' in package:
            self.procParser.loadProcess(str("pacman -Si " + package[:package.index(' ')]))
            self.procParser.startProcess()
            self.procParser.slotWaitForFinished()
            info = self.procParser.readAllStdOut()
        description = 'None'
        for line in info:
            if line.startswith('Description'):
                description = line[line.index(':')+2:]
                break
        print description
        return description

daemonsWidget = 0

def parseSection():
    global daemonsWidget
    daemonsWidget = ArxinDaemons(None)
    daemonsWidget.parse()
    Arxin.setWidget(daemonsWidget)


def saveSection():
    print "Save daemons"
    global daemonsWidget
    daemonsWidget.save()
