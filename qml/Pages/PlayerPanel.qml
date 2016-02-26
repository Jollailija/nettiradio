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
import QtMultimedia 5.0

DockedPanel {
    width: parent.width
    height: Theme.itemSizeExtraLarge + Theme.paddingLarge
    dock: Dock.Bottom
    open: lib.panelOpen
    Row {
        anchors.centerIn: parent
        id: iconButtons
        spacing: Theme.paddingLarge
        Button {
            id: listeningTo
            text: Screen.sizeCategory > Screen.Medium
                  ? lib.radioStation
                  : mainPage.isPortrait
                    ? lib.radioStation.slice(0,23)
                    : lib.radioStation
            RemorsePopup {id: remorse}
            onClicked: openWebsite()
        }
        IconButton {
            id: pause
            icon.source: "icon-l-stop.png"
            onClicked: stopStream()
            enabled: !lib.stopped
        }
        IconButton {
            id: play
            icon.source: lib.playing
                         ? "image://theme/icon-l-pause"
                         : "image://theme/icon-l-play"
            onClicked: lib.playing
                       ? pauseStream()
                       : playStream()
        }
    }
}

