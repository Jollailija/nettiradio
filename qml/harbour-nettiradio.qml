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
import QtMultimedia 5.0
//import QtFeedback 5.0
import Sailfish.Silica 1.0
import "Pages"
import "Pages/StationLists"

ApplicationWindow
{
    Audio {
        id: playMusic
        source: lib.musicSource
        autoPlay: false
        onError: resurrector.start(), console.warn(" Error! Start resurrector! ")
        onPlaying: resurrector.stop, console.warn(" OK! Stop resurrector! ")
    }

    // Dunno what I did but seems to work

    Timer {
        id: resurrector
        interval: 1000
        repeat: false
        onTriggered: console.warn(" Not OK! "), console.warn(playMusic.errorString), playStream()
    }

    Timer {
        id: keepAliveHelper
        interval: 5000
        repeat: true
        onTriggered: playStream()
        running: lib.playing
    }

    Timer {
        id: sleepTimer
        interval: 60000
        repeat: false
        onTriggered: (lib.sleepTime === 0)
                     ? (stopStream(),  lib.sleepTime = -1, console.warn(" Sleeptimer at 0, shutting stream down "))
                     : lib.sleepTime = (lib.sleepTime - 1)
        running: lib.sleepTime >= 0
    }
    Item {
        id: lib
        property string radioStation: "Valitse asema"
        property string musicSource: ""
        property string website: "https://github.com/jollailija/nettiradio"
        property int sleepTime: -1
        property bool playing: false
        property bool stopped: true
        property bool activeView: true
        property bool localSource: false // false for releases
        property int stationCount: 1
    }

    Component{QmlListModel{id:qmlListModel}}
    Component{StationsModel{id:stationsModel}}

    function fillList() {
        var i = 0
        for (var r = 0; r < 10; r++) {
            qmlListModel.append({"title": stationsModel.get(i).title})
            i ++
            console.log(i)
        }
    }

    Timer {
        interval: 5000
        repeat: false
        onTriggered: {fillList(); console.log("fill")}
        running: true
    }

    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All

    RemorsePopup {id: remorse}

    function openWebsite() {
        remorse.execute("Avataan verkkosivu", function() {Qt.openUrlExternally(lib.website)}, 3000)
    }

    function pauseStream() {playMusic.pause(); lib.playing = false; lib.stopped = false; resurrector.stop()}
    function playStream() {playMusic.play(); lib.playing = true; lib.stopped = false}
    function stopStream() {playMusic.stop(); lib.playing = false; lib.stopped = true; resurrector.stop()}

    initialPage: Qt.resolvedUrl("Pages/MainPage.qml")

    cover: Qt.resolvedUrl("Pages/CoverPage.qml")


}
