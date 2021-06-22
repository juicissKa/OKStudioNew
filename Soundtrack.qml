import QtQuick 2.0
import QtQuick.Layouts 1.12

RowLayout {
    Sound {
        id: sound
        onPlaySound: helper.playSound()
    }
    Track {
        id: track
    }
}
