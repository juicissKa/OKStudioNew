import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2

RowLayout {
    id: sundtrack
    property string soundpath: ""
    property string soundname: ""
    signal sundtrackDeletion()
    property int tracksCount: 1
    property var trackflags: []

    //Получить трек звука
    function getTrack() {
        var lightedTrackflags = []
        for (var i = 0; i < 40 * tracksCount; i++) {
            lightedTrackflags.push(trackflags[i].lighted)
        }
        return lightedTrackflags
    }

    //Добавить новый трек к звуку
    function addNewTrack() {
        var component = Qt.createComponent("Trackflag.qml")
        for (var i = 0; i < 40; i++) {
            var object = component.createObject(track)
            trackflags.push(object)
        }

    }

    //Удалить последний трек звука
    function delNewTrack() {
        for (var i = 40 * tracksCount - 1; i >= 40 * (tracksCount - 1); i--) {
            trackflags[i].destroy()
            trackflags.pop()
        }

    }

    //Загрузить трек
    function lightTrack(lightTrackflags) {
        for (var i = 0; i < 40 * tracksCount; i++) {
            trackflags[i].lighted = lightTrackflags[i]
        }
    }

    Rectangle {
        id: sund
        width: 200
        height: 60
        border.color: "black"
        border.width: 2

        color: "#46588F"

        GridLayout {
            anchors.centerIn: parent
            Text {
                text: sundtrack.soundname
                Layout.preferredWidth: sund.width - 5
                elide: Text.ElideRight
                color: "#CAD1E6"
                font.pixelSize: 20
            }
        }

        MouseArea {
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            anchors.fill: parent
            Menu {
                id: contextMenu

                MenuItem {
                    text: "Delete"
                    onClicked: {
                        sundtrackDeletion()
                        sundtrack.destroy()
                    }
                }
            }

            onClicked: {
                if (mouse.button === Qt.LeftButton) {
                    helper.playSound(soundpath)
                }
                if (mouse.button === Qt.RightButton)
                    contextMenu.popup()
            }
            onPressAndHold: {
                if (mouse.source === Qt.MouseEventNotSynthesized) {
                    contextMenu.popup()
                }
            }

        }
    }

    RowLayout {
        id: track
        spacing: -1

    }
}
