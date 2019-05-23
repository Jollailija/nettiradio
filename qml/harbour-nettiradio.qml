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
import QtMultimedia 5.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import org.nemomobile.mpris 1.0
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
        onError: {
            resurrector.start()
            console.warn(" Error! Start resurrector! ")
        }
        onPlaying: {
            resurrector.stop
            console.warn(" OK, playing! (Stop resurrector) ")
            lib.playing = true
            lib.stopped = false
        }
        onStopped: { // Should update buttons on incoming call and stuff
            lib.playing = false
            lib.stopped = true
        }
        onPaused: {
            lib.playing = false
            lib.stopped = false
        }
        onMutedChanged: pauseStream()
    }

    function refreshMpris() {
        mprisPlayer.artist = lib.radioStation
        mprisPlayer.song = "Nettiradio"
        switch (lib.playing) {
        case true:
            mprisPlayer.playbackStatus = Mpris.Playing
            break;
        case false:
            if (lib.stopped) {
                mprisPlayer.playbackStatus = Mpris.Paused
            }
            else {
                mprisPlayer.setCanPause(false)
                mprisPlayer.playbackStatus = Mpris.Paused
            }
            break;
        default:
            mprisPlayer.playbackStatus = Mpris.Paused
        }
    }

    MprisPlayer {
        id: mprisPlayer
        property string artist
        property string song

        serviceName: "harbour-nettiradio"
        identity: "Nettiradio"

        supportedUriSchemes: ["file"]
        supportedMimeTypes: ["audio/x-wav", "audio/x-vorbis+ogg", "audio/mpeg", "audio/mp4a-latm", "audio/x-aiff"]

        playbackStatus: Mpris.Stopped
        loopStatus: Mpris.None
        shuffle: false
        volume: lib.volume

        canControl: true
        canPause: true
        canPlay: true
        canSeek: false
        canGoNext: true
        canGoPrevious: true
        hasTrackList:false

        onPlayRequested: playStream()
        onPlayPauseRequested: pauseStream()
        onStopRequested: stopStream()
        onNextRequested: TheFunctions.chooseStation(qmlListModel,(lib.stationIndex))
        onPreviousRequested: TheFunctions.chooseStation(qmlListModel,(lib.stationIndex - 2))

        onArtistChanged: {
            var metadata = mprisPlayer.metadata
            metadata[Mpris.metadataToString(Mpris.Artist)] = artist
            mprisPlayer.metadata = metadata
        }

        onSongChanged: {
            var metadata = mprisPlayer.metadata
            metadata[Mpris.metadataToString(Mpris.Title)] = song
            mprisPlayer.metadata = metadata
        }

        // I'll list these just incase I figure out what to do with them :)
        onSeekRequested: {}
        onSetPositionRequested: {}
        onOpenUriRequested: {}
        onLoopStatusRequested: {}
        onShuffleRequested: {}
    }

    // Dunno what I did but seems to work
    Timer {
        id: resurrector
        interval: 1000
        repeat: false
        onTriggered: {
            console.warn(" Not OK! ")
            console.warn(playMusic.errorString)

            if(playMusic.errorString !== "The QMediaPlayer object does not have a valid service")
                playStream()
            else
                console.log("Giving up.")
        }
    }
    Timer {
        id: keepAliveHelper
        interval: 5000
        repeat: true
        onTriggered: {
            playStream()
            console.log(lib.keepAliveMode)
        }
        running: lib.keepAliveMode
                 ? lib.playing
                 : lib.sleepTime >= 0 && lib.playing // This should save some CPU while sleepTimer is off
    }
    Timer {
        id: sleepTimer
        interval: 60000
        repeat: false
        onTriggered: {
            if(lib.sleepTime === 0) {
                if(lib.closeAppAfterSleepTime) {
                    console.warn(" Sleeptimer at 0, shutting down ")
                    Qt.quit()
                }
                else {
                    stopStream()
                    lib.sleepTime = -1
                    console.warn(" Sleeptimer at 0, shutting stream down ")
                }
            }
            else {
                lib.sleepTime = (lib.sleepTime - 1)
            }
        }
        running: lib.sleepTime >= 0
    }
    Timer {
        id: listFiller
        running: qmlListModel.count < 50
        repeat: true
        interval: 250
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
        //property string xmlLocation: "https://jollailija.github.io/nettiradio/asemat.xml"
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
        property bool panelOpen: true
        property bool closeAppAfterSleepTime: false
    }

    ListModel {
        id:qmlListModel
        property string filterProperty: 'title'
    }

    StationsModel { id:stationsModel }

    ListModel { id:filteredModel }

    ListModel { id:favModel }

    function fillList() {
        lib.stationCount = stationsModel.count
        console.log("fillList() is doing stuff")
        qmlListModel.clear() // This way the list will be up to date and not multiply
        var i = 0
        for (var r = 0; r < lib.stationCount; r++) {
            qmlListModel.append({
                                    "title": stationsModel.get(i).title,
                                    "source": stationsModel.get(i).source,
                                    "site": stationsModel.get(i).site,
                                    "section": stationsModel.get(i).section
                                })
            i++
            //console.log(i)
        }
        console.log("this many stations: " + i)
        Storage.getFavsFromDB(qmlListModel)
        console.log("Got favs from db")
        refreshMpris()
    }
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All

    RemorsePopup {id: remorse; anchors.top: parent.top}

    function openWebsite() {
        remorse.execute("Avataan verkkosivu", function() {Qt.openUrlExternally(lib.website)}, 3000)
    }

    function pauseStream() {
        playMusic.pause()
        resurrector.stop()
        refreshMpris()
    }

    function playStream() {
        playMusic.play()
        refreshMpris()
    }

    function stopStream() {
        playMusic.stop()
        resurrector.stop()
        refreshMpris()
    }

    initialPage: Qt.resolvedUrl("Pages/MainPage.qml")

    cover: Qt.resolvedUrl("Pages/CoverPage.qml")

    Component.onCompleted: {
        console.log("QML completed, initializing lib...")
        TheFunctions.initializeLib()
        console.log("QML completed, lib initialized.")
    }
}
