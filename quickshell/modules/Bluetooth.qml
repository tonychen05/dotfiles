import Quickshell
import Quickshell.Io
import QtQuick
import "."

Rectangle {
  property bool powered:   false
  property bool connected: false
  property bool hovered:   false

  color:          hovered ? Colors.surface : Colors.bg
  radius:         8
  border.width:   1
  border.color:   Colors.border
  implicitHeight: 26
  implicitWidth:  icon.implicitWidth + 20

  Behavior on color { ColorAnimation { duration: 100 } }

  Process {
    id: btProc
    command: ["bluetoothctl", "show"]
    running: true

    stdout: SplitParser {
      onRead: data => {
        powered   = data.includes("Powered: yes")
        connected = data.includes("Connected: yes")
      }
    }
  }

  Timer {
    interval: 10000
    repeat:   true
    running:  true
    onTriggered: {
      btProc.running = false
      btProc.running = true
    }
  }

  Text {
    id: icon
    anchors.centerIn: parent
    text:  connected ? "󰂱" : powered ? "󰂯" : "󰂲"
    color: connected ? Colors.accent : powered ? Colors.fg : Colors.fgDim
    font.pixelSize: 14
    font.family: "JetBrainsMono Nerd Font"
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered:    hovered = true
    onExited:     hovered = false
  }
}
