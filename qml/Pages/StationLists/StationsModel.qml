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
import Sailfish.Silica 1.0

/*
Q: Kuinka lisään oman aseman?

A: Täyttämällä ja lisäämällä tämän haluamaasi kohtaa listaa:

ListElement { // Katso, ettet laita tätä toisen ListElementin sisälle!
     // Tiedot täytetään lainausmerkkien sisälle
     source: "Verkkostreamin osoite HUOM! Ei sama kuin radioaseman verkkosivun osoite"
     title: "Tähän aseman nimi, joka näkyy sovelluksessa"
     site: "Aseman kotisivu, jonka voi avata selaimeen"
     section: "Asema lisätään listaan jonkin kategorian alle, esim. Valtakunnalliset"
} // Älä unohda loppuhakasulkua!

Jos asennat sovelluksen uudelleen tai päivität sen, menetät kaikki muutokset. Ota siis varmuuskopio.
*/

ListModel {

    ListElement {
        source: "http://188.117.44.132:8000/stream.m3u"
        title: "Bassoradio"
        site: "http://www.basso.fi/radio"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://stream.radioclassic.fi:8000/rh256"
        title: "Classic"
        site: "http://www.radioclassic.fi/"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://icelive0.43660-icelive0.cdn.qbrick.com/4912/43660_iskelma.mp3"
        title: "Iskelmä"
        site: "http://www.iskelma.fi/"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://icelive0.43660-icelive0.cdn.qbrick.com/4659/43660_iskelma_aikakone.mp3"
        title: "Iskelmä Aikakone"
        site: "http://www.iskelma.fi/"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://icelive0.80596-icelive0.cdn.qbrick.com/9168/80596_loop.mp3"
        title: "Loop"
        site: "http://www.loop.fi/"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://icelive0.41168-icelive0.cdn.qbrick.com/5050/41168_radionova1.mp3"
        title: "Nova"
        site: "http://www.radionova.fi/"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://icelive0.80596-icelive0.cdn.qbrick.com/10544/80596_RadioAalto.mp3"
        title: "Radio Aalto"
        site: "http://www.radioaalto.fi/"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://icelive0.43660-icelive0.cdn.qbrick.com/4916/43660_radio_city.mp3"
        title: "Radio City"
        site: "http://www.radiocity.fi/"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://isojako.radiodei.fi:8000/yleisohjelma"
        title: "Radio Dei"
        site: "http://www.radiodei.fi/"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://adwzg4.tdf-cdn.com/9201/nrj_113217.mp3"
        title: "Radio Nostalgia"
        site: "http://www.radionostalgia.fi/"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://adwzg4.tdf-cdn.com/8945/nrj_179479.mp3"
        title: "Radio NRJ"
        site: "http://www.nrj.fi/"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://icelive0.80596-icelive0.cdn.qbrick.com/10545/80596_RadioRock.mp3"
        title: "Radio Rock"
        site: "http://www.radiorock.fi/"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://icelive0.80596-icelive0.cdn.qbrick.com/10555/80596_RadioSuomipop.mp3"
        title: "Radio Suomipop"
        site: "http://www.radiosuomipop.fi/"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://icelive0.43660-icelive0.cdn.qbrick.com/4914/43660_thevoice.mp3"
        title: "The Voice"
        site: "http://www.voice.fi/"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://icelive0.43660-icelive0.cdn.qbrick.com/4657/43660_thevoice_fresh.mp3"
        title: "The Voice Herättäjät"
        site: "http://www.voice.fi/"
        section: "Valtakunnalliset"
    }
    ListElement {
        source: "http://nettiradio.auranaallot.fi/stream"
        title: "Auran Aallot"
        site: "http://www.auranaallot.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://st.downtime.fi/fun.mp3.m3u"
        title: "FUN Tampere"
        site: "http://www.funtampere.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://icelive0.80596-icelive0.cdn.qbrick.com/10547/80596_GrooveFM.mp3"
        title: "Groove FM"
        site: "http://www.groovefm.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://media.innoventum.fi:8000/radiorex.m3u"
        title: "Iskelmä Rex"
        site: "http://www.radiorex.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://radio.6net.fi:8000/jarviradio.m3u"
        title: "Järviradio"
        site: "http://www.jarviradio.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://icelive0.80596-icelive0.cdn.qbrick.com/10162/80596_MetroHelsinki.mp3"
        title: "Metro Helsinki"
        site: "http://www.metrohelsinki.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://stream2.sbs.fi/play.mp3"
        title: "Play"
        site: "http://www.playradio.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://media2.innoventum.fi:8000/radiocityjoensuu.m3u"
        title: "Radio City Joensuu"
        site: "http://www.radiorex.fi/radio-city-joensuu/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://213.186.227.18:8000/eazy.mp3.m3u"
        title: "Radio Eazy 101"
        site: "http://www.eazy101.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://radio.radiohelsinki.fi/rh256"
        title: "Radio Helsinki"
        site: "http://www.radiohelsinki.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://icelive0.43660-icelive0.cdn.qbrick.com/9883/43660_RadioJyvaskyla.mp3"
        title: "Radio Jyväskylä"
        site: "http://www.radiojyvaskyla.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://radio.6net.fi:8000/radiokajaus.m3u"
        title: "Radio Kajaus"
        site: "http://www.radiokajaus.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://153.1.15.26:8080/moreeni.mp3"
        title: "Radio Moreeni"
        site: "http://moreeni.uta.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://suomiradio.pro:8040/rh256"
        title: "Radio Musa"
        site: "http://www.radiomusa.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://icelive0.43660-icelive0.cdn.qbrick.com/4918/43660_radio_pooki.mp3"
        title: "Radio Pooki"
        site: "http://www.radiopooki.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://213.186.227.18:8000/radiopori.mp3.m3u"
        title: "Radio Pori"
        site: "http://www.radiopori.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://radioaktiivinen.lappia.fi:8000/play.mp3.m3u"
        title: "Radio Pro"
        site: "http://www.radiopro.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://213.141.104.154:8000/stream/1/"
        title: "Radio Ramona"
        site: "http://www.radioramona.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://suomiradio.pro:8080/rh256/"
        title: "Radio Sandels"
        site: "http://www.radiosandels.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://st.downtime.fi/sun.mp3.m3u"
        title: "Radio SUN"
        site: "http://www.radiosun.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://stream.anviawebcasting.com:8000/radiovaasa.m3u"
        title: "Radio Vaasa"
        site: "http://www.radiovaasa.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://st.downtime.fi/sunclassics.mp3.m3u"
        title: "SUN Classics"
        site: "http://www.sunclassics.fi/"
        section: "Paikalliset"
    }
    ListElement {
        source: "http://adwzg4.tdf-cdn.com/9199/nrj_112804.mp3"
        title: "NRJ Suomihitit"
        site: "http://www.nrj.fi/"
        section: "NRJ-kanavat"
    }
    ListElement {
        source: "http://adwzg4.tdf-cdn.com/8773/nrj_178606.mp3 	"
        title: "NRJ UK Top 40"
        site: "http://www.nrj.fi/"
        section: "NRJ-kanavat"
    }
    ListElement {
        source: "http://adwzg3.tdf-cdn.com/8497/nrj_164590.mp3"
        title: "NRJ Dance"
        site: "http://www.nrj.fi/"
        section: "NRJ-kanavat"
    }
    ListElement {
        source: "http://adwzg3.tdf-cdn.com/8622/nrj_164052.mp3"
        title: "NRJ Fitness"
        site: "http://www.nrj.fi/"
        section: "NRJ-kanavat"
    }
    ListElement {
        source: "http://adwzg3.tdf-cdn.com/8559/nrj_175788.mp3"
        title: "NRJ Ibiza"
        site: "http://www.nrj.fi/"
        section: "NRJ-kanavat"
    }
    ListElement {
        source: "http://adwzg3.tdf-cdn.com/8595/nrj_165941.mp3"
        title: "NRJ Latino"
        site: "http://www.nrj.fi/"
        section: "NRJ-kanavat"
    }
    ListElement {
        source: "http://adwzg3.tdf-cdn.com/8503/nrj_175068.mp3"
        title: "NRJ Lounge"
        site: "http://www.nrj.fi/"
        section: "NRJ-kanavat"
    }
    ListElement {
        source: "http://adwzg3.tdf-cdn.com/8615/nrj_169454.mp3"
        title: "NRJ Love"
        site: "http://www.nrj.fi/"
        section: "NRJ-kanavat"
    }
    ListElement {
        source: "http://adwzg3.tdf-cdn.com/8542/nrj_169073.mp3"
        title: "NRJ Extravadance"
        site: "http://www.nrj.fi/"
        section: "NRJ-kanavat"
    }
    ListElement {
        source: "http://adwzg3.tdf-cdn.com/8578/nrj_168019.mp3"
        title: "NRJ Rap US"
        site: "http://www.nrj.fi/"
        section: "NRJ-kanavat"
    }
    ListElement {
        source: "http://adwzg3.tdf-cdn.com/8485/nrj_169683.mp3"
        title: "NRJ RnB"
        site: "http://www.nrj.fi/"
        section: "NRJ-kanavat"
    }
    ListElement {
        source: "http://adwzg3.tdf-cdn.com/8527/nrj_177497.mp3"
        title: "NRJ Rock"
        site: "http://www.nrj.fi/"
        section: "NRJ-kanavat"
    }
    ListElement {
        source: "http://adwzg3.tdf-cdn.com/8530/nrj_165311.mp3"
        title: "NRJ Running"
        site: "http://www.nrj.fi/"
        section: "NRJ-kanavat"
    }
    ListElement {
        source: "http://s3.radioboss.fm:8301/live.m3u"
        title: "MyStation"
        site: "http://www.mystation.fi/"
        section: "Tilapäiset"
    }
    ListElement {
        source: "http://suomiradio.pro:8000/hr256"
        title: "Pispalan Radio 995"
        site: "http://www.pispalanradio.fi/"
        section: "Tilapäiset"
    }
    ListElement {
        source: "http://stream.klf.fi:8000/stream.m3u"
        title: "Radio KLF"
        site: "http://www.klf.fi/"
        section: "Tilapäiset"
    }
    ListElement {
        source: "http://46.163.245.15:8000/radio.m3u"
        title: "Radio Patmos"
        site: "http://www.patmos.fi/"
        section: "Tilapäiset"
    }
    ListElement {
        source: "http://streaming.shoutcast.com/RadioRapu"
        title: "Radio Rapu"
        site: "http://www.radiorapu.com/"
        section: "Tilapäiset"
    }
    ListElement {
        source: "http://stream.iradio.fi:8000/klasu-med.mp3"
        title: "Klasu"
        site: "http://www.rondoclassic.fi/klasu"
        section: "Rondo Classic"
    }
    ListElement {
        source: "http://stream.iradio.fi:8000/klasupro-med.mp3"
        title: "Klasu Pro"
        site: "http://www.rondoclassic.fi/klasu-pro"
        section: "Rondo Classic"
    }
    ListElement {
        source: "http://stream.iradio.fi:8000/viva-lo.mp3"
        title: "Viva Classica"
        site: "http://www.rondoclassic.fi/radio/viva"
        section: "Rondo Classic"
    }
}
