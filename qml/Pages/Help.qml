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

Page {
    id: page
    SilicaFlickable {
        anchors.fill: parent
        clip: true
        contentHeight: header.height + text.height + Theme.paddingLarge
        contentWidth: parent.width

        VerticalScrollDecorator {}

        PullDownMenu {
            MenuItem {
                text: qsTr("Tietoa sovelluksesta") //About
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
        }
        PageHeader {
            id: header
            title: qsTr("Käyttöohje") //"How to use"
        }
        Text {
            id: text
            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }
            width: parent.width
            wrapMode: Text.Wrap
            color: Theme.primaryColor
            textFormat: Text.StyledText
            text: qsTr("Valitse haluamasi radioasema listalta. Aseman vaihdossa on muuteman sekunnin mittainen verkkopuskuroinnin viive. Asemia voi kelata myös kannesta käsin") + "<br><br>" +

                  qsTr("Tällä hetkellä kuunneltavan radioaseman nimi lukee näytön alaosassa. Painamalla sitä saat kyseisen <b>radioaseman nettisivun aukeamaan selaimessa</b>.") + "<br><br>" +

                  qsTr("Voit <b>käynnistää</b> tai <b>keskeyttää toiston</b> alaosan nappuloilla ja kannen nappulalla. Voit <b>lopettaa toiston</b> painamalla neliötä. Toiston lopettaminen lopettaa streamin lataamisen ja säästää näin akkua.") + "<br><br>" +

                  qsTr("<b>Näytön kierron lukitseminen</b> ja <b>asemalistanäkymän vaihtaminen</b> löytyvät vetovalikosta. Listanäkymässä ollessasi voit avata <b>hakulaatikon</b> vetovalikosta.") + "<br>" +

                  qsTr("<h3>Valikko</h3>")+ "<br>" +

                  qsTr("<b>Uniajastin</b> sammuttaa toiston asettamasi minuuttimäärän jälkeen. Sammutusaika valitaan <i>Uniajastin</i>-sivun liukuvalitsimella. Ajastin käynnistetään ja pysäytetään sivulta löytyvillä nappuloilla. <b>Jäljellä oleva aika</b> näkyy kannessa, ja ajastimen voi pysäyttää kannen pikavalinnalla.") + "<br><br>" +

                  qsTr("Voit lisätä tai poistaa <b>suosikkeja</b> <i>Muokkaa suosikkeja</i> -sivulla. Voit lisätä suosikiksi joko nykyisen aseman tai minkä tahansa sovelluksen tukemassa muodossa streamia lähettävän aseman. Suosikkiasemien nimien ja stream-osoitteiden täytyy olla uniikkeja.")+ "<br>" +

                  qsTr("Suosikkeihin tehdyt muutokset tallennetaan automaattisesti kolmen sekunnin välein. Voit myös tallentaa muutokset käsin valitsemalla vetovalikosta <i>Tallenna muutokset</i>.")+ "<br><br>" +

                  qsTr("Jos sovellus ei selviydy <b>yhteyskatkoista</b>, voit kokeilla <i>palautumismoodia</i>. Valikosta löytyy myös paljon mielenkiintoisia <b>asetuksia</b>, kokeile!")+ "<br><br>" +

                  qsTr("Jos sinulla on <b>kysymyksiä</b>, <b>asema-</b> ja <b>ominaisuustoiveita</b> tai <b>palautetta</b>, voit kirjoittaa kommentin Kauppaan tai OpenReposiin tai lähettää sähköpostia osoitteeseen") + "<b> jollailija@gmail.com</b>" + "<br><br>"

            font.pixelSize: Screen.sizeCategory > Screen.Medium
                            ? Theme.fontSizeLarge * lib.fontSize
                            : Theme.fontSizeMedium * lib.fontSize
        }
    }
}
