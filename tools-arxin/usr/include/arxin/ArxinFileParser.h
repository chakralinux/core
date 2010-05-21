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

#ifndef ARXINFILEPARSER_H_
#define ARXINFILEPARSER_H_

#include <iostream>
#include <QStringList>
#include "arxin_macros.h"

/** \class ArxinFileParser ArxinFileParser.h
 * \brief General configuration files parser.
 *
 * This class aims to provide a easy to use frontend to parse most common
 * configuration files. It is buffered (so calling parsing functions is
 * really fast) and modular, and adding another kind of syntax is fairly
 * easy to do.
 * ArxinFileParser is easily extendable to read a variety of syntaxes.
 * Adding another line type it's so easy: add a type to LineType and
 * add the behaviour in the code at getOption and setOption.
 *
 * Arxin is easy: with just a pair of lines of code you can have everything
 * you need. Look at this example:
 *
 * \code
 * parser.openFile("/etc/rc.conf");
 * qDebug() << parser.getOption("DAEMONS", ParLine);
 * qDebug() << parser.getOption("gateway", IniLine);
 * parser.closeFile();
 * \endcode
 *
 * This shows in the terminal the value of DAEMONS and gateway in
 * rc.conf. It's just 4 lines of code! And you can parse and write almost
 * every file.
 */

class ARXIN_EXPORT ArxinFileParser : public QObject
{
    Q_OBJECT
    Q_ENUMS(LineType)
    Q_ENUMS(LineStatus)
    Q_ENUMS(SetBehaviour)
    Q_ENUMS(IntervalBehaviour)
public:
    /**
    * \enum LineType
    *
    * This enum contains all available kind of line syntax Arxin is able to
    * parse.
    * @see ArxinFileParser::getOption()
    */
    enum LineType {
        /** Lines of type KEY="values" */
        IniLine = 0,
        /** Lines of type KEY=(values) */
        ParLine = 1,
        /** Lines of type KEY=values */
        IniNoQuotesLine = 2,
        /** Lines of type KEY='values' */
        IniSingleQuotesLine = 4,
        /** Reserved, for errors */
        Error = 10
    };

    /**
    * \enum LineStatus
    *
    * This enum defines if the line is commented or not
    * @see ArxinFileParser::getOption()
    */
    enum LineStatus {
        /** Commented Line */
        Commented = 0,
        /** Uncommented Line */
        Uncommented = 1
    };

    /**
    * \enum SetBehaviour
    *
    * This enum defines the behaviour when setting an option
    * @see ArxinFileParser::setOption()
    */
    enum SetBehaviour {
        /** Try to search through commented lines first */
        UncommentIfExists = 0,
        /** Do not delete, comment only */
        CommentOnDelete = 1
    };

    /**
    * \enum IntervalBehaviour
    *
    * This enum defines the behaviour when searching into an interval
    * @see ArxinFileParser::getKeysInInterval()
    */
    enum IntervalBehaviour {
        /** Searches through commented lines for defining interval extremes */
        SearchThroughCommented = 0,
        /** Includes also commented lines in the return list */
        IncludeCommentedLines = 1,
        /** Include the left extreme in the return list */
        IncludeLeftExtreme = 2,
        /** Include the right extreme in the return list */
        IncludeRightExtreme = 4,
        /** Include both extremes in the return list */
        IncludeExtremes = 8
    };

    /**
    * \struct arxKey
    * In this structure is contained all the data about a key, including its value
    * @see ArxinFileParser::getKeysInInterval()
    */
    struct ArxinKey {
        /** The key name */
        QString name;
        /** The key's value */
        QString value;
        /** Line status */
        LineStatus status;
        /** Type of key */
        LineType type;
    };
    typedef QList<ArxinKey> QArxinKeysList;//TODO: Change to QFlags

    ArxinFileParser(QObject *parent = 0);
    virtual ~ArxinFileParser();


public slots:
    /**
    * Opens a file. The file will be loaded and used for parsing in
    * other methods.
    * @see closeFile()
    * @param name The name of the file.
    * @param woc Determines if the file will be written upon closing (default: true)
    * @returns true on success, false on failure
    */
    bool openFile(const QString &name, bool woc = true);

    /**
    * Close the current opened file.
    * @see openFile()
    */
    void closeFile();

    /**
    * Gets an option from the current file.
    * @see openFile()
    * @param key The key associated with this option.
    * @param typeline Defines what is the type of the line processed.
    * @param linestat Defines if the option is uncommented or not (default: Uncommented)
    * @returns The requested option, or an empty QString on failure.
    */
    QString getOption(const QString &key, LineType typeline,
                      LineStatus linestat = Uncommented);

    QString getOption(const QString &key);//TODO: Apidox

    /**
    * Sets an option in the current file. Note that this operation does not
    * edits the file itself, you have to call writeChangesToFile() to apply changes.
    * @see openFile()
    * @see writeChangesToFile()
    * @param key The key associated with this option.
    * @param value The value to write to the file.
    * @param typeline Defines what is the type of the line processed.
    * @param tryAdding Tells the parser if it should add the line if it does not exist.
    * If it is set to false and the requested key does not exists, it won't be added (default: true)
    * @param setbh Tells the parser if it should try to restore the option from a commented entry
    * @returns true on success, false on failure
    */
    bool setOption(const QString &key, const QString &value, LineType typeline,
                   bool tryAdding = true, SetBehaviour setbh = UncommentIfExists);

    /**
    * Removes an option in the current file. Note that this operation does not
    * edits the file itself, you have to call writeChangesToFile() to apply changes.
    * @see openFile()
    * @see writeChangesToFile()
    * @param key The key associated with this option.
    * @returns true on success, false on failure
    */
    bool deleteOption(const QString &key);

    /**
    * Comments an option in the current file. Note that this operation does not
    * edits the file itself, you have to call writeChangesToFile() to apply changes.
    * @see openFile()
    * @see writeChangesToFile()
    * @param key The key associated with this option.
    * @returns true on success, false on failure
    */
    bool commentOption(const QString &key);

    /**
    * Gets the type of an option, or an error if the format is not recognized
    * @see getOption()
    * @param key The key associated with this option.
    * @returns The type of the option on success, an error on failure
    */
    LineType getOptionType(const QString &key);


    /**
    * Gets all the keys in a defined interval between two keys. This returns a list of
    * ArxinKeys you can use to get values from.
    * @see openFile()
    * @see getOption()
    * @param startingKey The key to start from
    * @param endingKey The key that ends the interval
    * @param behaviour A list of Miscellaneous options to refine the results.
    * @returns All the keys in the interval, or an empty list on failure.
    */
    QArxinKeysList getKeysInInterval(const QString &startingKey, const QString &endingKey,
                                     QList<IntervalBehaviour> behaviour = QList<IntervalBehaviour>());

    /**
    * Sets an option in the current file, inside the given interval. Note that this operation does not
    * edits the file itself, you have to call writeChangesToFile() to apply changes.
    * It is pretty much an equivalent of setOption(), but you can define where the key will be
    * inserted.
    * @see openFile()
    * @see writeChangesToFile()
    * @see setOption()
    * @param startingKey The key to start from
    * @param endingKey The key that ends the interval
    * @param key The key associated with this option.
    * @param value The value to write to the file.
    * @param typeline Defines what is the type of the line processed.
    * @param tryAdding Tells the parser if it should add the line if it does not exist.
    * If it is set to false and the requested key does not exists, it won't be added (default: true)
    * @param setbh Tells the parser if it should try to restore the option from a commented entry
    * @returns true on success, false on failure
    */
    /**bool setOptionInInterval(const QString &startingKey, const QString &endingKey, const QString &key,
      const QString &value, LineType typeline, bool tryAdding = true,
      SetBehaviour setbh = UncommentIfExists) {}//TODO: Implement this**/

    /**
    * This function is called to actually save any changes to the opened file.
    * It is called upon closing if the file was opened with woc = true.
    * @see openFile()
    * @see closeFile()
    * @returns true on success, false on failure
    */
    bool writeChangesToFile();


    /**
    * Tells if the current file is opened or not
    * @see openFile()
    * @see closeFile()
    * @returns true if the file is opened, false if it is not
    */
    bool fileIsOpen();

    /**
     * Tells if the current file is opened and has contents
     * @see openFile()
     * @see closeFile()
     * @returns true if the file is opened and has contents, false if not
     */
    bool fileHasContents();

    /**
    * Tells if the current file has unsaved modifications
    * @see openFile()
    * @see closeFile()
    * @see writeChangesToFile()
    * @returns true if the file has unsaved modifications, false if it has not
    */
    bool fileIsModified();

    /**
     * @param option the option to check
     * @returns true if the option exists
     */
    bool optionExists(const QString &option);

    /**
    * Sets the root prefix for file loading. You usually don't need to call this function,
    * it is useful just when chrooting
    */
    static void setRootPrefix(const QString &prefix);

private:
    class Private;
    Private *d;
};

#endif /*ARXINFILEPARSER_H_*/
