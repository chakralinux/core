# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'ui/arxinAddDaemonsWidget.ui'
#
# Created: Thu Dec 25 21:16:47 2008
#      by: PyQt4 UI code generator 4.4.4
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui
from PyKDE4.kdeui import KTreeWidgetSearchLineWidget

class Ui_ArxinAddDaemonsWidget(object):
    def setupUi(self, ArxinAddDaemonsWidget):
        ArxinAddDaemonsWidget.setObjectName("ArxinAddDaemonsWidget")
        ArxinAddDaemonsWidget.resize(400, 300)
        self.gridLayout = QtGui.QGridLayout(ArxinAddDaemonsWidget)
        self.gridLayout.setObjectName("gridLayout")
        self.searchLine = KTreeWidgetSearchLineWidget(ArxinAddDaemonsWidget)
        self.searchLine.setObjectName("searchLine")
        self.gridLayout.addWidget(self.searchLine, 0, 0, 1, 1)
        self.treeWidget = QtGui.QTreeWidget(ArxinAddDaemonsWidget)
        self.treeWidget.setObjectName("treeWidget")
        self.gridLayout.addWidget(self.treeWidget, 1, 0, 1, 1)

        self.retranslateUi(ArxinAddDaemonsWidget)
        QtCore.QMetaObject.connectSlotsByName(ArxinAddDaemonsWidget)

    def retranslateUi(self, ArxinAddDaemonsWidget):
        ArxinAddDaemonsWidget.setWindowTitle(QtGui.QApplication.translate("ArxinAddDaemonsWidget", "Form", None, QtGui.QApplication.UnicodeUTF8))
        self.treeWidget.headerItem().setText(0, QtGui.QApplication.translate("ArxinAddDaemonsWidget", "Name", None, QtGui.QApplication.UnicodeUTF8))
        self.treeWidget.headerItem().setText(1, QtGui.QApplication.translate("ArxinAddDaemonsWidget", "Description", None, QtGui.QApplication.UnicodeUTF8))