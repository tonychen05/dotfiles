import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "."

Rectangle {
  color:          Colors.bg
  radius:         10
  border.width:   1
  border.color:   Colors.border
  implicitHeight: 26
  implicitWidth:  row.implicitWidth + 8

  RowLayout {
    id: row
    anchors.centerIn: parent
    spacing: 0

    Repeater {
      model: 5

      delegate: Item {
        id: btn

        property int  wsId:     index + 1
        property var  ws:       Hyprland.workspaces.values.find(w => w.id === wsId)
        property bool isActive: Hyprland.focusedWorkspace?.id === wsId
        property bool hovered:  false

        implicitWidth:  label.implicitWidth + 16
        implicitHeight: 22

        Rectangle {
          anchors.centerIn: parent
          width:  parent.implicitWidth - 4
          height: 18
          radius: 8
          color:  btn.isActive  ? Colors.accent
                : btn.hovered   ? Colors.hover
                :                 "transparent"

          Behavior on color { ColorAnimation { duration: 100 } }
        }

        Text {
          id: label
          anchors.centerIn: parent
          text:      btn.wsId
          color:     btn.isActive ? "#ffffff" : (btn.ws ? Colors.fg : Colors.fgDim)
          font.pixelSize: 11
          font.bold:  true
        }

        MouseArea {
          anchors.fill: parent
          hoverEnabled: true
          onEntered:    btn.hovered = true
          onExited:     btn.hovered = false
          onClicked:    Hyprland.dispatch("workspace " + btn.wsId)
        }
      }
    }
  }
}
