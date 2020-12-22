/*
  Copyright (C) 2015-2016 jollailija
  Contact: jollailija <jollailija@gmail.com>
  Copyright (C) 2019 Matti Viljanen
  Contact: Matti Viljanen <matti.viljanen@kapsi.fi>
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
import QtQuick.LocalStorage 2.0
import "storage.js" as Storage
import "functions.js" as TheFunctions // :)

Page {
    SilicaListView {
        anchors.fill: parent
        id: favListView
        property bool isEdited

        Timer {
            id: autoSaveTimer
            interval: 3000
            running: favListView.isEdited
            onTriggered: {
                console.log("Autosave")
                TheFunctions.overwriteFavs(favModel)
                qmlListModel.clear()
                stationsModel.reload()
                listFiller.start()
                TheFunctions.refreshList(favModel)
                favListView.isEdited = false
            }
        }

        header: PageHeader { title: qsTr("Hallitse suosikkeja") }
        VerticalScrollDecorator {}
        PullDownMenu {
            MenuItem {
                text: qsTr("Tallenna muutokset")
                onClicked: {
                    TheFunctions.overwriteFavs(favModel)
                    qmlListModel.clear()
                    stationsModel.reload()
                    listFiller.start()
                    TheFunctions.refreshList(favModel)
                    favListView.isEdited = false
                }
            }
            MenuItem {
                text: qsTr("Lisää asema")
                onClicked: pageStack.push(Qt.resolvedUrl("FavDialog.qml"))
            }
        }
        ViewPlaceholder {
            enabled: favModel.count === 0
            text: qsTr("Ei suosikkeja")
            hintText: qsTr("Valitse vetovalikosta 'Lisää asema' lisätäksesi suosikin")
        }
        model: favModel
        /*section {
            property: 'section'
            delegate: SectionHeader {
                text: section
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeMedium * lib.fontSize
                                : Theme.fontSizeSmall * lib.fontSize
            }
        }*/
        delegate: ListItem {
            id: delegate
            width: parent.width
            //height: remove.height

            function showRemorseItem() {
                var idx = index
                remorse.execute(delegate, qsTr("Poistuu"), function() {favModel.remove(idx);favListView.isEdited = true}, 5000)
            }
            RemorseItem {id: remorse}
            Label {
                text: model.title
                font.pixelSize: Screen.sizeCategory > Screen.Medium
                                ? Theme.fontSizeExtraLarge * lib.fontSize
                                : Theme.fontSizeMedium * lib.fontSize
                color: Theme.primaryColor
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.paddingLarge
            }
            menu: ContextMenu {
                MenuItem {
                    text: qsTr("Muokkaa")
                    onClicked: {
                        var dialog = pageStack.push(Qt.resolvedUrl("FavDialog.qml"),
                                                    {
                                                        "title": model.title,
                                                        "source": model.source,
                                                        "site":model.site,
                                                        "updateMode":true
                                                    })
                    }
                }
                MenuItem {
                    text: qsTr("Poista")
                    onClicked: { favModel.remove(model.index) }
                }
            }
            IconButton {
                id: moveUp
                anchors {
                    right: moveDown.left
                }
                icon.source: "image://theme/icon-m-up"
                onClicked: {
                    TheFunctions.moveListItem(favModel, model.index, (model.index-1))
                    favListView.isEdited = true
                }
                enabled: model.index > 0
            }
            IconButton {
                id: moveDown
                anchors {
                    right: parent.right
                    rightMargin: Theme.paddingLarge
                }
                icon.source: "image://theme/icon-m-down"
                onClicked: {
                    TheFunctions.moveListItem(favModel, model.index, (model.index+1))
                    favListView.isEdited = true
                }
                enabled: model.index < favModel.count-1
            }
        }
        Component.onCompleted: TheFunctions.refreshList(favModel)
    }
}
