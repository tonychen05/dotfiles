import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import "."

Rectangle {
  property int    signal:  0
  property string ssid:    ""
  property bool   hovered: false

  color:          hovered ? Colors.surface : Colors.bg
  radius:         8
  border.width:   1
  border.color:   Colors.border
  implicitHeight: 26
  implicitWidth:  icon.implicitWidth + 20

  Behavior on color { ColorAnimation { duration: 100 } }

  Process {
    id: wifiProc
    command: ["nmcli", "-t", "-f", "ACTIVE,SSID,SIGNAL", "device", "wifi"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        const active = text.trim().split("\n").find(l => l.startsWith("yes:"))
        if (active) {
          const p = active.split(":")
          signal = parseInt(p[p.length - 1]) || 0
          ssid   = p.slice(1, p.length - 1).join(":")
        } else {
          signal = 0
          ssid   = ""
        }
      }
    }
  }

  Timer {
    interval: 15000
    repeat:   true
    running:  true
    onTriggered: {
      wifiProc.running = false
      wifiProc.running = true
    }
  }

  Text {
    id: icon
    anchors.centerIn: parent
    text: signal <= 0 ? "󰤭"
        : signal < 40 ? "󰤟"
        : signal < 70 ? "󰤢"
        :               "󰤨"
    color: signal > 0 ? Colors.fg : Colors.fgDim
    font.pixelSize: 14
    font.family: "JetBrainsMono Nerd Font"
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered:    hovered = true
    onExited:     hovered = false
    ToolTip.visible: containsMouse
    ToolTip.text:    ssid !== "" ? ssid : "Not connected"
  }
}
