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

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "storage.js" as Storage
import "functions.js" as TheFunctions // :)

Page {
    SilicaFlickable {
        RemorsePopup {id: remorse; anchors.top: parent.top}
        id: menuPage
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge
        VerticalScrollDecorator {}
        Column {
            id: column
            width: parent.width
            anchors.margins: Theme.paddingLarge
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("Valikko")
            }
            Button {
                text: qsTr("Käyttöohje")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("Help.qml"))
                }
            }
            Button {
                text: qsTr("Tietoa sovelluksesta")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("About.qml"))
                }
            }
            Button {
                text: qsTr("Uniajastin")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("SleepTimerPage.qml"))
                }
            }
            Button {
                text: qsTr("Muokkaa suosikkeja")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("FavManager.qml"))
                }
            }
            SectionHeader {
                id: settings
                text: qsTr("Asetukset")
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeLarge * 2 * lib.fontSize
                                : Theme.fontSizeMedium * lib.fontSize
            }
            SectionHeader {
                text: qsTr("Työkalut")
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeMedium * lib.fontSize
                                : Theme.fontSizeSmall * lib.fontSize
            }
            Button {
                text: qsTr("Päivitä lista")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    qmlListModel.clear()
                    stationsModel.reload()
                    listFiller.start()
                    lib.panelOpen = true
                }
            }
            Label {
                x: Theme.paddingLarge
                text: qsTr("Jos nappulat sekoavat, toiston lopettaminen auttaa.")
                width: parent.width - (Theme.paddingLarge * 2)
                wrapMode: Text.Wrap
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeLarge * lib.fontSize
                                : Theme.fontSizeMedium * lib.fontSize
            }
            Button {
                text: qsTr("Lopeta toisto")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    resurrector.stop()
                    lib.playing = false
                    lib.stopped = true
                    playMusic.stop()
                }
            }
            TextSwitch {
                id: palautumismoodi
                text: qsTr("Palautumismoodi")
                enabled: !lib.keepAliveMode
                description: qsTr("Tuhlaa hieman virtaa, mutta selviytyy paremmin katkoista. Poista käytöstä käynnistämällä sovellus uudelleen.")
                checked: lib.keepAliveMode
                onCheckedChanged: {lib.keepAliveMode = true, console.log("Kytkin " + lib.keepAliveMode)}
            }
            SectionHeader {
                text: qsTr("Oletuskanava")
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeMedium * lib.fontSize
                                : Theme.fontSizeSmall * lib.fontSize
            }
            Label {
                x: Theme.paddingLarge
                text: qsTr("Aseta nykyinen kanava soimaan käynnistäessä tai poista oletuskanava käytöstä")
                width: parent.width - (Theme.paddingLarge * 2)
                wrapMode: Text.Wrap
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeLarge * lib.fontSize
                                : Theme.fontSizeMedium * lib.fontSize
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: Theme.paddingLarge
                Button {
                    text: qsTr("Aseta")
                    onClicked: TheFunctions.setStartupStation()
                }
                Button {
                    text: qsTr("Poista")
                    onClicked: TheFunctions.resetStartupStation()
                }
            }
            SectionHeader {
                text: qsTr("Äänenvoimakkuus")
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeMedium * lib.fontSize
                                : Theme.fontSizeSmall * lib.fontSize
            }
            Label {
                x: Theme.paddingLarge
                text: qsTr("Hiljennä äänenvoimakkuutta. Oletusarvo on 1.0. Nollautuu käynnistettäessä sovellus uudelleen.")
                width: parent.width - (Theme.paddingLarge * 2)
                wrapMode: Text.Wrap
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeLarge * lib.fontSize
                                : Theme.fontSizeMedium * lib.fontSize
            }
            Slider {
                value: 1.0
                minimumValue: 0.1
                maximumValue: 1.0
                stepSize: 0.1
                width: parent.width
                handleVisible: true
                valueText: value
                label: qsTr("Äänenvoimakkuus")
                onReleased: lib.volume = value
            }
            SectionHeader {
                text: qsTr("Tekstin koko")
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeMedium * lib.fontSize
                                : Theme.fontSizeSmall * lib.fontSize
            }
            Label {
                x: Theme.paddingLarge
                text: qsTr("Säädä tekstin kokoa. Oletusarvo on 1.0")
                width: parent.width - (Theme.paddingLarge * 2)
                wrapMode: Text.Wrap
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeLarge * lib.fontSize
                                : Theme.fontSizeMedium * lib.fontSize
            }
            Slider {
                value: lib.fontSize
                minimumValue: 0.5
                maximumValue: 2.0
                stepSize: 0.1
                width: parent.width
                handleVisible: true
                valueText: value
                label: qsTr("Fonttikoko")
                onReleased: lib.fontSize = value, TheFunctions.saveFontSize(value)
            }
            SectionHeader {
                text: qsTr("Nollaa asetukset")
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeMedium * lib.fontSize
                                : Theme.fontSizeSmall * lib.fontSize
            }
            Button {
                text: qsTr("Nollaa")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: remorse.execute("Nollataan asetukset", TheFunctions.setDefaultSettings(), 5000)
            }
        }
    }
}
