import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import "modules"

ShellRoot {
  NotificationServer {
    id: notifServer
    keepOnReload: true
    bodySupported: true
    bodyMarkupSupported: true
    imageSupported: true
    actionsSupported: true

    onNotification: notif => {
      notif.tracked = true
    }
  }

  // Notification popup — anchored top-right, floats over other windows
  PanelWindow {
    anchors.top:   true
    anchors.right: true
    margins.top:   46
    margins.right: 12
    exclusiveZone: -1
    color: "transparent"
    implicitWidth:  350
    implicitHeight: Math.max(1, notifCol.implicitHeight)

    Column {
      id: notifCol
      anchors.top:   parent.top
      anchors.left:  parent.left
      anchors.right: parent.right
      spacing: 8

      Repeater {
        id: notifRepeater
        model: notifServer.trackedNotifications
        delegate: NotificationCard {
          notification: modelData
        }
      }
    }
  }

  PanelWindow {
    id: bar
    anchors.top:   true
    anchors.left:  true
    anchors.right: true
    implicitHeight: 36
    color: Colors.bg

    RowLayout {
      anchors.fill:        parent
      anchors.leftMargin:  12
      anchors.rightMargin: 12
      spacing: 10

      Workspaces { id: leftGroup }

      Item { Layout.fillWidth: true }

      RowLayout {
        id: rightGroup
        spacing: 4
        Tray      {}
        Wifi      {}
        Bluetooth {}
        Battery   {}
        Sound     {}
        Clock     {}
      }
    }

    // Center title — overlaid and anchored to the bar's true center
    Rectangle {
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.verticalCenter:   parent.verticalCenter
      width:  Math.min(titleText.implicitWidth + 24, bar.width - 2 * Math.max(leftGroup.width, rightGroup.width) - 32)
      height: 26
      radius: 8
      color:  Colors.bg
      border.width: 1
      border.color: Colors.border
      visible: titleText.text !== "" && width > 40

      Text {
        id: titleText
        anchors.centerIn: parent
        width: parent.width - 20
        text:  ToplevelManager.activeToplevel?.title ?? ""
        color: Colors.fg
        font.pixelSize: 11
        font.family: "JetBrainsMono Nerd Font"
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment:   Text.AlignVCenter
      }
    }
  }
}
