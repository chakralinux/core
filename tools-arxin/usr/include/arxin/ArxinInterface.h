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

#ifndef ARXININTERFACE_H
#define ARXININTERFACE_H

#include "arxin_macros.h"

#include <QtCore/QObject>

/** \class ArxinInterface ArxinInterface.h
 * \brief Interface for Arxin KPart.
 *
 * This class extends Arxin KPart functionalities. You can easily embed
 * Arxin in an application and control it through this interface.
 * Here is a small example:
 *
 * \code
 *  KPluginFactory* factory = KPluginLoader("libarxin_part").factory();
 *  KParts::ReadOnlyPart* part = factory ? ( factory->create<KParts::ReadOnlyPart>(this) ) : 0;
 *
 *  ArxinInterface *iface = qobject_cast<ArxinInterface *>(part);
 * \endcode
 *
 * This creates an empty KPart of Arxin and creates an interface to it in iface.
 * You can now use the functions provided in the interface to load Plugins,
 * set paths and more.
 */

class MainWindow;

class ARXIN_EXPORT ArxinInterface
{
public:
    ArxinInterface(MainWindow *mW);
    ArxinInterface();
    virtual ~ArxinInterface();

    /**
     * Sets the root path. This is the equivalent of ArxinFileParser::setRootPrefix()
     * @see ArxinFileParser::setRootPrefix()
     * @param path The new root path. It has to start with '/' and should have no trailing slash
     */
    void setRootPath(const QString &path);

    /**
     * Loads all the enabled plugins. This function needs to be explicitely called, otherwise
     * no plugins will get loaded. Remember to call setRootPath _ALWAYS_ before calling loadPlugins()
     * @see setRootPath()
     */
    void loadPlugins();

    /**
     * Sets mW as the new MainWindow Object for the KPart. Don't call this function unless you
     * know what you're doing.
     * @param mW a instantiated MainWindow object
     */
    void setMainWindowObject(MainWindow *mW);

private:
    MainWindow *m_main;
};

Q_DECLARE_INTERFACE(ArxinInterface, "org.kde.ArxinInterface")

#endif /*ARXININTERFACE_H*/
