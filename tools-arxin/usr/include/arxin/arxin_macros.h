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

#ifndef ARXIN_MACROS_H
#define ARXIN_MACROS_H

/** \file arxin_macros.h
    \brief Contains Macros used in Arxin

    This contains some macros that help in exporting/importing symbols and plugins
*/

#include <kdemacros.h>

/** \addtogroup ArxinMacros
*  Documentation for Arxin Macros
*  @{
*/

/**
* @def ARXIN_EXPORT
*
* Reserved macro to export GCC visibility in libraries. Used only in core classes declarations.
*/

#define ARXIN_EXPORT __attribute__ ((visibility("default")))

/**
 * @def ARXIN_PLUGIN_EXPORT
 *
 * The ARXIN_PLUGIN_EXPORT macro is a convenience wrapper around KDE's plugin
 * declaration. This definition is <b>needed</b> when you're exporting a plugin in Arxin.
 *
 * It is a good pratice to declare it in a separate file, to allow using the same source
 * files for generating a systemsettings plugin. The declaration is done through an identifier and
 * the name of the class you're exporting.
 *
 * So, supposing you're creating the plugin foo, and your class is named ArxinFoo. Let's see how the file
 * ArxinFooExport.cpp looks like:
 *
 * \code
 * #include "ArxinFoo.h"
 * #include "arxin_macros.h"
 * #include "src/ArxinAbstractSection.h"
 * #include "arxin_macros.h"
 *
 * #include <kdemacros.h>
 * #include <KPluginFactory>
 * #include <KPluginLoader>
 *
 * ARXIN_PLUGIN_EXPORT(ArxinFoo);
 *
 * \endcode
 *
 * And that's all, add the file ArxinFooExport to your targets and you're done.
 *
 * @param c The name of the class you're going to export.
 *
 * @see ArxinAbstractSection
 */

#define ARXIN_PLUGIN_EXPORT( c ) \
    K_PLUGIN_FACTORY( ArxinFactory, registerPlugin< c >(); ) \
    K_EXPORT_PLUGIN( ArxinFactory("c") )

/**
* @def ARXIN_PLUGIN_IMPORT
*
* Reserved macro to import a plugin into Arxin executable. It performs a qobject_cast on the given item
* to the Arxin Plugin Interface.
*/

#define ARXIN_PLUGIN_IMPORT( C ) qobject_cast<ArxinAbstractSection *>(C)

/**
* @def ARXIN_SCRIPTED_PLUGIN_IMPORT
*
* Reserved macro to import a plugin into Arxin executable. It performs a qobject_cast on the given item
* to the Arxin Plugin Interface.
*/

#define ARXIN_SCRIPTED_PLUGIN_IMPORT( C ) qobject_cast<BaseScriptedPlugin *>(C)

/** @} */

#endif /*ARXIN_MACROS_H*/
