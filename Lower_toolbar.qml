import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQml 2.15
import QtQuick.Dialogs 1.0

Rectangle {
    color: "#2E323D"
    height: 80

    signal timerEnd()
    signal currentSecond(var second)
    signal timerStopped()

    property int position: 0
    property int tracksCount: 1
    property int beatsInterval: 120

    function stopTimer() {
        timer.running = false
        position = 0
        timerField.countdown = 0
        timerStopped()
    }

    function startTimer() {
        timer.running = true
    }

    function pauseTimer() {
        timer.running = false
    }
    Rectangle {
        id: timerField
        x: 206
        width: 600 * tracksCount
        height: 80
        color: "white"
        border.width: 2
        border.color: "black"
        property int countdown: 0
        Timer {
            id: timer
            interval: 60 / beatsInterval * 1000
            running: false
            repeat: true
            onTriggered: {
                currentSecond(timerField.countdown)
                timerField.countdown++;
                if (timerField.countdown === 40 * tracksCount) {
                    stopTimer()
                    timerEnd()
                }
            }

        }
        Rectangle {
            id: pointer
            width: 15
            height: timerField.height - 4
            color: "yellow"
            x: position * 15
            y: 2
        }

    }
}
