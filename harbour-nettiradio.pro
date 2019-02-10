# The name of your application
TARGET = harbour-nettiradio


CONFIG += sailfishapp_qml

#SOURCES += src/harbour-nettiradio.cpp

DISTFILES += \
    qml/Pages/StationLists/Asemat.xml \
    qml/Pages/StationLists/StationsModel.qml \
    qml/Pages/StationLists/xml/asemat.xml \
    qml/Pages/About.qml \
    qml/Pages/AlphaMenu.qml \
    qml/Pages/AlpaMenuGroupView.qml \
    qml/Pages/ContactNameGroup.qml \
    qml/Pages/CoverPage.qml \
    qml/Pages/FavDialog.qml \
    qml/Pages/FavManager.qml \
    qml/Pages/Help.qml \
    qml/Pages/MainPage.qml \
    qml/Pages/Menu.qml \
    qml/Pages/PlayerPanel.qml \
    qml/Pages/PulleyMenu.qml \
    qml/Pages/SleepTimerPage.qml \
    qml/Pages/StationGridView.qml \
    qml/Pages/StationListView.qml \
    qml/Pages/functions.js \
    rpm/harbour-nettiradio.changes \
    rpm/harbour-nettiradio.spec \
    rpm/harbour-nettiradio.yaml \
    harbour-nettiradio.desktop
    # translations/harbour-nettiradio-en.ts

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172 #256x256

# to disable building translations every time, comment out the
# following CONFIG line
#CONFIG += sailfishapp_i18n

#TRANSLATIONS += translations/harbour-nettiradio-en.ts
