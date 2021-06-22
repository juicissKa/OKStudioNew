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
    //Класс project был нужен для более короткой загрузки проекта.
    //Подробная информация, зачем он был нужен, ниже.
    class project {
    public:
        QVector<QVector<bool>> allTracks;
        int soundcount;
        QVector<QString> soundnames;
        QVector<QString> soundpaths;
        int tracksCount;
        int interval;
    };

signals:

public slots:
    //Функция, возвращающая булевый вектор, состоящий из 40 значений false
    QVector<bool> lightedTrackflags();

    //Функция для проигрывания звука. soundpath - путь к проигрываемому звуку
    void playSound(QString soundpath);

    //Функция, возвращающая вектор с путями к стандартным, вшитым в программу звуками
    QVector<QString> soundpack();

    //Функция, создающая автоматическое название звука по его пути. sound_name - путь.
    QString soundname(QString sound_name);

    //Функция, преобразующая Url файла в путь. openedSound - Url файла.
    QString getSoundPath(QString openedSound);

    //Функция для сохранения проекта. allTracks - Вектор булевых векторов, содержащий
    //расположение каждого зажжённого и незажжённого деления каждого трека.
    //soundcount - количество загруженных в проект звуков
    //soundnames - названия каждых звуков
    //soundpaths - пути к звукам
    //tracksCount - длина треков в проекте
    //interval - bpm
    void saveProject(QVector<QVector<bool>> allTracks, int soundcount,
                     QVector<QString> soundnames, QVector<QString> soundpaths, int tracksCount,
                     int interval);

    //Функция записи данных из файла проекта в программу. filePath - путь к файлу проекта
    QList<QString> loadProject(QString filePath);

    //Функции получения данных из записанного проекта.
    //Я пытался сделать всё через собственный класс project,
    //но у меня не вышло сделать так, чтобы в qml файлах
    //мой класс определялся и пришлось сделать через большое число функций.
    QVector<bool> getTrack(QList<QString> project, int soundcount);
    int getSoundcount(QList<QString> project);
    QVector<QString> getSoundpaths(QList<QString> project, int soundcount);
    QVector<QString> getSoundnames(QList<QString> project, int soundcount);
    int getInterval(QList<QString> project);

    //Функция для проверки существования нужного аудиофайла. soundpath - путь к файлу.
    bool checkFile(QString soundpath);
};


#endif // HELPER_H
