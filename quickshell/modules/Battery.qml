import Quickshell
import Quickshell.Io
import QtQuick
import "."

Rectangle {
  property int  pct:      0
  property bool charging: false
  property bool hovered:  false

  color:          hovered ? Colors.surface : Colors.bg
  radius:         8
  border.width:   1
  border.color:   Colors.border
  implicitHeight: 26
  implicitWidth:  label.implicitWidth + 20

  Behavior on color { ColorAnimation { duration: 100 } }

  Process {
    id: capProc
    command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
    running: true
    stdout: SplitParser {
      onRead: data => { pct = parseInt(data) || 0 }
    }
  }

  Process {
    id: statProc
    command: ["cat", "/sys/class/power_supply/BAT0/status"]
    running: true
    stdout: SplitParser {
      onRead: data => { charging = data.trim() === "Charging" }
    }
  }

  Timer {
    interval: 30000
    repeat:   true
    running:  true
    onTriggered: {
      capProc.running  = false
      statProc.running = false
      capProc.running  = true
      statProc.running = true
    }
  }

  Text {
    id: label
    anchors.centerIn: parent
    text: {
      const icon = charging  ? "󰂄"
                 : pct > 80  ? "󰁹"
                 : pct > 60  ? "󰁾"
                 : pct > 40  ? "󰁼"
                 : pct > 20  ? "󰁺"
                 :             "󰂃"
      return icon + " " + pct + "%"
    }
    color: pct < 20 && !charging ? Colors.warn : Colors.fg
    font.pixelSize: 12
    font.family: "JetBrainsMono Nerd Font"
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered:    hovered = true
    onExited:     hovered = false
  }
}
