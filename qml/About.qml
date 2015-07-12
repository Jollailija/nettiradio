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
        contentHeight: header.height + text.height + links.height
        contentWidth: parent.width
        VerticalScrollDecorator {}

            PageHeader {
                id: header
                title: "Tietoa sovelluksesta" //About
            }

            TextArea {
                id: text
                anchors {
                    top: header.bottom
                    left: parent.left
                    right: parent.right
                }
                readOnly: true
                text: "Tämä on sovellus kaikille suomalaisten nettiradioiden kuuntelijoille, tekijänä jollailija.
Nettiradioiden streamitiedot ovat peräisin lähteestä www.mediamonitori.fi/index.php/nettiradiot
Kaikki radioasemat eivät lähetä nettistreamia Qt audioelementin ymmärtämässä formaatissa.

Lähdekoodi on saatavilla BSD-lisenssillä GitHubista ja sovelluksen uusimmat versiot löytyvät OpenRepos:ista (linkit alla).

Kiitos Daxille avusta koodin kanssa sekä Mothille hienosta ikonista.

Thanks for all the help Dax and Moth!"
                    /*text: "This app was made by jollailija for all Finnish net radio listeners to enjoy.

I'd like to thank Dax for helping me out with the code and Moth for the awesome icon."*/
                font.pixelSize: Theme.fontSizeMedium
                horizontalAlignment: textAlignment
            }

            Row {
                id: links
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text.bottom
                spacing: Theme.paddingLarge


                Button {
                    text: "GitHub"
                    onClicked: Qt.openUrlExternally("https://github.com/jollailija/nettiradio/")
                }
                Button {
                    text: "OpenRepos"
                    onClicked: Qt.openUrlExternally("https://openrepos.net/content/jollailija/finnish-net-radio-client-beta/")
                }
            }
    }
}
