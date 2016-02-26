# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-nettiradio

CONFIG += sailfishapp

SOURCES += src/harbour-nettiradio.cpp

OTHER_FILES += qml/harbour-nettiradio.qml \
    rpm/harbour-nettiradio.yaml \
    harbour-nettiradio.desktop \
    rpm/harbour-nettiradio.spec \
    rpm/harbour-nettiradio.changes \
    qml/harbour-nettiradio.png \
    qml/Pages/functions.js \
    qml/Pages/storage.js \
    qml/Pages/About.qml \
    qml/Pages/AlphaMenu.qml \
    qml/Pages/AlphaMenuGroupView.qml \
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
    qml/Pages/harbour-nettiradio.png \
    qml/Pages/icon-l-stop.png \
    qml/Pages/icon-copyright.txt

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
