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

function initializeLib() {
    console.log("Filling lib")
    var firstTime="Unknown" // If the setting returns "Unknown" this must be the first time
    Storage.initialize()
    console.log("First time? " + Storage.getSetting("firstTime"))
    if (Storage.getSetting("firstTime")===firstTime) {
        console.log("This is the first time")
        setDefaultSettings()
    }
    else {
        loadSettings()
    }
    console.log("Lib filled.")
}

function setDefaultSettings() {
    console.log("Setting settings :)")
    Storage.initialize()
    Storage.setSetting("fontSize","1")
    Storage.setSetting("suStation","Valitse asema") // def. startup values
    Storage.setSetting("suWebsite","https://github.com/jollailija/nettiradio/")
    Storage.setSetting("suUrl","")
    //Storage.setSetting("xmlLocation","http://jollailija.github.io/nettiradio/asemat.xml")
    Storage.setSetting("firstTime","no")
    console.log("Settings set. Loading settings")
    loadSettings()
}

function loadSettings() {
    console.log("Loading settings")
    var autoplay="true"
    Storage.initialize()
    lib.fontSize = (Storage.getSetting("fontSize"))
    lib.radioStation = (Storage.getSetting("suStation")) // def. startup values
    lib.website = (Storage.getSetting("suWebsite"))
    lib.musicSource = (Storage.getSetting("suUrl"))
    //lib.xmlLocation = (Storage.getSetting("xmlLocation"))
    refreshMpris()
    console.log("Settings loaded")
}

function setStartupStation() {
    console.log("Setting startup station")
    Storage.initialize()
    Storage.setSetting("suStation",lib.radioStation)
    Storage.setSetting("suWebsite",lib.website)
    Storage.setSetting("suUrl",lib.musicSource)
    console.log("Done")
}

function resetStartupStation() {
    console.log("Resetting startup station")
    Storage.initialize()
    Storage.setSetting("suStation","Valitse asema")
    Storage.setSetting("suWebsite","https://github.com/jollailija/nettiradio/")
    Storage.setSetting("suUrl","")
    console.log("Done")
}

function chooseStation(listM, i) {
    lib.stationCount = listM.count
    if (lib.stationCount > lib.stationIndex) {
        lib.musicSource = Qt.resolvedUrl(listM.get(i).source)
        lib.website = Qt.resolvedUrl(listM.get(i).site)
        lib.radioStation = listM.get(i).title
        lib.stationIndex = i+1 // for the cover action
        lib.panelOpen = true
    }
    else{
        lib.musicSource = Qt.resolvedUrl(listM.get(0).source)
        lib.website = Qt.resolvedUrl(listM.get(0).site)
        lib.radioStation = listM.get(0).title
        lib.stationIndex = 1 // for the cover action
    }
    refreshMpris()
}

function saveFontSize (size) {
    Storage.initialize()
    Storage.setSetting("fontSize",size)
}

function refreshList(whichList) {
    whichList.clear()
    Storage.initialize()
    Storage.getFavsFromDB(whichList)
    refreshMpris()
}

function overwriteFavs(sourceList) {
    Storage.initialize()
    Storage.dropDB("stations")
    Storage.initialize() //  Re-create the table
    var i = 0
    console.log("Stuff:" + sourceList + sourceList.count)
    for (var r = 0; r < sourceList.count; r++) {
        Storage.setStationInDB(sourceList.get(i).title, sourceList.get(i).source, sourceList.get(i).site, sourceList.get(i).section)
        i ++
    }
    console.log("This many favourites: " + i)
}

function moveListItem(model, oldIndex, newIndex) {
    model.move(oldIndex, newIndex, 1)
}
