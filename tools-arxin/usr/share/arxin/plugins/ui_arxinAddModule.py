# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'ui/arxinAddModule.ui'
#
# Created: Thu May  8 17:32:25 2008
#      by: PyQt4 UI code generator 4.3.3
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui
from PyKDE4.kdeui import KTreeWidgetSearchLineWidget

class Ui_ArxinAddModuleWidget(object):
    def setupUi(self, ArxinAddModuleWidget):
        ArxinAddModuleWidget.setObjectName("ArxinAddModuleWidget")
        ArxinAddModuleWidget.resize(QtCore.QSize(QtCore.QRect(0,0,400,293).size()).expandedTo(ArxinAddModuleWidget.minimumSizeHint()))

        self.gridlayout = QtGui.QGridLayout(ArxinAddModuleWidget)
        self.gridlayout.setObjectName("gridlayout")

        self.hboxlayout = QtGui.QHBoxLayout()
        self.hboxlayout.setObjectName("hboxlayout")

        self.ktreewidgetsearchlinewidget = KTreeWidgetSearchLineWidget(ArxinAddModuleWidget)
        self.ktreewidgetsearchlinewidget.setObjectName("ktreewidgetsearchlinewidget")
        self.hboxlayout.addWidget(self.ktreewidgetsearchlinewidget)

        self.searchByComboBox = QtGui.QComboBox(ArxinAddModuleWidget)
        self.searchByComboBox.setObjectName("searchByComboBox")
        self.hboxlayout.addWidget(self.searchByComboBox)
        self.gridlayout.addLayout(self.hboxlayout,0,0,1,1)

        self.modulesTreeWidget = QtGui.QTreeWidget(ArxinAddModuleWidget)
        self.modulesTreeWidget.setObjectName("modulesTreeWidget")
        self.gridlayout.addWidget(self.modulesTreeWidget,1,0,1,1)

        self.retranslateUi(ArxinAddModuleWidget)
        QtCore.QMetaObject.connectSlotsByName(ArxinAddModuleWidget)

    def retranslateUi(self, ArxinAddModuleWidget):
        ArxinAddModuleWidget.setWindowTitle(QtGui.QApplication.translate("ArxinAddModuleWidget", "Form", None, QtGui.QApplication.UnicodeUTF8))
        self.searchByComboBox.addItem(QtGui.QApplication.translate("ArxinAddModuleWidget", "Name", None, QtGui.QApplication.UnicodeUTF8))
        self.searchByComboBox.addItem(QtGui.QApplication.translate("ArxinAddModuleWidget", "Description", None, QtGui.QApplication.UnicodeUTF8))
        self.searchByComboBox.addItem(QtGui.QApplication.translate("ArxinAddModuleWidget", "Path", None, QtGui.QApplication.UnicodeUTF8))
        self.modulesTreeWidget.headerItem().setText(0,QtGui.QApplication.translate("ArxinAddModuleWidget", "Name", None, QtGui.QApplication.UnicodeUTF8))
        self.modulesTreeWidget.headerItem().setText(1,QtGui.QApplication.translate("ArxinAddModuleWidget", "Description", None, QtGui.QApplication.UnicodeUTF8))
        self.modulesTreeWidget.headerItem().setText(2,QtGui.QApplication.translate("ArxinAddModuleWidget", "Path", None, QtGui.QApplication.UnicodeUTF8))
        self.modulesTreeWidget.clear()

        item = QtGui.QTreeWidgetItem(self.modulesTreeWidget)
        item.setText(0,QtGui.QApplication.translate("ArxinAddModuleWidget", "b44", None, QtGui.QApplication.UnicodeUTF8))
        item.setText(1,QtGui.QApplication.translate("ArxinAddModuleWidget", "Broadcom 44xx/47xx 10/100 PCI ethernet driver", None, QtGui.QApplication.UnicodeUTF8))
        item.setText(2,QtGui.QApplication.translate("ArxinAddModuleWidget", "kernel/drivers/net", None, QtGui.QApplication.UnicodeUTF8))
