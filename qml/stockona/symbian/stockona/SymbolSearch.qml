import QtQuick 1.1
import com.nokia.symbian 1.1

Dialog {
    id: container

    property color pressColor: (1) ? "#4A4344" : "#FDE688"
    property string mySym: ""
    property string myExg: ""
    property string myName: ""

    title: [
        Text {
            id: label
            anchors.verticalCenter:  parent.verticalCenter
            anchors { left: parent.left; leftMargin: params.headerLeftMargin/2; }

            text: qsTr("Symbol Suggestions")
            font.pixelSize: 24
            color: params.labelColor
        },
        Text {
            id: closeIcon
            anchors { verticalCenter: parent.verticalCenter; right: parent.right; rightMargin: params.headerLeftMargin/2 }
            color: (useDarkTheme) ? "white" : "black"
            text: "X"
            font.pixelSize: 24
            MouseArea {
                id: closeIconMouseArea
                anchors.fill: parent
                onClicked: { container.reject() }
            }
        }
    ]

    content: Item {
        width: 0.93*parent.width
        anchors { top: parent.top; bottom: parent.bottom; horizontalCenter: parent.horizontalCenter }

        //Rectangle { id: ss; anchors { top: label.bottom; topMargin: 20} height: 1; width: parent.width; color: "#333333" }

        ListView {
            id: scView
            anchors { top: parent.top; left: parent.left; right: parent.right; bottom: parent.bottom }
            anchors { topMargin: 10 }
            model: searchModel
            delegate: scDelegate
            snapMode: ListView.SnapToItem
            clip: true
        }
    }

    Component {
        id: scDelegate

        Item {
            id: scDelegateItem
            width: scView.width
            height: 60

            Rectangle {
                id: background
                anchors.fill: parent
                opacity: 0
                color: (useDarkTheme) ? "black" : "#DEDFDE"
            }

            Text {
                width: parent.width
                anchors.fill: parent
                anchors { leftMargin: 10; }
                verticalAlignment: Text.AlignVCenter

                font.bold: true
                font.pixelSize: params.scTxtTs
                elide: Text.ElideRight
                color: params.labelColor
                text: sym + " - " + name
            }

            MouseArea {
                id: scMouseArea
                anchors.fill: parent
                onClicked: {
                    mySym  = sym;
                    myExg  = exg;
                    myName = name;
                    container.accept();
                }
            }

            states: [
                State {
                    name: "Pressed"
                    when: scMouseArea.pressed
                    PropertyChanges { target: background; color: container.pressColor; opacity: 1 }
                }
            ]
        }
    }
}
