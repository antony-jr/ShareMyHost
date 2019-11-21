INCLUDEPATH += . include
TEMPLATE = app
CONFIG += release static
CONFIG += NO_GUI # For AppImageUpdaterBridge
TARGET = ShareMyHost
QT += core network gui widgets qml quickcontrols2

DEFINES += QT_DEPRECATED_WARNINGS

HEADERS += include/mongoose.h
SOURCES += src/main.cc src/mongoose.c
RESOURCES += qml/qml.qrc

include(lib/AppImageUpdaterBridge/AppImageUpdaterBridge.pri)
