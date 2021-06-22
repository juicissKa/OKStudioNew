import QtQuick 2.0

Rectangle {
    width: 16
    height: 60
    border.color: "black"
    border.width: 1
    property bool lighted: false
    color: lighted ? "yellow" : "#6476AD"

    signal light()
    signal unlight()

    onLight: lighted = true
    onUnlight: lighted = false

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (lighted === false)
                light()
            else
                unlight()
        }
    }
}
