INCLUDEPATH += . include
TEMPLATE = app
CONFIG += release static
TARGET = ShareMyHost
QT += core network gui widgets qml quickcontrols2

DEFINES += QT_DEPRECATED_WARNINGS

HEADERS += include/mongoose.h \
           include/MongooseBackend.hpp \
	   include/MongooseBackendPrivate.hpp \
	   include/Helpers.hpp \
	   include/Clipper.hpp 
	   
SOURCES += src/main.cc \
           src/mongoose.c \
	   src/MongooseBackend.cc \
	   src/MongooseBackendPrivate.cc \
	   src/Helpers.cc \
	   src/Clipper.cc

RESOURCES += qml/qml.qrc
