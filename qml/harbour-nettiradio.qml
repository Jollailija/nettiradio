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
import QtQuick.LocalStorage 2.0
import "Pages"
import "Pages/StationLists"
import "Pages/storage.js" as Storage
import "Pages/functions.js" as TheFunctions // :)

ApplicationWindow
{
    Audio {
        id: playMusic
        source: lib.musicSource
        volume: lib.volume
        autoPlay: true
        onError: resurrector.start(), console.warn(" Error! Start resurrector! ")
        onPlaying: {resurrector.stop, console.warn(" OK, playing! (Stop resurrector) "); lib.playing = true; lib.stopped = false}
        onStopped: {lib.playing = false; lib.stopped = true} //Should update buttons on incoming call and stuff
        onPaused: {lib.playing = false; lib.stopped = false}
        onMutedChanged: pauseStream()
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
        onTriggered: {playStream(); console.log(lib.keepAliveMode)}
        running: lib.keepAliveMode
                 ? lib.playing
                 : lib.sleepTime >= 0 && lib.playing // This should save some CPU while sleepTimer is off
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
    Timer {
        id: listFiller
        running: qmlListModel.count < 1
        repeat: true
        interval: 100
        onTriggered: {
            //console.log("Filling list!")
            if (stationsModel.count > 0)
            {console.log("Items found, let's fill list!");fillList()}
            //else {console.log("Still loading, "+ stationsModel.progress*100 + "%")}
        }
    }
    Item {
        id: lib
        property string radioStation: "Valitse asema"
        property string musicSource
        property string website
        property string query: "/rss/channel1/item"
        property int sleepTime: -1
        property bool playing: false
        property bool stopped: true
        property bool activeView: true
        property bool localSource: false // false for releases
        property int stationCount: 5
        property real fontSize: 1
        property bool keepAliveMode: false
        property int stationIndex: 0 // in case there is a station at startup there will be a valid index
        property real volume: 1.0
    }

    ListModel{id:qmlListModel;property string filterProperty: 'title'}
    StationsModel{id:stationsModel}

    function fillList() {
        lib.stationCount = stationsModel.count
        console.log("fillList() is doing stuff")
        qmlListModel.clear() // This way the list will be up to date and not multiply
        var i = 0
        for (var r = 0; r < lib.stationCount; r++) {
            qmlListModel.append({"title": stationsModel.get(i).title, "source": stationsModel.get(i).source, "site": stationsModel.get(i).site, "section": stationsModel.get(i).section})
            i ++
            //console.log(i)
        }
        console.log("this many stations: " + i)
        Storage.getFavsFromDB(qmlListModel)
        console.log("Got favs from db")
    }
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All

    RemorsePopup {id: remorse; anchors.top: parent.top}

    function openWebsite() {remorse.execute("Avataan verkkosivu", function() {Qt.openUrlExternally(lib.website)}, 3000)}

    function pauseStream() {playMusic.pause(); resurrector.stop()}
    function playStream() {playMusic.play()}
    function stopStream() {playMusic.stop(); resurrector.stop()}

    initialPage: Qt.resolvedUrl("Pages/MainPage.qml")
    cover: Qt.resolvedUrl("Pages/CoverPage.qml")

    Component.onCompleted: {
        console.log("QML completed, initializing lib...")
        TheFunctions.initializeLib()
        console.log("QML completed, lib initialized.")
    }
}
