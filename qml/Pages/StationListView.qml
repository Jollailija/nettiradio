/*
  Copyright (C) 2015-2016 jollailija
  Contact: jollailija <jollailija@gmail.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * The names of the contributors may not be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.1
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "storage.js" as Storage
import "functions.js" as TheFunctions // :)
SilicaFlickable {
    id: background
    width: loader.width
    contentHeight: loader.height
    clip: true
    PulleyMenu {
        MenuItem {
            text: lib.activeView
                  ? mainPage.searchMode
                    ? qsTr("Piilota haku")
                    : qsTr("Näytä haku")
            : qsTr("Näytä haku")
            onClicked: {
                if(mainPage.searchMode){
                    mainPage.searchMode = false
                    lib.panelOpen = true
                    searchField.text = ""
                }
                else {
                    mainPage.searchMode = true
                    lib.panelOpen = false
                    searchField.text = ""
                    getSortedItems("")
                }
            }
        }
        MenuItem {
            text: qsTr("Valikko")
            onClicked: pageStack.push(Qt.resolvedUrl("Menu.qml"))
        }
    }

    function getSortedItems(searchTerm) {
        filteredModel.clear()
        for (var i = 0; i < qmlListModel.count; i++) {
            if (searchTerm === "" || qmlListModel.get(i).title.toLowerCase().indexOf(searchTerm) !== -1) {
                filteredModel.append(qmlListModel.get(i))
            }
        }
    }

    PageHeader {
        id: pageHeader
        title: qsTr("Radioasemat")
    }

    SearchField {
        id: searchField
        property string lowercaseText
        height: mainPage.searchMode ? implicitHeight : 0.0
        Behavior on height { NumberAnimation {} }
        clip: true
        anchors.top: pageHeader.bottom
        width: parent.width
        onTextChanged: {
            lowercaseText = text.toLowerCase()
            getSortedItems(lowercaseText)
            listView.positionViewAtIndex(0,ListView.Beginning)
            lib.panelOpen = false
        }
        inputMethodHints: Qt.ImhNoPredictiveText
        placeholderText: qsTr("Hae")
        EnterKey.onClicked: {
            focus = false
            lib.panelOpen = true
        }
    }

    SilicaListView {
        id: listView
        VerticalScrollDecorator {}
        anchors {
            top: searchField.bottom
            bottom: parent.bottom
        }
        width: parent.width
        clip: true
        model: searchMode ? filteredModel : qmlListModel
        ViewPlaceholder {
            y: mainPage.height * 0.2
            enabled: qmlListModel.count < 50
            text: qsTr("Ladataan asemalistaa") + "... (" + stationsModel.progress*100 + "%)"
            hintText: qsTr("Paina tästä, jos haluat käyttää paikallista kopioa")
        }
        ViewPlaceholder {
            y: mainPage.height * 0.2
            enabled: mainPage.searchMode && (filteredModel.count === 0)
            text: qsTr("Asemia ei löytynyt")
            hintText: qsTr("Kokeile hakea jotakin muuta")
        }
        MouseArea {
            anchors.fill: parent
            anchors.margins: -Theme.paddingLarge
            onClicked: {
                lib.localSource = true
                console.warn("using local list")
                stationsModel.reload()
                qmlListModel.clear()
                listFiller.start()}
            enabled: qmlListModel.count < 50
        }

        section {
            property: 'section'
            delegate: SectionHeader {
                text: section
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeMedium * lib.fontSize
                                : Theme.fontSizeSmall * lib.fontSize
            }
        }
        delegate: ListItem {
            property bool currentlyPlaying: source === lib.musicSource

            width: listView.width
            highlighted: down || currentlyPlaying // note to self: make sure this works

            IconButton {
                id: playingIcon
                icon.source: "image://theme/icon-m-media"
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
                opacity: currentlyPlaying ? 1.0 : 0.0
                width: currentlyPlaying ? height : Theme.paddingLarge
                Behavior on width { NumberAnimation {} }
                Behavior on opacity { NumberAnimation {} }
                visible: opacity > 0.0
            }

            Label {
                text: Theme.highlightText(model.title, searchField.lowercaseText, Theme.highlightColor)
                textFormat: Text.StyledText
                verticalAlignment: Text.AlignVCenter
                truncationMode: TruncationMode.Fade
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeExtraLarge * lib.fontSize
                                : Theme.fontSizeMedium * lib.fontSize
                anchors {
                    left: playingIcon.right
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
            }

            onClicked: {
                TheFunctions.chooseStation((searchMode ? filteredModel : qmlListModel), index)
                playStream()
            }
            menu: ContextMenu {
                MenuItem {
                    enabled: model.section !== "Suosikit"
                    visible: enabled
                    text: "Lisää suosikkeihin"
                    onClicked: {
                        var notFound = true
                        for(var i = 0; qmlListModel.get(i).section === "Suosikit"; i++) {
                            if(qmlListModel.get(i).title === model.title) {
                                notFound = false
                                break
                            }
                        }

                        if(notFound) {
                            favModel.append({
                                                "title": model.title,
                                                "source": model.source,
                                                "site": model.site,
                                                "section": "Suosikit"})
                            qmlListModel.insert(i, {
                                                    "title": model.title,
                                                    "source": model.source,
                                                    "site": model.site,
                                                    "section": "Suosikit"})
                            TheFunctions.overwriteFavs(favModel)

                            // Fix the playing index accordingly
                            if(mprisPlayer.stationIndex > i)
                                mprisPlayer.stationIndex = mprisPlayer.stationIndex + 1
                        }
                    }
                }
                MenuItem {
                    id: deleteMenuItem
                    enabled: model.section === "Suosikit"
                    visible: enabled
                    text: "Poista suosikeista"
                    property bool actuallyRemove: false
                    onClicked: actuallyRemove = true
                }
                onClosed: {
                    console.log("context menu closed")

                    if(!deleteMenuItem.actuallyRemove)
                        return

                    var i

                    for(i = 0; i < favModel.count; i++) {
                        if(favModel.get(i).title === model.title) {
                            favModel.remove(i, 1)
                            TheFunctions.overwriteFavs(favModel)
                            break
                        }
                    }

                    if(deleteMenuItem.actuallyRemove) {
                        for(i = 0; i < qmlListModel.count; i++) {
                            if(qmlListModel.get(i).section !== "Suosikit") {
                                break
                            }
                            if(qmlListModel.get(i).title === model.title) {
                                qmlListModel.remove(i, 1)

                                // Fix the playing index accordingly
                                if(mprisPlayer.stationIndex > i)
                                    mprisPlayer.stationIndex = mprisPlayer.stationIndex - 1

                                break
                            }
                        }
                    }
                }
            }
        }
    }
}
