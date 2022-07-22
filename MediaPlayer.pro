QT += quick multimedia widgets

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

LIBS += -ltag

ICON = appLogo.ico
RC_ICONS = appLogo.ico

SOURCES += \
        main.cpp \
        mediamodel.cpp

RESOURCES += \
    AppWindowButtons.qml \
    radioIcons.qrc \
    ControlPanel.qml \
    CustomButton.qml \
    CustomSlider.qml \
    HeaderDelegateCustom.qml \
    helper.js \
    ItemDelegateCustom.qml \
    LeftPanel.qml \    
    RadioWindow.qml \
    radio.png \
    RowDelegateCustom.qml \    
    SongLabel.qml \
    TableViewQQ1.qml \
    album-cover.jpg \
    logo.qrc \
    music_note.png \
    imagine-assets/imagine-assets.qrc \
    icons/icons.qrc \
    qtquickcontrols2.conf \
    main.qml \
    VolumeSlider.qml

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
    helper.js \
    music_note.png
