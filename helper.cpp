#include "helper.h"
#include <QtMultimedia/QSound>
#include <QDebug>
#include <QUrl>
#include <QFileDialog>
#include <QWidget>
#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFile>
#include <QMessageBox>
#include <QChar>
#include <iostream>

helper::helper(QObject *parent) : QObject(parent)
{

}


QVector<bool> helper::lightedTrackflags() {
    QVector<bool> lightedFlags {
        false, false, false, false, false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, false,
    };

    return lightedFlags;
}

void helper::playSound(QString soundpath) {
    QSound::play(soundpath);
}

QVector<QString> helper::soundpack() {
    QVector<QString> sounds = {
        ":/resources/Karma (Drum Kit)/Snares/SD - BabyBoy.wav",
        ":/resources/Karma (Drum Kit)/Snares/SD - Guap.wav",
        ":/resources/Karma (Drum Kit)/SD - Adios.wav",
        ":/resources/Karma (Drum Kit)/HiHats/HH - Burnt.wav",
        ":/resources/Karma (Drum Kit)/Crash/CR - Breeze.wav",
        ":/resources/Karma (Drum Kit)/Claps/Clp - Poof.wav"
    };

    return sounds;
}

QString helper::soundname(QString sound_name) {
    QFileInfo fileInfo(sound_name);
    QString name(fileInfo.fileName());
    return name;
}

QString helper::getSoundPath(QString openedSound) {
    QString soundpath = QUrl(openedSound).toLocalFile();
    return soundpath;
}

void helper::saveProject(QVector<QVector<bool>> allTracks, int soundcount,
                         QVector<QString> soundnames, QVector<QString> soundpaths, int tracksCount,
                         int interval) {

    QString filename;
    filename = QFileDialog::getSaveFileName(nullptr, "Save Project", "", "OKS project (*.oks)");
    qDebug() << filename;

    if (filename.isEmpty())
        return;
    else {
        QFile file(filename);
        if (!file.open(QIODevice::WriteOnly)) {
            QMessageBox::information(nullptr, "Unable to open file",
                    file.errorString());
            return;
        }
        QTextStream out(&file);
        out << soundcount << "\n";
        for (int i = 0; i < allTracks.length(); i++) {
            for (int j = 0; j < allTracks[i].length(); j++) {
                out << allTracks[i][j];
            }
            out << "\n";
        }
        for (int i = 0; i < soundnames.length(); i++) {
            out << soundnames[i] << "\n";
        }
        for (int i = 0; i < soundpaths.length(); i++) {
            out << soundpaths[i] << "\n";
        }
        out << interval << "\n";
        out << tracksCount;
        file.close();
    }

}

QList<QString> helper::loadProject(QString filePath) {

    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        QMessageBox::information(nullptr, "Unable to open file",
                file.errorString());
    }

    QTextStream in(&file);
    QList<QString> buffer;

    while(!in.atEnd()) {
        QString line = in.readLine();
        buffer.append(line);
    }

    QList<QString>::Iterator it = buffer.begin();
    while (it != buffer.end()) {
        qDebug() << *it;
        it++;
    }


    return buffer;
}

QVector<bool> helper::getTrack(QList<QString> project, int soundcount) {
    int tracksCount = project[project.length() - 1].toInt();
    QVector<bool> track;
    for (int j = 0; j < tracksCount * 40; j++) {
        if (project[soundcount][j] == "1") {
            track.append(true);
        }
        else {
            track.append(false);
        }
    }

    return track;
}

int helper::getSoundcount(QList<QString> project) {
    int soundcount = project[0].toInt();
    return soundcount;
}
QVector<QString> helper::getSoundnames(QList<QString> project, int soundcount) {
    QVector<QString> soundnames;
    for (int i = soundcount + 1; i <= soundcount + soundcount; i++) {
        soundnames.append(project[i]);
    }
    return soundnames;
}

QVector<QString> helper::getSoundpaths(QList<QString> project, int soundcount) {
    QVector<QString> soundpaths;
    for (int i = soundcount + soundcount + 1; i <= soundcount +
         soundcount + soundcount; i++) {
        soundpaths.append(project[i]);
    }
    return soundpaths;
}

bool helper::checkFile(QString soundpath) {
    QFileInfo file(soundpath);
    if (file.isReadable()) {
        return true;
    } else {
        return false;
    }
}
int helper::getInterval(QList<QString> project) {
    int interval = project[project.length() - 2].toInt();
    return interval;
}
