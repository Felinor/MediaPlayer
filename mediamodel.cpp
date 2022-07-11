#include "mediamodel.h"
#include <QFileDialog>
//#include <QStandardPaths>
//#include <QMediaMetaData>
//#include <QMediaObject>
#include <QBuffer>
//#include <QDir>

#include <iostream>
#include <iomanip>

#include <taglib/tag.h>
#include <taglib/tstring.h>
#include <taglib/fileref.h>
#include <taglib/audioproperties.h>
#include <taglib/id3v2tag.h>
#include <taglib/mpegfile.h>

//using namespace TagLib;
using namespace std;

MediaModel::MediaModel(QObject *parent) : QAbstractListModel(parent)
{
//    connect(m_player, QOverload<>::of(&QMediaPlayer::metaDataChanged),
//            this, &MediaModel::metaDataChanged);

    connect(m_player, &QMediaPlayer::mediaStatusChanged,
            this, &MediaModel::metaDataChanged);

    connect(m_player, &QMediaPlayer::stateChanged,
            this, &MediaModel::setMediaPlayerState);

    connect(m_player, &QMediaPlayer::volumeChanged,
            this, &MediaModel::setVolume);

    connect(m_playlist, &QMediaPlaylist::currentIndexChanged,
            this, &MediaModel::setCurrentMediaIndex);

//    connect(m_playlist, &QMediaPlaylist::currentIndexChanged,
//            this, [=]{ setDuration(m_player->duration()); });

//    connect(m_player, &QMediaPlayer::positionChanged,
//            this, [=]{ setPosition(m_player->position()/1000); });

    connect(m_player, &QMediaPlayer::positionChanged,
            this, &MediaModel::setPosition);

//    connect(m_player, &QMediaPlayer::durationChanged,
//            this, [=]{ setDuration(m_player->duration()/1000); });

    connect(m_player, &QMediaPlayer::durationChanged,
            this, &MediaModel::setDuration);

    connect(m_radio, &QRadioTuner::frequencyChanged,
            this, &MediaModel::playRadio);

    connect(m_radio, &QRadioTuner::frequencyChanged,
            this, &MediaModel::freqChanged);

    connect(m_radio, &QRadioTuner::searchingChanged,
            this, [&](bool searching) { qDebug() << "Searching = " << searching; });

    connect(m_player, &QMediaPlayer::durationChanged,
            this, [&](qint64 dur) { qDebug() << "duration changed = " << dur; });

    TagLib::FileRef f("/home/felinor/Музыка/LiSA - Gurenge.mp3");

//    f.tag()->setArtist("LiSA");
//    f.tag()->setTitle("Gurenge");
//    f.tag()->setAlbum("LiVE is Smile Always ～364+JOKER～ at YOKOHAMA ARENA");
//    f.tag()->setYear(2020);
//    f.tag()->setGenre("J-pop");
//    f.save();

//    getMetadata(f);

//    TagLib::MPEG::File file("/home/felinor/Музыка/Demon_Hunter_-_Artificial_Light.mp3");
//    TagLib::ByteVector handle = "TPE2";
//    TagLib::String value = "bar";
//    TagLib::ID3v2::Tag *tag = file.ID3v2Tag(true);
}

int MediaModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) {
        return 0;
    }

    return m_data.size();
}

QVariant MediaModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    int row = index.row();

    const QVariantMap map = m_data.at(row).toMap();

    switch (role) {
    case Artist:
        return map.value("artist");
    case Title:
        return map.value("title");
    case CoverImage:
        return map.value("coverImage");
    case Time:
        return map.value("time");
    case Album:
        return map.value("album");
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> MediaModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[Artist] = "artist";
    roles[Title] = "title";
    roles[CoverImage] = "coverImage";
    roles[Time] = "time";
    roles[Album] = "album";

    return roles;
}

void MediaModel::add(QVariantMap &data)
{
    beginInsertRows(QModelIndex(), m_data.size(), m_data.size());
    m_data.append(data);
    endInsertRows();

    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
    emit dataChanged(index, index);
}

void MediaModel::play()
{            
    m_player->play();
    qDebug() <<  m_playlist->currentMedia().request().url() << "<-- Current Media";
    qDebug() << m_player->position()/1000 << "<-- Current position";
}

void MediaModel::pause()
{
    m_player->pause();
}

void MediaModel::stop()
{
    m_player->stop();
}

void MediaModel::next()
{
    m_playlist->next();
    qDebug() <<  m_playlist->currentMedia().request().url() << "<-- Current Media";
}

void MediaModel::previous()
{
    m_playlist->previous();
    qDebug() <<  m_playlist->currentMedia().request().url() << "<-- Current Media";
}

void MediaModel::random()
{
    m_playlist->setPlaybackMode(QMediaPlaylist::Random);
}

void MediaModel::loopCurrentItem()
{
    m_playlist->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
}

void MediaModel::createPlaylist(QVariant playlist)
{
    QList<QUrl> list = qvariant_cast<QList<QUrl>>(playlist);

    foreach (const QUrl filename, list) {
        m_playlist->addMedia(filename);

//        QString mediaName = QFileInfo(filename.path()).fileName(); //baseName()

        TagLib::FileRef f(filename.path().toStdString().c_str());
        getMetadata(f);

        QVariantMap map;
        map.insert("artist", getMetadata(f).value("artist"));
        map.insert("title", getMetadata(f).value("title"));
        map.insert("time", getMetadata(f).value("length"));
        map.insert("album", getMetadata(f).value("album"));
        add(map);

//        QVariantMap map;
//        map.insert("artist", mediaName);
//        map.insert("title", "");
//        add(map);
    }   

//    testMediaInfoLib();

    m_player->setPlaylist(m_playlist);
    m_playlist->setPlaybackMode(QMediaPlaylist::Loop);
//    play();
}

void MediaModel::setMediaPosition(int position)
{
    m_player->setPosition(position);
}

void MediaModel::setCurrentMedia(const int index)
{
    m_playlist->setCurrentIndex(index);
    qDebug() <<  m_playlist->currentMedia().request().url() << "<-- Current Media";
}

void MediaModel::applyVolume(int volumeSliderValue)
{
    // volumeSliderValue is in the range [0..100]

    qreal linearVolume = QAudio::convertVolume(volumeSliderValue / qreal(100.0),
                                               QAudio::LogarithmicVolumeScale,
                                               QAudio::LinearVolumeScale);

    m_player->setVolume(qRound(linearVolume * 100));

//    m_player->setVolume(volumeSliderValue);
//    qDebug() << volumeSliderValue << "<-- Volume";
    qDebug() << m_player->volume() << "<-- Volume";
}

void MediaModel::setMedia(QString url)
{
     m_player->setMedia(QUrl(url));
     m_player->play();
}

void MediaModel::playRadio(float freq)
{
    if (m_radio->isBandSupported(QRadioTuner::FM)) {
        m_radio->setBand(QRadioTuner::FM);
        m_radio->setFrequency(freq);
        m_radio->setVolume(100);
        m_radio->start();
    }
}

void MediaModel::searchForward()
{
    m_radio->setFrequency(87);
    m_radio->searchForward();
}

void MediaModel::searchBackward()
{
    m_radio->searchBackward();
}

void MediaModel::getMetaData(QMediaPlayer *player)
{
       // Get the list of keys there is metadata available for
       QStringList metadatalist = player->availableMetaData();

       // Define variables to store metadata key and value
       QString metadata_key;
       QVariant var_data;

       for (int i = 0; i < metadatalist.size(); ++i) {
         // Get the key from the list
         metadata_key = metadatalist.at(i);

         // Get the value for the key
         var_data = player->metaData(metadata_key);

//         if (metadata_key == "Title") {
//             metadata.insert("title", var_data.toString());
//             qDebug() << var_data.toString();
//         }

//         else if (metadata_key == "ContributingArtist")
//             metadata.insert("artist", var_data.toString());
//             qDebug() << var_data.toString();

//        qDebug() << metadata_key << var_data.toString();
       }
}

QUrl MediaModel::getSourceImage(QImage image)
{
    QByteArray byteArray;
    QBuffer buffer(&byteArray);
    buffer.open(QIODevice::WriteOnly);
    image.save(&buffer, "png");
    QString base64 = QString::fromUtf8(byteArray.toBase64());
    QUrl imageUrl = QString("data:image/png;base64,") + base64;
    return imageUrl;
}

void MediaModel::metaDataChanged(QMediaPlayer::MediaStatus status)
{   
//    qDebug() << "STATUS" << status;
    if (status == QMediaPlayer::BufferedMedia) {
//        qDebug() << "AlbumArtist:" << m_player->metaData(QMediaMetaData::ContributingArtist).toString();
//        qDebug() << "Title:" << m_player->metaData(QMediaMetaData::Title).toString();
//        qDebug() << "Duration:" << m_player->metaData(QMediaMetaData::Duration).toInt();
//        qDebug() << "CoverArtImage:" << m_player->metaData(QMediaMetaData::CoverArtImage);
//        getMetaData(m_player);

//        QUrl imageUrl;
//        QImage image = m_player->metaData(QMediaMetaData::CoverArtImage).value<QImage>();

//        if (!image.isNull()) {
//            imageUrl = getSourceImage(image);
//        }
//        else imageUrl = "music_note.png";

//        QVariantMap map;
//        map.insert("artist", m_player->metaData(QMediaMetaData::ContributingArtist).toString());
//        map.insert("title", m_player->metaData(QMediaMetaData::Title).toString());
//        map.insert("coverImage", imageUrl);
//        add(map);
    }
}

void MediaModel::freqChanged(int newFrequency)
{
    qDebug() << "new freq -->" << newFrequency;
    if (m_radioStationFrequency == newFrequency)
        return;
    m_radioStationFrequency = newFrequency;
}

QVariantMap MediaModel::getMetadata(TagLib::FileRef &reference)
{
    QVariantMap metadata;

    metadata.insert("title", QVariant::fromValue(TStringToQString(reference.tag()->title())));
    metadata.insert("artist", QVariant::fromValue(TStringToQString(reference.tag()->artist())));
    metadata.insert("album", QVariant::fromValue(TStringToQString(reference.tag()->album())));
    metadata.insert("year", QVariant::fromValue(reference.tag()->year()));
    metadata.insert("comment", QVariant::fromValue(TStringToQString(reference.tag()->comment())));
    metadata.insert("track", QVariant::fromValue(reference.tag()->track()));
    metadata.insert("genre", QVariant::fromValue(TStringToQString(reference.tag()->genre())));

    cout << "-- TAG (basic) --" << endl;
    cout << "title   - \"" << reference.tag()->title()   << "\"" << endl;
    cout << "artist  - \"" << reference.tag()->artist()  << "\"" << endl;
    cout << "album   - \"" << reference.tag()->album()   << "\"" << endl;
    cout << "year    - \"" << reference.tag()->year()    << "\"" << endl;
    cout << "comment - \"" << reference.tag()->comment() << "\"" << endl;
    cout << "track   - \"" << reference.tag()->track()   << "\"" << endl;
    cout << "genre   - \"" << reference.tag()->genre()   << "\"" << endl;

    TagLib::AudioProperties *properties = reference.audioProperties();
    int seconds = properties->length() % 60;
    int minutes = (properties->length() - seconds) / 60;

    metadata.insert("bitrate", QVariant::fromValue(properties->bitrate()));
    metadata.insert("sample rate", QVariant::fromValue(properties->sampleRate()));
    metadata.insert("channels", QVariant::fromValue(properties->channels()));

    QString length = seconds < 10 ? ("0" + QString::number(seconds)) : QString::number(seconds);
    metadata.insert("length", QVariant::fromValue(QString::number(minutes) + ":" + length));

    cout << "-- AUDIO --" << endl;
    cout << "bitrate     - " << properties->bitrate() << endl;
    cout << "sample rate - " << properties->sampleRate() << endl;
    cout << "channels    - " << properties->channels() << endl;
    cout << "length      - " << minutes << ":" << setfill('0') << setw(2) << seconds << endl;

//    qDebug() << metadata;
    return metadata;
}

int MediaModel::duration() const
{
    return m_duration;
}

void MediaModel::setDuration(int newDuration)
{
    if (m_duration == newDuration)
        return;
    m_duration = newDuration;
    emit durationChanged();
}

int MediaModel::position() const
{
    return m_position;
}

void MediaModel::setPosition(int newPosition)
{
    if (m_position == newPosition)
        return;
    m_position = newPosition;
    emit positionChanged();
}

int MediaModel::currentMediaIndex() const
{
    return m_currentMediaIndex;
}

void MediaModel::setCurrentMediaIndex(int newCurrentMediaIndex)
{
    if (m_currentMediaIndex == newCurrentMediaIndex)
        return;
    m_currentMediaIndex = newCurrentMediaIndex;
    emit currentMediaIndexChanged();
}

QMediaPlayer::State MediaModel::mediaPlayerState() const
{
    return m_mediaPlayerState;
}

void MediaModel::setMediaPlayerState(QMediaPlayer::State newMediaPlayerState)
{
    if (m_mediaPlayerState == newMediaPlayerState)
        return;
    m_mediaPlayerState = newMediaPlayerState;
    emit mediaPlayerStateChanged();
}

int MediaModel::volume() const
{
    return m_volume;
}

void MediaModel::setVolume(int newVolume)
{
    if (m_volume == newVolume)
        return;
    m_volume = newVolume;
    emit volumeChanged();
}
