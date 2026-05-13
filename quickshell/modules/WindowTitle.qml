import Quickshell
import Quickshell.Hyprland
import QtQuick
import "."

Text {
  // Layout.fillWidth: true set by shell.qml
  text:  Hyprland.focusedClient?.title ?? ""
  color: Colors.fgDim
  font.pixelSize: 12
  elide: Text.ElideRight
  horizontalAlignment: Text.AlignHCenter
  verticalAlignment:   Text.AlignVCenter
}
