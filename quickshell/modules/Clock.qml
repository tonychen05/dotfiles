import Quickshell
import QtQuick
import "."

Rectangle {
  property bool hovered: false

  color:          hovered ? Colors.surface : Colors.bg
  radius:         8
  border.width:   1
  border.color:   Colors.border
  implicitHeight: 26
  implicitWidth:  label.implicitWidth + 20

  Behavior on color { ColorAnimation { duration: 100 } }

  SystemClock { id: clock; precision: SystemClock.Minutes }

  Text {
    id: label
    anchors.centerIn: parent
    text:  Qt.formatDateTime(clock.date, "hh:mm")
    color: Colors.fg
    font.pixelSize: 12
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered:    hovered = true
    onExited:     hovered = false
  }
}
