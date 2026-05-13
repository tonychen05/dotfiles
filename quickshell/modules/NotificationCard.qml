import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Services.Notifications
import "."

Item {
  id: card
  property var notification: null
  property bool hovered: false

  readonly property color accent: {
    if (!notification) return Colors.accent
    const app = (notification.appName ?? "").toLowerCase()
    if (app.includes("discord")) return Colors.accent2
    if (notification.urgency === NotificationUrgency.Critical) return Colors.warn
    if (notification.urgency === NotificationUrgency.Low)      return Colors.ok
    return Colors.accent
  }

  implicitWidth:  360
  implicitHeight: bg.implicitHeight

  // Slide + fade in from the right
  transform: Translate { id: slide; x: 40 }
  opacity: 0
  Component.onCompleted: {
    slideAnim.start()
    fadeAnim.start()
  }
  NumberAnimation {
    id: slideAnim
    target: slide; property: "x"
    from: 40; to: 0; duration: 260
    easing.type: Easing.OutCubic
  }
  NumberAnimation {
    id: fadeAnim
    target: card; property: "opacity"
    from: 0; to: 1; duration: 220
    easing.type: Easing.OutCubic
  }

  Timer {
    id: dismissTimer
    interval: (!notification || notification.urgency === NotificationUrgency.Critical) ? 0 : 5000
    running:  interval > 0 && notification !== null && !card.hovered
    onTriggered: notification.dismiss()
  }

  Rectangle {
    id: bg
    anchors.fill: parent
    implicitHeight: contentRow.implicitHeight + 24
    radius: 14
    color:  card.hovered ? Colors.surface : Colors.bg
    border.width: 1
    border.color: Qt.rgba(1, 1, 1, 0.04)

    Behavior on color { ColorAnimation { duration: 140 } }

    layer.enabled: true
    layer.effect: MultiEffect {
      shadowEnabled: true
      shadowBlur:    1.0
      shadowColor:   Qt.rgba(0, 0, 0, 0.45)
      shadowVerticalOffset:   4
      shadowHorizontalOffset: 0
    }

    // Left accent stripe
    Rectangle {
      id: stripe
      anchors {
        left:   parent.left
        top:    parent.top
        bottom: parent.bottom
        margins: 6
      }
      width:  3
      radius: 2
      color:  card.accent
    }

    RowLayout {
      id: contentRow
      anchors {
        left:    stripe.right
        right:   parent.right
        top:     parent.top
        bottom:  parent.bottom
        leftMargin:   12
        rightMargin:  16
        topMargin:    12
        bottomMargin: 12
      }
      spacing: 12

      // Optional app icon / image
      Rectangle {
        Layout.alignment: Qt.AlignTop
        Layout.preferredWidth:  iconImg.source.toString() !== "" ? 36 : 0
        Layout.preferredHeight: iconImg.source.toString() !== "" ? 36 : 0
        radius: 8
        color:  Qt.rgba(1, 1, 1, 0.04)
        visible: iconImg.source.toString() !== ""

        Image {
          id: iconImg
          anchors.fill: parent
          anchors.margins: 4
          fillMode: Image.PreserveAspectFit
          smooth: true
          source: notification?.image && notification.image !== ""
                    ? notification.image
                    : (notification?.appIcon ?? "")
        }
      }

      ColumnLayout {
        Layout.fillWidth: true
        spacing: 4

        RowLayout {
          Layout.fillWidth: true
          spacing: 6

          Rectangle {
            Layout.preferredWidth:  6
            Layout.preferredHeight: 6
            radius: 3
            color:  card.accent
          }

          Text {
            text:  (notification?.appName ?? "").toUpperCase()
            color: Colors.fgDim
            font.pixelSize: 9
            font.family:    "JetBrainsMono Nerd Font"
            font.letterSpacing: 1.2
            font.bold: true
            elide: Text.ElideRight
          }

          Item { Layout.fillWidth: true }

          Item {
            id: closeBtn
            Layout.preferredWidth:  16
            Layout.preferredHeight: 16
            opacity: card.hovered ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 120 } }

            Text {
              anchors.centerIn: parent
              text:  "✕"
              color: closeMa.containsMouse ? Colors.fg : Colors.fgDim
              font.pixelSize: 11
              font.family:    "JetBrainsMono Nerd Font"
              Behavior on color { ColorAnimation { duration: 120 } }
            }

            MouseArea {
              id: closeMa
              anchors.fill: parent
              hoverEnabled: true
              cursorShape:  Qt.PointingHandCursor
              onClicked:    notification.dismiss()
            }
          }
        }

        Text {
          Layout.fillWidth: true
          text:       notification?.summary ?? ""
          color:      Colors.fg
          font.pixelSize: 12
          font.family:    "JetBrainsMono Nerd Font"
          font.bold:  true
          wrapMode:   Text.WordWrap
          visible:    text !== ""
        }

        Text {
          Layout.fillWidth: true
          text:       notification?.body ?? ""
          color:      Colors.fgDim
          font.pixelSize: 11
          font.family:    "JetBrainsMono Nerd Font"
          wrapMode:   Text.WordWrap
          textFormat: Text.RichText
          lineHeight: 1.25
          visible:    text !== ""
        }
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    acceptedButtons: Qt.NoButton
    onEntered: card.hovered = true
    onExited:  card.hovered = false
  }
}
