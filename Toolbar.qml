import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQml 2.15
import QtQuick.Dialogs 1.0

Rectangle {

    color: "#2E323D"
    width: w.width
    height: 40

    signal load()
    signal edit()
    signal play()
    signal stop()
    signal addTrack()
    signal delTrack()
    signal pause()
    signal save()
    signal loadProj()
    signal newproj()
    signal intervalChanged(var newBpm)

    property bool isPlaying: false

    //Установить новое значение интервала в текстовое поле
    function setInterval(interval) {
        bpmMeter.bpm = interval
    }


    RowLayout {

        width: w.width
        height: 40

        anchors.fill: parent
        spacing: 6


        Button {
            id: loadButton
            background: Rectangle {
                color: "#2E323D"
            }

            contentItem: Image {
                source: "qrc:/resources/loadsound.png"

            }

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.alignment: Qt.AlignLeft

            onClicked: load()
        }

        Button {
            id: newprojButton
            background: Rectangle {
                color: "#2E323D"
            }

            contentItem: Image {
                source: "qrc:/resources/new.png"

            }

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.alignment: Qt.AlignLeft

            onClicked: newproj()
        }

        Button {
            id: saveButton
            background: Rectangle {
                color: "#2E323D"
            }

            contentItem: Image {
                source: "qrc:/resources/saveproj.png"

            }

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.alignment: Qt.AlignLeft

            onClicked: save()
        }

        Button {
            id: loadProjButton
            background: Rectangle {
                color: "#2E323D"
            }

            contentItem: Image {
                source: "qrc:/resources/loadproj.png"

            }

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.alignment: Qt.AlignLeft

            onClicked: loadProj()
        }

        Button {
            id: addTrackButton

            background: Rectangle {
                color: "#2E323D"
            }

            contentItem: Image {
                source: "qrc:/resources/addtrack.png"
                anchors.centerIn: parent
            }

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.alignment: Qt.AlignLeft

            onClicked: addTrack()
        }

        Button {
            id: delTrackButton

            background: Rectangle {
                color: "#2E323D"
            }

            contentItem: Image {
                source: "qrc:/resources/deltrack.png"
                anchors.centerIn: parent
            }

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.alignment: Qt.AlignLeft

            onClicked: {
                if (!isPlaying)
                    delTrack()
            }
        }

        Button {
            id: playButton

            width: 36; height: 36

            background: Rectangle {
                color: "#2E323D"
            }

            contentItem: Image {
                source: "qrc:/resources/2.png"
                anchors.centerIn: parent
            }

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.alignment: Qt.AlignLeft

            onClicked: {
                isPlaying = true
                play()
            }
        }

        Button {
            id: pauseButton

            width: 36; height: 36

            background: Rectangle {
                color: "#2E323D"
            }

            contentItem: Image {
                source: "qrc:/resources/pause.png"
                anchors.centerIn: parent
            }

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.alignment: Qt.AlignLeft

            onClicked: {
                pause()
            }
        }

        Button {
            id: stopButton

            width: 36
            height: 36

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

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.alignment: Qt.AlignLeft

            onClicked: {
                stop()
            }
        }

        TextField {
            id: bpmMeter
            Layout.preferredWidth: 50
            Layout.preferredHeight: 36
            placeholderText: "BPM"
            property var bpm: 120
            text: bpm
            validator: IntValidator {
                bottom: 1
                top: 960
            }

            onEditingFinished: {
                bpm = bpmMeter.text
                intervalChanged(bpmMeter.bpm)
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
