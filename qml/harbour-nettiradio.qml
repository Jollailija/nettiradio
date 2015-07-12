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
import QtMultimedia 5.0
import Sailfish.Silica 1.0

ApplicationWindow
{
    Audio {
            id: playMusic
            source: musicSource.text
            autoPlay: true
            }
    Text {
        //This is my way to do stuff :P Also, commenting out the y value is great for testing
        y: 100000
        id: musicSource
        text: "http://icelive0.43660-icelive0.cdn.qbrick.com/4912/43660_iskelma.mp3"
    }
    Text {
        y: 200000
        id: radioStation
        text: "Iskelmä"
    }
    Text {
        y: 300000
        id: playing
        text: "1"
    }
    initialPage: Component { Page {
            id: mainPage

            DockedPanel {
                    id: panel

                    width: parent.width
                    height: Theme.itemSizeExtraLarge + Theme.paddingLarge

                    dock: Dock.Bottom
                    open: true

                    Row {
                        anchors.centerIn: parent
                        id: iconButtons
                        spacing: Theme.paddingLarge


                        Button {
                            id: listeningTo
                            text: radioStation.text
                            onClicked: playMusic.pause()
                        }

                        IconButton {
                            id: pause
                            icon.source: "image://theme/icon-l-pause"
                            onClicked: {playing.text = "0"
                                playMusic.pause()}
                            enabled: playing.text == "1"
                        }
                        IconButton {
                            id: play
                            icon.source: "image://theme/icon-l-play"
                            onClicked: {playing.text = "1"
                                playMusic.play()}
                            enabled: playing.text == "0"
                        }
                    }
                }

            ListModel {
                id: stationsList
                ListElement {
                    source: "http://188.117.44.132:8000/stream.m3u"
                    title: "Bassoradio"
                    section: "Valtakunnalliset" //National
                }
                ListElement {
                    source: "http://stream.radioclassic.fi:8000/rh256"
                    title: "Classic"
                    section: "Valtakunnalliset" //National
                }
                ListElement {
                    source: "http://icelive0.43660-icelive0.cdn.qbrick.com/4912/43660_iskelma.mp3"
                    title: "Iskelmä"
                    section: "Valtakunnalliset" //National
                }
                ListElement {
                    source: "http://icelive0.43660-icelive0.cdn.qbrick.com/4659/43660_iskelma_aikakone.mp3"
                    title: "Iskelmä Aikakone"
                    section: "Valtakunnalliset" //National
                }
                ListElement {
                    source: "http://icelive0.80596-icelive0.cdn.qbrick.com/9168/80596_loop.mp3"
                    title: "Loop"
                    section: "Valtakunnalliset" //National
                }
                ListElement {
                    source: "http://icelive0.41168-icelive0.cdn.qbrick.com/5050/41168_radionova1.mp3"
                    title: "Nova"
                    section: "Valtakunnalliset" //National
                }
                ListElement {
                    source: "http://icelive0.80596-icelive0.cdn.qbrick.com/10544/80596_RadioAalto.mp3"
                    title: "Radio Aalto"
                    section: "Valtakunnalliset" //National
                }
                ListElement {
                    source: "http://icelive0.43660-icelive0.cdn.qbrick.com/4916/43660_radio_city.mp3"
                    title: "Radio City"
                    section: "Valtakunnalliset" //National
                }
                ListElement {
                    source: "http://adwzg4.tdf-cdn.com/9201/nrj_113217.mp3"
                    title: "Radio Nostalgia"
                    section: "Valtakunnalliset" //National
                }
                ListElement {
                    source: "http://adwzg4.tdf-cdn.com/8945/nrj_179479.mp3"
                    title: "Radio NRJ"
                    section: "Valtakunnalliset" //National
                }
                ListElement {
                    source: "http://icelive0.80596-icelive0.cdn.qbrick.com/10545/80596_RadioRock.mp3"
                    title: "Radio Rock"
                    section: "Valtakunnalliset" //National
                }
                ListElement {
                    source: "http://icelive0.80596-icelive0.cdn.qbrick.com/10555/80596_RadioSuomipop.mp3"
                    title: "Radio Suomipop"
                    section: "Valtakunnalliset" //National
                }
                ListElement {
                    source: "http://icelive0.43660-icelive0.cdn.qbrick.com/4914/43660_thevoice.mp3"
                    title: "The Voice"
                    section: "Valtakunnalliset" //National
                }
                ListElement {
                    source: "http://icelive0.43660-icelive0.cdn.qbrick.com/4657/43660_thevoice_fresh.mp3"
                    title: "The Voice Herättäjät"
                    section: "Valtakunnalliset" //National
                }
                ListElement {
                    source: "http://nettiradio.auranaallot.fi/stream"
                    title: "Auran Aallot"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://st.downtime.fi/fun.mp3.m3u"
                    title: "FUN Tampere"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://icelive0.80596-icelive0.cdn.qbrick.com/10547/80596_GrooveFM.mp3"
                    title: "Groove FM"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://media.innoventum.fi:8000/radiorex.m3u"
                    title: "Iskelmä Rex"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://radio.6net.fi:8000/jarviradio.m3u"
                    title: "Järviradio"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://icelive0.80596-icelive0.cdn.qbrick.com/10162/80596_MetroHelsinki.mp3"
                    title: "Metro Helsinki"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://stream2.sbs.fi/play.mp3"
                    title: "Play"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://media2.innoventum.fi:8000/radiocityjoensuu.m3u"
                    title: "Radio City Joensuu"
                    section: "Paikalliset" //Local radio stations
                }

                ListElement {
                    source: "http://213.186.227.18:8000/eazy.mp3.m3u"
                    title: "Radio Eazy 101"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://radio.radiohelsinki.fi/rh256"
                    title: "Radio Helsinki"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://icelive0.43660-icelive0.cdn.qbrick.com/9883/43660_RadioJyvaskyla.mp3"
                    title: "Radio Jyväskylä"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://radio.6net.fi:8000/radiokajaus.m3u"
                    title: "Radio Kajaus"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://153.1.15.26:8080/moreeni.mp3"
                    title: "Radio Moreeni"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://suomiradio.pro:8040/rh256"
                    title: "Radio Musa"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://icelive0.43660-icelive0.cdn.qbrick.com/4918/43660_radio_pooki.mp3"
                    title: "Radio Pooki"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://213.186.227.18:8000/radiopori.mp3.m3u"
                    title: "Radio Pori"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://radioaktiivinen.lappia.fi:8000/play.mp3.m3u"
                    title: "Radio Pro"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://213.141.104.154:8000/stream/1/"
                    title: "Radio Ramona"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://suomiradio.pro:8080/rh256/"
                    title: "Radio Sandels"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://st.downtime.fi/sun.mp3.m3u"
                    title: "Radio SUN"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://stream.anviawebcasting.com:8000/radiovaasa.m3u"
                    title: "Radio Vaasa"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://st.downtime.fi/sunclassics.mp3.m3u"
                    title: "SUN Classics"
                    section: "Paikalliset" //Local radio stations
                }
                ListElement {
                    source: "http://adwzg4.tdf-cdn.com/9199/nrj_112804.mp3"
                    title: "NRJ Suomihitit"
                    section: "NRJ-kanavat"
                }
                ListElement {
                    source: "http://adwzg4.tdf-cdn.com/8773/nrj_178606.mp3 	"
                    title: "NRJ UK Top 40"
                    section: "NRJ-kanavat"
                }
                ListElement {
                    source: "http://adwzg3.tdf-cdn.com/8497/nrj_164590.mp3"
                    title: "NRJ Dance"
                    section: "NRJ-kanavat"
                }
                ListElement {
                    source: "http://adwzg3.tdf-cdn.com/8622/nrj_164052.mp3"
                    title: "NRJ Fitness"
                    section: "NRJ-kanavat"
                }
                ListElement {
                    source: "http://adwzg3.tdf-cdn.com/8559/nrj_175788.mp3"
                    title: "NRJ Ibiza"
                    section: "NRJ-kanavat"
                }
                ListElement {
                    source: "http://adwzg3.tdf-cdn.com/8595/nrj_165941.mp3"
                    title: "NRJ Latino"
                    section: "NRJ-kanavat"
                }
                ListElement {
                    source: "http://adwzg3.tdf-cdn.com/8503/nrj_175068.mp3"
                    title: "NRJ Lounge"
                    section: "NRJ-kanavat"
                }
                ListElement {
                    source: "http://adwzg3.tdf-cdn.com/8615/nrj_169454.mp3"
                    title: "NRJ Love"
                    section: "NRJ-kanavat"
                }
                ListElement {
                    source: "http://adwzg3.tdf-cdn.com/8542/nrj_169073.mp3"
                    title: "NRJ Extravadance"
                    section: "NRJ-kanavat"
                }
                ListElement {
                    source: "http://adwzg3.tdf-cdn.com/8578/nrj_168019.mp3"
                    title: "NRJ Rap US"
                    section: "NRJ-kanavat"
                }
                ListElement {
                    source: "http://adwzg3.tdf-cdn.com/8485/nrj_169683.mp3"
                    title: "NRJ RnB"
                    section: "NRJ-kanavat"
                }
                ListElement {
                    source: "http://adwzg3.tdf-cdn.com/8527/nrj_177497.mp3"
                    title: "NRJ Rock"
                    section: "NRJ-kanavat"
                }
                ListElement {
                    source: "http://adwzg3.tdf-cdn.com/8530/nrj_165311.mp3"
                    title: "NRJ Running"
                    section: "NRJ-kanavat"
                }
                ListElement {
                    source: "http://s3.radioboss.fm:8301/live.m3u"
                    title: "MyStation"
                    section: "Tilapäiset"
                }
                ListElement {
                    source: "http://suomiradio.pro:8000/hr256"
                    title: "Pispalan Radio 995"
                    section: "Tilapäiset"
                }
                ListElement {
                    source: "http://stream.klf.fi:8000/stream.m3u"
                    title: "Radio KLF"
                    section: "Tilapäiset"
                }
                ListElement {
                    source: "http://46.163.245.15:8000/radio.m3u"
                    title: "Radio Patmos"
                    section: "Tilapäiset"
                }
                ListElement {
                    source: "http://streaming.shoutcast.com/RadioRapu"
                    title: "Radio Rapu"
                    section: "Tilapäiset"
                }
            }
            SilicaListView {
                VerticalScrollDecorator {}
                id: listView
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    //bottom: panel.top
                }
                height: parent.height * 0.75

                model: stationsList
                PullDownMenu {
                    MenuItem {
                        text: qsTr("Tietoa sovelluksesta") //About
                        onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
                    }
                    MenuItem {
                        text: qsTr("Käyttöohje") //Help
                        onClicked: pageStack.push(Qt.resolvedUrl("Help.qml"))
                    }
                }
                header: PageHeader { title: "Kaupalliset radioasemat" } //Radio stations
                section {
                    property: 'section'
                    delegate: SectionHeader {
                        text: section
                    }
                }
                delegate: BackgroundItem {
                    width: listView.width
                    Label {
                        id: firstName
                        text: model.title
                        color: highlighted ? Theme.highlightColor : Theme.primaryColor
                        anchors.verticalCenter: parent.verticalCenter
                        x: Theme.paddingLarge
                    }
                    onClicked: {musicSource.text = (Qt.resolvedUrl(source))
                        playMusic.source = musicSource.text
                        radioStation.text = title
                        playing.text = 1
                    }
                }

            }
        }
    }
    cover: Component {
        CoverBackground {
            property var textAlignment: TextInput.AlignCenter

            Image {
               id: logo
               source: "harbour-nettiradio.png"
               anchors.horizontalCenter: parent.horizontalCenter
               y: parent.height * 0.2
             }
            TextArea {
                y: parent.height * 0.5
                text: radioStation.text
                width: parent.width
                x: 25
                readOnly: true
                horizontalAlignment: textAlignment
            }

            CoverActionList {
                id: coverAction

                CoverAction {
                    iconSource: "image://theme/icon-cover-pause"
                    onTriggered: {playMusic.pause()
                        playing.text = "0"}
                }

                CoverAction {
                    iconSource: "image://theme/icon-cover-play"
                    onTriggered: {playMusic.play()
                        playing.text = "1"}
                }
            }
        }
    }
}
