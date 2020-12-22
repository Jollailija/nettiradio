/*
  Copyright (C) 2015-2016 jollailija
  Contact: jollailija <jollailija@gmail.com>
  Copyright (C) 2019 Matti Viljanen
  Contact: Matti Viljanen <matti.viljanen@kapsi.fi>
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

Dialog {
    id: dialog
    property string title
    property string source: "http://"
    property string site: "http://"
    property bool updateMode: false
    SilicaFlickable {
        width: parent.width
        height: parent.height
        contentHeight: column.height
        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge

            DialogHeader {
                title: qsTr("Muokkaa suosikkia")}

            TextArea {
                id: titleInput
                width: parent.width
                inputMethodHints: Qt.ImhNoPredictiveText
                text: title
                placeholderText: qsTr("Aseman nimi")
                label: qsTr("Aseman nimi")
                EnterKey.onClicked: focus = false

            }
            TextArea {
                id: sourceInput
                width: parent.width
                inputMethodHints: Qt.ImhNoPredictiveText
                text: source
                placeholderText: qsTr("Streamin osoite")
                label: qsTr("Streamin osoite")
                EnterKey.onClicked: focus = false
            }
            TextArea {
                id: siteInput
                width: parent.width
                inputMethodHints: Qt.ImhNoPredictiveText
                text: site
                placeholderText: qsTr("Aseman nettisivu")
                label: qsTr("Aseman nettisivu")
                EnterKey.onClicked: focus = false
            }
            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Lisää nykyinen asema")
                enabled: !updateMode
                onClicked: {
                    titleInput.text = lib.radioStation
                    sourceInput.text = lib.musicSource
                    siteInput.text = lib.website
                    dialog.accept()
                }
            }
        }
    }
    onDone: {
        if (result === DialogResult.Accepted) {
            favModel.append({
                                "title": titleInput.text.replace(/(\r\n|\n|\r)/gm,"").trim(),
                                "source": sourceInput.text.replace(/(\r\n|\n|\r)/gm,"").trim(),
                                "site": siteInput.text.replace(/(\r\n|\n|\r)/gm,"").trim(),
                                "section": "Suosikit"})
        }
        TheFunctions.overwriteFavs(favModel)
        qmlListModel.clear()
        stationsModel.reload()
        listFiller.start()
    }
}
