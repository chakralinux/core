# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'ui/arxinLocale.ui'
#
# Created: Wed May  7 05:36:27 2008
#      by: PyQt4 UI code generator 4.3.3
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

class Ui_ArxinLocale(object):
    def setupUi(self, ArxinLocale):
        ArxinLocale.setObjectName("ArxinLocale")
        ArxinLocale.resize(QtCore.QSize(QtCore.QRect(0,0,568,345).size()).expandedTo(ArxinLocale.minimumSizeHint()))

        self.gridlayout = QtGui.QGridLayout(ArxinLocale)
        self.gridlayout.setObjectName("gridlayout")

        self.groupBox_2 = QtGui.QGroupBox(ArxinLocale)
        self.groupBox_2.setObjectName("groupBox_2")

        self.gridlayout1 = QtGui.QGridLayout(self.groupBox_2)
        self.gridlayout1.setObjectName("gridlayout1")

        self.label_12 = QtGui.QLabel(self.groupBox_2)
        self.label_12.setObjectName("label_12")
        self.gridlayout1.addWidget(self.label_12,0,0,1,1)

        self.keymapCombo = QtGui.QComboBox(self.groupBox_2)
        self.keymapCombo.setObjectName("keymapCombo")
        self.gridlayout1.addWidget(self.keymapCombo,0,1,1,1)

        self.label_9 = QtGui.QLabel(self.groupBox_2)
        self.label_9.setObjectName("label_9")
        self.gridlayout1.addWidget(self.label_9,1,0,1,1)

        self.consoleFont = QtGui.QComboBox(self.groupBox_2)
        self.consoleFont.setObjectName("consoleFont")
        self.gridlayout1.addWidget(self.consoleFont,1,1,1,1)

        self.label_6 = QtGui.QLabel(self.groupBox_2)
        self.label_6.setObjectName("label_6")
        self.gridlayout1.addWidget(self.label_6,2,0,1,1)

        self.consoleMap = QtGui.QComboBox(self.groupBox_2)
        self.consoleMap.setObjectName("consoleMap")
        self.gridlayout1.addWidget(self.consoleMap,2,1,1,1)

        self.colorCheck = QtGui.QCheckBox(self.groupBox_2)
        self.colorCheck.setEnabled(True)
        self.colorCheck.setChecked(False)
        self.colorCheck.setObjectName("colorCheck")
        self.gridlayout1.addWidget(self.colorCheck,3,0,1,2)
        self.gridlayout.addWidget(self.groupBox_2,3,0,1,4)

        self.label = QtGui.QLabel(ArxinLocale)
        self.label.setObjectName("label")
        self.gridlayout.addWidget(self.label,0,0,1,1)

        self.localeCombo = QtGui.QComboBox(ArxinLocale)
        self.localeCombo.setObjectName("localeCombo")
        self.gridlayout.addWidget(self.localeCombo,0,2,1,1)

        self.groupBox = QtGui.QGroupBox(ArxinLocale)
        self.groupBox.setObjectName("groupBox")

        self.gridlayout2 = QtGui.QGridLayout(self.groupBox)
        self.gridlayout2.setObjectName("gridlayout2")

        self.label_4 = QtGui.QLabel(self.groupBox)
        self.label_4.setObjectName("label_4")
        self.gridlayout2.addWidget(self.label_4,0,0,1,1)

        self.hardwareclockCombo = QtGui.QComboBox(self.groupBox)
        self.hardwareclockCombo.setObjectName("hardwareclockCombo")
        self.gridlayout2.addWidget(self.hardwareclockCombo,0,1,1,1)

        self.label_5 = QtGui.QLabel(self.groupBox)
        self.label_5.setObjectName("label_5")
        self.gridlayout2.addWidget(self.label_5,1,0,1,1)

        self.timeCombo = QtGui.QComboBox(self.groupBox)
        self.timeCombo.setObjectName("timeCombo")
        self.gridlayout2.addWidget(self.timeCombo,1,1,1,1)
        self.gridlayout.addWidget(self.groupBox,2,0,1,4)

        self.retranslateUi(ArxinLocale)
        QtCore.QMetaObject.connectSlotsByName(ArxinLocale)

    def retranslateUi(self, ArxinLocale):
        ArxinLocale.setWindowTitle(QtGui.QApplication.translate("ArxinLocale", "Form", None, QtGui.QApplication.UnicodeUTF8))
        self.groupBox_2.setTitle(QtGui.QApplication.translate("ArxinLocale", "Console", None, QtGui.QApplication.UnicodeUTF8))
        self.label_12.setText(QtGui.QApplication.translate("ArxinLocale", "Keymap:", None, QtGui.QApplication.UnicodeUTF8))
        self.label_9.setText(QtGui.QApplication.translate("ArxinLocale", "Console Font:", None, QtGui.QApplication.UnicodeUTF8))
        self.label_6.setText(QtGui.QApplication.translate("ArxinLocale", "Console Map:", None, QtGui.QApplication.UnicodeUTF8))
        self.colorCheck.setText(QtGui.QApplication.translate("ArxinLocale", "Use colors in startup messages", None, QtGui.QApplication.UnicodeUTF8))
        self.label.setText(QtGui.QApplication.translate("ArxinLocale", "Locale:", None, QtGui.QApplication.UnicodeUTF8))
        self.groupBox.setTitle(QtGui.QApplication.translate("ArxinLocale", "Time", None, QtGui.QApplication.UnicodeUTF8))
        self.label_4.setText(QtGui.QApplication.translate("ArxinLocale", "Hardware Clock:", None, QtGui.QApplication.UnicodeUTF8))
        self.label_5.setText(QtGui.QApplication.translate("ArxinLocale", "Time Zone:", None, QtGui.QApplication.UnicodeUTF8))

