TEMPLATE = app
TARGET = qml-handwriting
CONFIG += qt
QT += quick
SOURCES += handwriting.cpp


unix {
    CONFIG += link_pkgconfig
    PKGCONFIG += zinnia
}