# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'ui/arxinHardware.ui'
#
# Created: Wed May 14 15:48:40 2008
#      by: PyQt4 UI code generator 4.3.3
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

class Ui_ArxinHardware(object):
    def setupUi(self, ArxinHardware):
        ArxinHardware.setObjectName("ArxinHardware")
        ArxinHardware.resize(QtCore.QSize(QtCore.QRect(0,0,624,456).size()).expandedTo(ArxinHardware.minimumSizeHint()))

        self.gridlayout = QtGui.QGridLayout(ArxinHardware)
        self.gridlayout.setObjectName("gridlayout")

        self.scanHardwareCheck = QtGui.QCheckBox(ArxinHardware)
        self.scanHardwareCheck.setObjectName("scanHardwareCheck")
        self.gridlayout.addWidget(self.scanHardwareCheck,0,0,1,2)

        self.scanLVMCheck = QtGui.QCheckBox(ArxinHardware)
        self.scanLVMCheck.setObjectName("scanLVMCheck")
        self.gridlayout.addWidget(self.scanLVMCheck,1,0,1,2)

        self.groupBox_3 = QtGui.QGroupBox(ArxinHardware)
        self.groupBox_3.setObjectName("groupBox_3")

        self.gridlayout1 = QtGui.QGridLayout(self.groupBox_3)
        self.gridlayout1.setObjectName("gridlayout1")

        self.modWidget = QtGui.QTreeWidget(self.groupBox_3)
        self.modWidget.setObjectName("modWidget")
        self.gridlayout1.addWidget(self.modWidget,0,0,8,4)

        self.addModButton = QtGui.QPushButton(self.groupBox_3)
        self.addModButton.setMaximumSize(QtCore.QSize(90,16777215))

        self.addModButton.setObjectName("addModButton")
        self.gridlayout1.addWidget(self.addModButton,0,4,1,1)

        self.removeModButton = QtGui.QPushButton(self.groupBox_3)
        self.removeModButton.setMaximumSize(QtCore.QSize(90,16777215))

        self.removeModButton.setObjectName("removeModButton")
        self.gridlayout1.addWidget(self.removeModButton,1,4,1,1)

        self.loadModButton = QtGui.QPushButton(self.groupBox_3)
        self.loadModButton.setMaximumSize(QtCore.QSize(90,16777215))
        self.loadModButton.setObjectName("loadModButton")
        self.gridlayout1.addWidget(self.loadModButton,2,4,1,1)

        self.unloadModButton = QtGui.QPushButton(self.groupBox_3)
        self.unloadModButton.setMaximumSize(QtCore.QSize(90,16777215))
        self.unloadModButton.setObjectName("unloadModButton")
        self.gridlayout1.addWidget(self.unloadModButton,3,4,1,1)
        self.gridlayout.addWidget(self.groupBox_3,2,0,1,2)

        self.groupBox_4 = QtGui.QGroupBox(ArxinHardware)
        self.groupBox_4.setObjectName("groupBox_4")

        self.gridlayout2 = QtGui.QGridLayout(self.groupBox_4)
        self.gridlayout2.setObjectName("gridlayout2")

        self.modblackWidget = QtGui.QTreeWidget(self.groupBox_4)
        self.modblackWidget.setObjectName("modblackWidget")
        self.gridlayout2.addWidget(self.modblackWidget,7,0,3,1)

        self.removeModblackButton = QtGui.QPushButton(self.groupBox_4)
        self.removeModblackButton.setMaximumSize(QtCore.QSize(90,16777215))

        self.removeModblackButton.setObjectName("removeModblackButton")
        self.gridlayout2.addWidget(self.removeModblackButton,8,2,1,1)

        self.addModblackButton = QtGui.QPushButton(self.groupBox_4)
        self.addModblackButton.setMaximumSize(QtCore.QSize(90,16777215))

        self.addModblackButton.setObjectName("addModblackButton")
        self.gridlayout2.addWidget(self.addModblackButton,7,2,1,1)
        self.gridlayout.addWidget(self.groupBox_4,3,0,1,2)

        self.retranslateUi(ArxinHardware)
        QtCore.QMetaObject.connectSlotsByName(ArxinHardware)
        ArxinHardware.setTabOrder(self.scanHardwareCheck,self.scanLVMCheck)
        ArxinHardware.setTabOrder(self.scanLVMCheck,self.modWidget)
        ArxinHardware.setTabOrder(self.modWidget,self.addModButton)
        ArxinHardware.setTabOrder(self.addModButton,self.removeModButton)
        ArxinHardware.setTabOrder(self.removeModButton,self.loadModButton)
        ArxinHardware.setTabOrder(self.loadModButton,self.unloadModButton)
        ArxinHardware.setTabOrder(self.unloadModButton,self.modblackWidget)
        ArxinHardware.setTabOrder(self.modblackWidget,self.addModblackButton)
        ArxinHardware.setTabOrder(self.addModblackButton,self.removeModblackButton)

    def retranslateUi(self, ArxinHardware):
        ArxinHardware.setWindowTitle(QtGui.QApplication.translate("ArxinHardware", "Form", None, QtGui.QApplication.UnicodeUTF8))
        self.scanHardwareCheck.setText(QtGui.QApplication.translate("ArxinHardware", "Scan hardware and load required modules at bootup", None, QtGui.QApplication.UnicodeUTF8))
        self.scanLVMCheck.setText(QtGui.QApplication.translate("ArxinHardware", "Scan for LVM volume groups at startup", None, QtGui.QApplication.UnicodeUTF8))
        self.groupBox_3.setTitle(QtGui.QApplication.translate("ArxinHardware", "Modules", None, QtGui.QApplication.UnicodeUTF8))
        self.modWidget.headerItem().setText(0,QtGui.QApplication.translate("ArxinHardware", "Name", None, QtGui.QApplication.UnicodeUTF8))
        self.modWidget.headerItem().setText(1,QtGui.QApplication.translate("ArxinHardware", "Description", None, QtGui.QApplication.UnicodeUTF8))
        self.modWidget.headerItem().setText(2,QtGui.QApplication.translate("ArxinHardware", "Status", None, QtGui.QApplication.UnicodeUTF8))
        self.addModButton.setText(QtGui.QApplication.translate("ArxinHardware", "Add...", None, QtGui.QApplication.UnicodeUTF8))
        self.removeModButton.setText(QtGui.QApplication.translate("ArxinHardware", "Remove", None, QtGui.QApplication.UnicodeUTF8))
        self.loadModButton.setText(QtGui.QApplication.translate("ArxinHardware", "Load", None, QtGui.QApplication.UnicodeUTF8))
        self.unloadModButton.setText(QtGui.QApplication.translate("ArxinHardware", "Unload", None, QtGui.QApplication.UnicodeUTF8))
        self.groupBox_4.setTitle(QtGui.QApplication.translate("ArxinHardware", "Modules blacklist", None, QtGui.QApplication.UnicodeUTF8))
        self.modblackWidget.headerItem().setText(0,QtGui.QApplication.translate("ArxinHardware", "Name", None, QtGui.QApplication.UnicodeUTF8))
        self.modblackWidget.headerItem().setText(1,QtGui.QApplication.translate("ArxinHardware", "Description", None, QtGui.QApplication.UnicodeUTF8))
        self.removeModblackButton.setText(QtGui.QApplication.translate("ArxinHardware", "Remove", None, QtGui.QApplication.UnicodeUTF8))
        self.addModblackButton.setText(QtGui.QApplication.translate("ArxinHardware", "Add...", None, QtGui.QApplication.UnicodeUTF8))

