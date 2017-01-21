#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QUrl>

class FileIO : public QObject
{
    Q_OBJECT

public:
    explicit FileIO(QObject * parent = 0);

    Q_PROPERTY(QUrl source
               READ source
               WRITE setSource
               NOTIFY sourceChanged)


    QUrl source();

public slots:
    QString read();
    bool write(const QString & data);
    void setSource(const QUrl & source);
    int getLastLineNum();

signals:
    void sourceChanged(const QUrl & source);
    void error(const QString & msg);

private:
    QUrl mSource;
};

#endif // FILEIO_H
