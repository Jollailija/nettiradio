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
    property var textAlignment: TextInput.AlignLeft
    SilicaFlickable {
        RemorsePopup {id: remorse; anchors.top: parent.top}
        anchors.fill: parent
        clip: true
        contentHeight: header.height + version.height + text.height + links.height + flattr.height + Theme.paddingLarge * 4
        contentWidth: parent.width
        VerticalScrollDecorator {}

        PageHeader {
            id: header
            title: qsTr("Tietoa sovelluksesta") //About
        }
        Button {
            id: version
            anchors.top: header.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Nettiradio for Sailfish 1.0"
            onClicked: Qt.openUrlExternally("https://github.com/Jollailija/nettiradio/tree/sfone")
        }
        Text {
            id: text
            onLinkActivated: remorse.execute(qsTr("Avataan linkki"), function() {Qt.openUrlExternally(link)}, 3000)
            anchors {
                top: version.bottom
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }
            width: parent.width
            wrapMode: Text.Wrap
            color: Theme.primaryColor
            linkColor: Theme.highlightColor
            textFormat: Text.StyledText
            text: qsTr("Tämä on sovellus kaikille suomalaisten nettiradioiden kuuntelijoille, tekijänä jollailija.<br><br>") +

                  qsTr("Nettiradioiden streamitiedot ovat peräisin lähteestä ") + "<a href='http://www.mediamonitori.fi/index.php/nettiradiot'>mediamonitori.fi</a>" + "<br>" +
                  qsTr("Muut lähteet on mainittu " +"<a href='https://jollailija.github.io/nettiradio/asemat.xml'>asemalistatiedostossa</a>.") + "<br>" +
                  qsTr("Kaikki radioasemat eivät lähetä nettistreamia Qt audioelementin ymmärtämässä formaatissa.") + "<br><br>" +

                  "<b>" + qsTr("Lähdekoodi on saatavilla BSD-lisenssillä ") + "<a href='https://github.com/jollailija/nettiradio'>GitHub</a></b>"+ qsTr("ista ja sovelluksen uusimmat versiot löytyvät ") + "<b><a href='https://openrepos.net/content/jollailija/finnish-net-radio-client-beta/'>OpenRepos</a></b>"+ qsTr("ista.") + "<br>" +
                  qsTr("Jos sinulla on kysymyksiä, asema- ja ominaisuustoiveita tai palautetta, voit kirjoittaa kommentin Kauppaan tai OpenReposiin tai lähettää sähköpostia osoitteeseen jollailija@gmail.com") + "<br><br>" +
                  qsTr("Kiitos Daxille avusta koodin kanssa, r0kk3rz:ille AlphaMenun tekemisestä, Mothille hienosta ikonista sekä coderusille, kimmolille ja monille muille, jotka ovat jakaneet neuvojaan devel-postilitalla. Suuri kiitos myös kaikille Flattr-lahjoittajille.") + "<br><br>" +
                  "Thanks for all the support guys!" + "<br>"
            font.pixelSize: Screen.sizeCategory > Screen.Medium
                            ? Theme.fontSizeLarge * lib.fontSize
                            : Theme.fontSizeMedium * lib.fontSize
        }
        Row {
            id: links
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: text.bottom
            spacing: Theme.paddingLarge


            Button {
                text: qsTr("GitHub")
                onClicked: Qt.openUrlExternally("https://github.com/Jollailija/nettiradio/tree/sfone")
            }
            Button {
                text: qsTr("OpenRepos")
                onClicked: Qt.openUrlExternally("https://openrepos.net/content/jollailija/finnish-net-radio-client-beta/")
            }
        }
        Button {
            anchors.top: links.bottom
            anchors.topMargin: Theme.paddingLarge * 1.5
            anchors.horizontalCenter: parent.horizontalCenter
            id: flattr
            text: qsTr("Lahjoita Flattrin kautta")
            onClicked: Qt.openUrlExternally("https://flattr.com/thing/4382591/Jollailijanettiradio-on-github")
        }
    }
}
