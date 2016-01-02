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
import Sailfish.Silica 1.0

Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        VerticalScrollDecorator {}
        Column {
            id: column
            spacing: Theme.paddingLarge
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            PageHeader { title: qsTr("Uniajastimen asetus") }
            Label {
                text: ((lib.sleepTime > 0) ? (qsTr("Jäljellä oleva aika: ") + lib.sleepTime + qsTr(". Vaihda aika")) : qsTr("Valitse aika"))
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeLarge * lib.fontSize
                                : Theme.fontSizeMedium * lib.fontSize
            }
            Slider {
                id: timerSlider
                value: 60
                minimumValue: 1
                maximumValue: 120
                stepSize: 1
                width: parent.width
                handleVisible: true
                valueText: value
                label: qsTr("minuuttia")
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: Theme.paddingLarge
                Button {
                    text: qsTr("Aseta")
                    onPressed: lib.sleepTime = timerSlider.value
                }
                Button {
                    text: qsTr("Pysäytä")
                    onPressed: lib.sleepTime = -1
                }
            }
            /*TextSwitch {
                text: qsTr("Sulje sovellus uniajastimen päätyttyä")
                description: qsTr("Kun uniajastin on kulunut loppuun, sovellus sulkee itsensä.")
                checked: lib.closeAppAfterSleepTime
                onCheckedChanged: lib.closeAppAfterSleepTime ? lib.closeAppAfterSleepTime=false : lib.closeAppAfterSleepTime=true
            }*/
        }
    }
}
