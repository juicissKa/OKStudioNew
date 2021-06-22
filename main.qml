
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2

Window {
    id: w

    visible: true

    color: "#121725"

    minimumWidth: 1280
    maximumWidth: 1280

    width: 1280

    minimumHeight: mainColumnLayout.height
    maximumHeight: mainColumnLayout.height

    height: mainColumnLayout.height

    title: qsTr("OK Studio v0.1")

    ColumnLayout {
        id: mainColumnLayout

        anchors.centerIn: w.contentItem
        spacing: 3

        Toolbar {
            id: toolbar
            onLoad: {
                fileDialog.visible = true
            }
            onPlay: {
                soundscroll.playTrack()
            }
            onStop: {
                soundscroll.stopTimer()
            }
            onAddTrack: {
                soundscroll.addNewTrack()
            }
            onDelTrack: soundscroll.delNewTrack()
            onPause: soundscroll.pauseTimer()
            onSave: soundscroll.saveProject()
            onLoadProj: fileDialog2.visible = true
            onNewproj: soundscroll.newProject()
            onIntervalChanged: {
                console.log("signal")
                soundscroll.changeBpm(newBpm)
            }
        }

        Soundscroll {
            id: soundscroll

            onTimerIsStopped: toolbar.isPlaying = false
            onSoundIsNotAvailable: {
                messageDialog.soundErrorName = soundNameError
                messageDialog.soundErrorPath = soundPathError
                messageDialog.visible = true
            }
            onLoadInterval: {
                toolbar.setInterval(interval)
            }
        }
    }
    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        nameFilters: ["Audio files (*.wav)"]
        folder: shortcuts.home
        onAccepted: {
            soundscroll.soundpath = helper.getSoundPath(fileDialog.fileUrl)
            soundscroll.addSound()
        }
    }

    FileDialog {
        id: fileDialog2
        title: "Please choose a file"
        nameFilters: ["OKStudio files (*.oks)"]
        folder: shortcuts.home
        onAccepted: {
            soundscroll.soundpath = helper.getSoundPath(fileDialog2.fileUrl)
            soundscroll.loadProject()
        }
    }
    MessageDialog {
        id: messageDialog
        property string soundErrorName: ""
        property string soundErrorPath: ""
        text: "Sound " + soundErrorName + " is not available. Delete or recover it. Sound's path: " + soundErrorPath
    }
}
