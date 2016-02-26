/*
  Copyright (C) 2015 jollailija
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


Page {
    id: page
    property var textAlignment: TextInput.AlignLeft
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height
        contentWidth: parent.width
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingMedium
            PageHeader {
                id: header
                title: "Käyttöohje" //"How to use"
            }
            TextArea {
                anchors {
                    top: header.bottom
                    left: parent.left
                    right: parent.right
                }
                readOnly: true
                text: "Valitse haluamasi radioasema listalta. Aseman vaihdossa on muuteman sekunnin mittainen verkkopuskuroinnin viive.

Tällä hetkellä kuunneltavan radioaseman nimi näkyy näytön alaosassa.

Voit käynnistää tai pysäyttää toiston alaosan nappuloilla ja kannen pikavalinnoilla."
                /*text: "Choose any radio station by clicking it's name on the list. Name of the currently playing radio station is displayed in the panel at the bottom.
While inside the app, you can play & pause by using the icon buttons in the panel. You can also use the cover actions for pausing and resuming."*/
                font.pixelSize: Theme.fontSizeMedium
                horizontalAlignment: textAlignment
            }
        }
    }
}
