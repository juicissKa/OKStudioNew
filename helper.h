#ifndef HELPER_H
#define HELPER_H

#include <QObject>
#include <QtMultimedia/QSound>
#include <QFileInfo>
#include <QFile>
#include <QUrl>
#include <QVector>

class helper : public QObject
{
    Q_OBJECT
public:
    explicit helper(QObject *parent = nullptr);
    struct project {
    public:
        QVector<QVector<bool>> allTracks;
        int soundcount;
        QVector<QString> soundnames;
        QVector<QString> soundpaths;
        int tracksCount;

    };

signals:

public slots:
    QVector<bool> lightedTrackflags();
    void playSound(QString soundpath);
    QVector<QString> soundpack();
    QString soundname(QString sound_name);
    QString getSoundPath(QString openedSound);
    void saveProject(QVector<QVector<bool>> allTracks, int soundcount,
                     QVector<QString> soundnames, QVector<QString> soundpaths, int tracksCount,
                     int interval);
    QList<QString> loadProject(QString filePath);
    QVector<bool> getTrack(QList<QString> project, int soundcount);
    int getSoundcount(QList<QString> project);
    QVector<QString> getSoundpaths(QList<QString> project, int soundcount);
    QVector<QString> getSoundnames(QList<QString> project, int soundcount);
    int getInterval(QList<QString> project);
    bool checkFile(QString soundpath);
};


#endif // HELPER_H
