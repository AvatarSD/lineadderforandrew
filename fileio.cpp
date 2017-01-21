#include "fileio.h"
#include <QFile>
#include <QTextStream>
#include <QUrl>
#include <regex>
#include <QtDebug>

FileIO::FileIO(QObject * parent) :
    QObject(parent)
{

}

QUrl FileIO::source()
{
    return mSource;
}

void FileIO::setSource(const QUrl & source)
{
    mSource = source;
}

int FileIO::getLastLineNum()
{
    int lastLine = 0;
    if(mSource.isEmpty()) {
        emit error("source is empty");
        return lastLine;
    }

    QFile file(mSource.toLocalFile());

    if(file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug("opened for parse");

        QString line;
        std::regex pattern("^(\\d+)[.].*$");
        QTextStream filestream(&file);
        do {
            line = filestream.readLine();
            std::smatch res;
            std::string lineStd(line.toStdString());
            if(std::regex_match(lineStd, res, pattern)) {
                QString resStr(QString::fromStdString(res[1]));
                lastLine = resStr.toInt();
                qDebug() << "res str: " << resStr << "\tlast line: " << lastLine;
            }
        } while(!line.isNull());
        file.close();
    } else
        emit error("Unable to open the file");

    return lastLine;
}

QString FileIO::read()
{
    if(mSource.isEmpty()) {
        emit error("source is empty");
        return QString();
    }

    QFile file(mSource.toLocalFile());
    QString fileContent;
    if(file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QString line;
        QTextStream t(&file);
        do {
            line = t.readLine();
            fileContent += line;
        } while(!line.isNull());

        file.close();
    } else {
        emit error("Unable to open the file");
        return QString();
    }
    return fileContent;
}

bool FileIO::write(const QString & data)
{
    if(mSource.isEmpty())
        return false;

    QFile file(mSource.toLocalFile());
    if(!file.open(QFile::WriteOnly | QFile::Text | QIODevice::Append))
        return false;

    QTextStream out(&file);
    out << data;

    file.close();

    return true;
}
