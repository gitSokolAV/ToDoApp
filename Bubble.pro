QT += quick core

SOURCES += \
        backend.cpp \
        gameboard.cpp \
        main.cpp

resources.files = main.qml AddCategoryBtn.qml ToDoList.qml Category.qml audio/sound.wav audio/sound2.wav FocusClock.qml Tiles.qml Tile.qml GameBoard.qml
resources.prefix = /$${TARGET}
RESOURCES += resources


# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    Category.qml \
    FocusClock.qml \
    GameBoard.qml \
    Tile.qml \
    Tiles.qml \
    ToDoList.qml

HEADERS += \
    backend.h \
    gameboard.h
