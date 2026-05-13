import Quickshell
import Quickshell.Services.Pipewire
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

  PwObjectTracker {
    id: sinkTracker
    objects: [Pipewire.defaultAudioSink]
  }

  property var  sink:   sinkTracker.objects[0] ?? null
  property real volume: sink?.audio?.volume    ?? 0
  property bool muted:  sink?.audio?.muted     ?? false

  Text {
    id: label
    anchors.centerIn: parent
    text: (muted         ? "󰝟"
         : volume > 0.66 ? "󰕾"
         : volume > 0.33 ? "󰖀"
         :                 "󰕿") + "  " + Math.round(volume * 100) + "%"
    color: muted ? Colors.fgDim : Colors.fg
    font.pixelSize: 12
    font.family: "JetBrainsMono Nerd Font"
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton
    onEntered: hovered = true
    onExited:  hovered = false
    onClicked: { if (sink) sink.audio.muted = !muted }
    onWheel: {
      if (!sink) return
      const delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05
      sink.audio.volume = Math.max(0, Math.min(1, volume + delta))
    }
  }
}
