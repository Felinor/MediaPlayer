QT += quick multimedia widgets

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

LIBS += -ltag

SOURCES += \
        main.cpp \
        mediamodel.cpp

RESOURCES += \
    ControlPanel.qml \
    CustomSlider.qml \
    DelegateItem.qml \
    HeaderDelegate.qml \
    LeftPanel.qml \
    RowDelegate.qml \
    SongLabel.qml \
    album-cover.jpg \
    music_note.png \
    sound.png \
    imagine-assets/imagine-assets.qrc \
    icons/icons.qrc \
    qtquickcontrols2.conf \
    main.qml

TRANSLATIONS += \
    MediaPlayer_ru_RU.ts
CONFIG += lrelease
CONFIG += embed_translations

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    mediamodel.h    

DISTFILES += \
    album-cover.jpg \
    music_note.png
