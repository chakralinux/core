/***************************************************************************
 *   Copyright (C) 2008 by Dario Freddi                                    *
 *   drf54321@yahoo.it                                                     *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.          *
 ***************************************************************************/

#ifndef ARXINABSTRACTSECTION_H_
#define ARXINABSTRACTSECTION_H_

#include <QWidget>
#include <QVariantList>
#include <KIcon>

#include "ArxinParser"
#include "arxin_macros.h"

/**
* \class ArxinAbstractSection ArxinAbstractSection.h
*
* \brief The base class for Arxin Plugins
*
* Abstract Section is the class each plugin has to inherit from. It defines
* some basic methods all plugins should re-implement and it also provides a
* way to feed Arxin with some information about the plugin.
*
* Arxin also reimplements some macros to make it easier to export plugins.
* To see how to use ARXIN_PLUGIN_EXPORT refer to ArxinMacros documentation, where you can also
* see an example of an Export file.
*
* Let's say you're creating a plugin named Foo. Here is how your class declaration should
* look like:
*
* \code
* class ArxinFoo : public ArxinAbstractSection
* {
*  Q_OBJECT
*
* public:
* ArxinFoo(QObject *parent, const QVariantList &args);
* ~ArxinFoo();
*
* ArxinModule::moduleData getPluginData();
*
* public slots:
* void save();
*
* private:
* void parse();
* };
* \endcode
*
* Obviously, you can declare in this class almost anything you want: have a look at the Mkinitcpio
* plugin to have an idea of an "extended" plugin. What was shown above was the things you need absolutely
* to build a plugin. Watch out for the constructor arguments!
*
* So, suming up, creating a plugin is pretty easy, you just need to reimplement all virtual methods
* and declare a pair of macros. It is a good pratice to declare the ARXIN_PLUGIN_EXPORT macro
* inside a different file, such as *Export.cpp, so that the plugin may also be exported through
* KDE4 systemsettings. Refer to an example plugin for more details.
*/

class ARXIN_EXPORT ArxinAbstractSection : public QWidget
{
    Q_OBJECT

public:

    ArxinAbstractSection(QObject *parent, const QVariantList &args);
    virtual ~ArxinAbstractSection();

    virtual void loadScript(const QString &script);

public slots:
    /**
    * Calling this function tells the plugin to save to file the current fields.
    * So this slot is triggered whenever the Main Window or Systemsettings requires
    * to save.
    */
    virtual void save() = 0;

    /**
    * This function is called upon module loading. So it basically needs to parse the
    * file, and populate the fields with values from the file.
    */
    virtual void parse() = 0;
};

#endif /*ARXINABSTRACTSECTION_H_*/
