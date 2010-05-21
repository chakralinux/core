# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'ui/arxinDaemons.ui'
#
# Created: Thu Dec 25 20:38:30 2008
#      by: PyQt4 UI code generator 4.4.4
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

class Ui_ArxinDaemons(object):
    def setupUi(self, ArxinDaemons):
        ArxinDaemons.setObjectName("ArxinDaemons")
        ArxinDaemons.resize(601, 363)
        self.gridLayout = QtGui.QGridLayout(ArxinDaemons)
        self.gridLayout.setObjectName("gridLayout")
        self.treeWidget = QtGui.QTreeWidget(ArxinDaemons)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.MinimumExpanding, QtGui.QSizePolicy.MinimumExpanding)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.treeWidget.sizePolicy().hasHeightForWidth())
        self.treeWidget.setSizePolicy(sizePolicy)
        self.treeWidget.setEditTriggers(QtGui.QAbstractItemView.NoEditTriggers)
        self.treeWidget.setDragDropMode(QtGui.QAbstractItemView.InternalMove)
        self.treeWidget.setRootIsDecorated(False)
        self.treeWidget.setItemsExpandable(False)
        self.treeWidget.setAnimated(True)
        self.treeWidget.setExpandsOnDoubleClick(False)
        self.treeWidget.setColumnCount(3)
        self.treeWidget.setObjectName("treeWidget")
        self.gridLayout.addWidget(self.treeWidget, 0, 0, 3, 1)
        self.hboxlayout = QtGui.QHBoxLayout()
        self.hboxlayout.setObjectName("hboxlayout")
        spacerItem = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.hboxlayout.addItem(spacerItem)
        self.startButton = QtGui.QPushButton(ArxinDaemons)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap(":/Icons/icons/dialog-ok-apply.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.startButton.setIcon(icon)
        self.startButton.setObjectName("startButton")
        self.hboxlayout.addWidget(self.startButton)
        self.stopButton = QtGui.QPushButton(ArxinDaemons)
        icon1 = QtGui.QIcon()
        icon1.addPixmap(QtGui.QPixmap(":/Icons/icons/edit-delete.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.stopButton.setIcon(icon1)
        self.stopButton.setObjectName("stopButton")
        self.hboxlayout.addWidget(self.stopButton)
        self.gridLayout.addLayout(self.hboxlayout, 3, 0, 1, 1)
        self.addButton = QtGui.QPushButton(ArxinDaemons)
        self.addButton.setObjectName("addButton")
        self.gridLayout.addWidget(self.addButton, 0, 1, 1, 1)
        spacerItem1 = QtGui.QSpacerItem(20, 40, QtGui.QSizePolicy.Minimum, QtGui.QSizePolicy.Expanding)
        self.gridLayout.addItem(spacerItem1, 2, 1, 1, 1)
        self.removeButton = QtGui.QPushButton(ArxinDaemons)
        self.removeButton.setObjectName("removeButton")
        self.gridLayout.addWidget(self.removeButton, 1, 1, 1, 1)

        self.retranslateUi(ArxinDaemons)
        QtCore.QMetaObject.connectSlotsByName(ArxinDaemons)

    def retranslateUi(self, ArxinDaemons):
        ArxinDaemons.setWindowTitle(QtGui.QApplication.translate("ArxinDaemons", "Form", None, QtGui.QApplication.UnicodeUTF8))
        self.treeWidget.headerItem().setText(0, QtGui.QApplication.translate("ArxinDaemons", "Name", None, QtGui.QApplication.UnicodeUTF8))
        self.treeWidget.headerItem().setText(1, QtGui.QApplication.translate("ArxinDaemons", "Description", None, QtGui.QApplication.UnicodeUTF8))
        self.treeWidget.headerItem().setText(2, QtGui.QApplication.translate("ArxinDaemons", "Start in Background", None, QtGui.QApplication.UnicodeUTF8))
        self.startButton.setText(QtGui.QApplication.translate("ArxinDaemons", "Start", None, QtGui.QApplication.UnicodeUTF8))
        self.stopButton.setText(QtGui.QApplication.translate("ArxinDaemons", "Stop", None, QtGui.QApplication.UnicodeUTF8))
        self.addButton.setText(QtGui.QApplication.translate("ArxinDaemons", "Add...", None, QtGui.QApplication.UnicodeUTF8))
        self.removeButton.setText(QtGui.QApplication.translate("ArxinDaemons", "Remove", None, QtGui.QApplication.UnicodeUTF8))

