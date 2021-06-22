import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12


Flickable {
    id: flickable
    clip: true

    width: w.width
    height: 600
    contentHeight: soundbarflick.height; contentWidth: soundbarflick.width

    boundsBehavior: Flickable.StopAtBounds

    signal timerIsStopped()
    signal soundIsNotAvailable(var soundNameError, var soundPathError)
    signal loadInterval(var interval)

    property int soundcount: 0
    property string soundpath: ""
    property var sounds: []
    property var allTracks: []
    property int tracksCount: 1

    function changeBpm(bpm) {
        timerBar.stopTimer()
        timerBar.beatsInterval = bpm

    }

    function newProject() {
        for (var i = 0; i < sounds.length; i++) {
            sounds[i].destroy()
        }
        sounds = []
        tracksCount = 1
        allTracks = []
        timerBar.stopTimer()
        loadSounds()
    }

    function loadProject() {
        for (var i = 0; i < sounds.length; i++) {
            sounds[i].destroy()
        }
        sounds = []
        var project = helper.loadProject(soundpath)
        soundcount = helper.getSoundcount(project)
        for (var i = 1; i <= soundcount; i++) {
            allTracks.push(helper.getTrack(project, i))
        }

        tracksCount = allTracks[0].length / 40

        var soundpaths = helper.getSoundpaths(project, soundcount)
        var soundnames = helper.getSoundnames(project, soundcount)

        var component = Qt.createComponent("Sound.qml")

        for (var i = 0; i < soundcount; i++) {
            var object = component.createObject(soundbarflick)
            object.soundname = soundnames[i]
            object.soundpath = soundpaths[i]
            object.tracksCount = tracksCount
            for (var j = 0; j < tracksCount; j++)
                object.addNewTrack()
            sounds.push(object)
        }

        for (var i = 0; i < sounds.length; i++) {
            sounds[i].lightTrack(allTracks[i])
        }

        var interval = helper.getInterval(project)
        timerBar.beatsInterval = interval
        loadInterval(interval)

        timerBar.tracksCount = tracksCount

        allTracks = []

    }

    function saveProject() {
        getTracks()
        var soundnames = []
        var soundpaths = []
        for (var i = 0; i < sounds.length; i++) {
            soundnames.push(sounds[i].soundname)
            soundpaths.push(sounds[i].soundpath)
        }

        var interval = timerBar.beatsInterval

        helper.saveProject(allTracks, soundcount, soundnames, soundpaths, tracksCount, interval)
        allTracks = []
    }

    function playTrack() {
        timerBar.startTimer()
    }

    function addNewTrack() {
        tracksCount = tracksCount + 1
        for (var i = 0; i < soundcount; i++) {
            sounds[i].addNewTrack()
            sounds[i].tracksCount = tracksCount
        }
        timerBar.tracksCount = tracksCount
    }

    function delNewTrack() {
        tracksCount = tracksCount - 1
        for (var i = 0; i < soundcount; i++) {
            sounds[i].delNewTrack()
            sounds[i].tracksCount = tracksCount
        }
        timerBar.tracksCount = tracksCount
    }

    function stopTimer() {
        timerBar.stopTimer()
        allTracks = []
    }

    function pauseTimer() {
        timerBar.pauseTimer()
        allTracks = []
    }

    function loadSounds() {
        var soundPaths = helper.soundpack()
        var component = Qt.createComponent("Sound.qml")
        for (var i = 0; i < soundPaths.length; i++) {
            var soundName = helper.soundname(soundPaths[i])
            var object = component.createObject(soundbarflick)
            object.soundname = soundName
            object.soundpath = soundPaths[i]
            object.tracksCount = tracksCount
            object.addNewTrack()
            sounds.push(object)
            soundcount = sounds.length
        }

    }

    function addSound() {
        var component = Qt.createComponent("Sound.qml")
        var soundPath = soundpath
        var soundName = helper.soundname(soundPath)
        var object = component.createObject(soundbarflick)
        object.soundname = soundName
        object.soundpath = soundPath
        object.tracksCount = tracksCount
        for (var i = 0; i < tracksCount; i++)
            object.addNewTrack()
        sounds.push(object)
        soundcount = sounds.length
        console.log(sounds)
    }

    function getTracks() {
            for (var i = 0; i < soundcount; i++) {
                try {
                allTracks.push(sounds[i].getTrack())
                } catch (e) {
                    sounds.splice(i, 1)
                    soundcount = sounds.length
                    i--;
                }
            }
    }

    function play(second) {
        getTracks()
        for (var i = 0; i < soundcount; i++) {
            timerBar.position = second
            if (allTracks[i][second] === true) {
                if (helper.checkFile(sounds[i].soundpath)) {
                helper.playSound(sounds[i].soundpath)
                } else {
                    stopTimer()
                    soundIsNotAvailable(sounds[i].soundname, sounds[i].soundpath)
                }
            }
        }
        allTracks = []
    }

    ColumnLayout {
        id: soundbarflick
        Lower_toolbar {
            id: timerBar
            width: flickable.contentWidth
            onCurrentSecond: soundscroll.play(second)
            onTimerEnd: soundscroll.allTracks = []
            onTimerStopped: timerIsStopped()
        }

        spacing: 3

    }

    ScrollBar.vertical: ScrollBar {
        active: true

    }
    ScrollBar.horizontal: ScrollBar {
        active: true

    }

    Component.onCompleted: {
        loadSounds()
        console.log(sounds[1].soundpath)
    }

}
