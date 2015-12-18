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

TEMPLATE = aux

#CONFIG += sailfishapp

#SOURCES += src/harbour-nettiradio.cpp

qml.files = qml/*

qml.path = /usr/share/harbour-nettiradio/qml

desktop.files = harbour-nettiradio.desktop
desktop.path = /usr/share/applications

OTHER_FILES += \
    qml/* \
    qml/Pages/* \
    qml/Pages/StationLists/* \
    qml/Pages/StationLists/Asemat.xml \
    harbour-nettiradio.desktop \
    rpm/harbour-nettiradio.spec \
    rpm/harbour-nettiradio.changes

# to disable building translations every time, comment out the
# following CONFIG line
#CONFIG += sailfishapp_i18n

appicons.path = /usr/share/icons/hicolor/
appicons.files = appicons/*

INSTALLS += appicons qml desktop

DISTFILES += \
    qml/Pages/StationLists/Asemat.xml \
    qml/Pages/StationLists/StationsModel.qml \
    qml/Pages/StationLists/xml/asemat.xml \
    qml/Pages/Menu.qml \
    qml/Pages/functions.js
