import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQml 2.15
import QtQuick.Dialogs 1.0

Rectangle {
    color: "#2E323D"
    width: w.width
    height: 160

    signal play()
    signal stop()
    signal currentSecond(var second)
    signal timerEnd()

    Button {
        id: playButton

        width: 36; height: 36

        x: 10

        background: Rectangle {
            color: "#2E323D"
        }

        contentItem: Image {
            source: "/2.png"
            anchors.centerIn: parent
        }

        onClicked: {
            play()
            timer.running = true
        }
    }

    Button {
        id: stopButton

        width: 36
        height: 36

        x: 46

        background: Rectangle {
            color: "#2E323D"
        }

        contentItem: Rectangle {
            width: 32
            height: 32
            color: "#EF3535"
            border.width: 2
            border.color: "black"
            anchors.centerIn: parent
        }

        onClicked: {
            timer.running = false
            timerField.countdown = 0
            timerEnd()
        }
    }

    TextField {
        id: timerField
        readOnly: true
        Layout.fillWidth: true
        x: 207
        width: 600
        horizontalAlignment: TextInput.AlignHCenter
        property int countdown: 0
        Timer {
            id: timer
            interval: 500
            running: false
            repeat: true
            onTriggered: {
                timerField.text = "Time: " + timerField.countdown
                currentSecond(timerField.countdown)

                if (timerField.countdown === 40) {
                    timer.running = false
                    timerField.countdown = 0
                    timerEnd()
                }
                timerField.countdown++;
            }

        }

    }
}
