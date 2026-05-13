import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import "."

Rectangle {
  color:          Colors.bg
  radius:         8
  border.width:   1
  border.color:   Colors.border
  implicitHeight: 26
  implicitWidth:  row.implicitWidth + 16

  RowLayout {
    id: row
    anchors.centerIn: parent
    spacing: 6

    Repeater {
      model: SystemTray.items

      delegate: Item {
        implicitWidth:  16
        implicitHeight: 16

        Image {
          anchors.fill: parent
          source: modelData.icon
          smooth: true
        }

        MouseArea {
          anchors.fill: parent
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          onClicked: {
            if (mouse.button === Qt.RightButton)
              modelData.menu.open(this, Qt.point(0, height))
            else
              modelData.activate()
          }
        }
      }
    }
  }
}
