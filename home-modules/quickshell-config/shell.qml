import QtQuick
import Quickshell

ShellRoot {
    // Пример простейшей панели сверху экрана
    Variant {
        Scope {
            PanelWindow {
                anchors.top: true
                anchors.left: true
                anchors.right: true
                height: 30
                color: "#1e1e2e"

                Text {
                    anchors.centerIn: parent
                    text: "NixOS + Hyprland + Quickshell работает!"
                    color: "#cdd6f4"
                }
            }
        }
    }
}
