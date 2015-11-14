import QtQuick 2.0
import Sailfish.Silica 1.0
import "StationLists"

Page {

    StationsModel {
        id: stationList
        property string filterProperty: 'title'
    }

  
    SilicaFlickable {
        width: parent ? parent.width : Screen.width
        height: parent ? parent.height : Screen.height
        VerticalScrollDecorator {}
        contentHeight: Math.max(1, alphaMenu.height)

    AlphaMenu {
        id: alphaMenu
        dataSource: stationList
        listDelegate:  BackgroundItem {
            width: parent.width
            onClicked: {lib.musicSource = (Qt.resolvedUrl(source))
                           lib.radioStation = title
                           //listPress.play()
                           playStream()
                           lib.website = (Qt.resolvedUrl(site))
                       }

                Row{
                    spacing: 20

                    Label {
                        text: length
                        height: Theme.itemSizeHuge
                        font.pixelSize: Theme.fontSizeExtraLarge
                        color: Theme.secondaryColor
                    }

                    Column{
                        Label {
                            text: title
                            font.pixelSize: Theme.fontSizeMedium
                            color: highlighted
                                   ? Theme.highlightColor
                                   : Theme.primaryColor
                        }
                        Label {
                            text: section
                            font.pixelSize: Theme.fontSizeExtraSmall
                            color: highlighted
                                   ? Theme.highlightColor
                                   : Theme.primaryColor
                        }
                    }
                }
            }
        }
    }
}
