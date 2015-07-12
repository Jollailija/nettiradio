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
    qml/About.qml \
    qml/Help.qml \
    qml/harbour-nettiradio.png

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
