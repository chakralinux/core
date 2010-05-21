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

#ifndef ARXINDIRECTORYPARSER_H_
#define ARXINDIRECTORYPARSER_H_

#include <iostream>
#include <QStringList>
#include "arxin_macros.h"

/** \class ArxinDirectoryParser ArxinDirectoryParser.h
 * \brief General directory entries parser.
 *
 * This class lets you scan directories in a fast, intuitive and easy
 * way. You can use it barely for getting all directory entries or for
 * making a filtered search.
 *
 * Usage is really simple: after selecting the working directory, you can
 * set up a configuration for scanning it. Then, you can get all its entries
 * (according to the configuration you issued), or have just some entries based
 * on a filter.
 */

class ARXIN_EXPORT ArxinDirectoryParser : public QObject
{
    Q_OBJECT
    Q_ENUMS(dirParsingOptions)
public:
    struct DirectoryConfiguration {
        bool recursive;
        bool filesOnly;
        QString extension;
        bool trimextension;
        bool prependRelativePath;

        QString dirName;
        bool dirOpen;
        QStringList dirContents;
    };

    /**
    * \enum dirParsingOptions
    *
    * This enum contains all the flags that can be issued to resetConfiguration
    * to define ArxinDirectoryParser configuration.
    * @see ArxinDirectoryParser::resetConfiguration()
    */
    enum dirParsingOptions {
        /** Scans directories recursively */
        Recursive,
        /** Adds files only to the entries */
        filesOnly,
        /** Trim the extension in the entries */
        trimExtension,
        /** Returns the full path instead of the name only in the entries */
        prependRelativePath,
        /** Default behaviour */
        defaultOptions
    };
    ArxinDirectoryParser(QObject *parent = 0);
    virtual ~ArxinDirectoryParser();

public slots:
    /**
    * Loads a directory. This will be the working directory.
    * @see closeDirectory()
    * @param dir The path to the directory.
    * @returns true on success, false on failure
    */
    bool loadDirectory(const QString &dir);

    /**
    * Closes the current working directory.
    * @see loadDirectory()
    * @returns true on success, false on failure
    */
    /**bool closeDirectory()**/

    //bool checkConfiguration(int need = 0);

    /**
    * Set up a new configuration for parsing directories. This is done by giving this
    * function some flags that can redefine some behaviours of the parser and an
    * extension, so that only files ending with .extension will be considered.
    * Call this function without arguments to restore it back to default behaviour.
    * @param parsingList The list of the Flags, blank for default
    * @param extension If defined, only files ending with .extension will be considered by the parser
    */
    void resetConfiguration(QList<dirParsingOptions> parsingList =
                                QList<dirParsingOptions>() << defaultOptions,
                            const QString &extension = QString());


    /**
    * Returns a list with all the directory entries. The result depends on the current
    * configuration of the parser.
    * @see resetConfiguration()
    * @returns A String List with all the entries
    */
    QStringList getAllDirectoryEntries();

    /**
    * Returns a list with all the directory entries, giving a possibility for a filter.
    * The result depends on the current configuration of the parser.
    * @see resetConfiguration()
    * @see getAllDirectoryEntries();
    * @param filter Only entries containing this word will be considered
    * @param nosubdirs Does not consider subdirectories (Default: true)
    * @returns A String List with all the filtered entries
    */
    /**QStringList getFilteredDirectoryEntries(const QString &filter, bool nosubdirs = true);**/

private:
    QStringList parseDirectory(const QString &addpath = QString());

private:
    DirectoryConfiguration dirConf;
};

#endif /*ARXINDIRECTORYPARSER_H_*/
