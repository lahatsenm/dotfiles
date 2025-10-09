import Quickshell // for PanelWindow
import Quickshell.Io // for Process
import QtQuick // for Text

PanelWindow {
    anchors {
        left: true
        right: true
        bottom: true
    }

    implicitHeight: 30

    Text {
        id: clock
        // center the bar in its parent component (the window)
        anchors.centerIn: parent

        Process {
            id: dateProc
            
            command: ["date"]
            running: true

            stdout: StdioCollector {
                onStreamFinished: clock.text = this.text
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true

            onTriggered: dateProc.running = true
        }
    }
}
