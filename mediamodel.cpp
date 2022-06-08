#include "mediamodel.h"
#include <QMediaPlaylist>
#include <QMediaPlayer>
#include <QDir>
#include <QFileDialog>
#include <QStandardPaths>
#include <QMediaMetaData>
#include <QMediaObject>
#include <QBuffer>


MediaModel::MediaModel(QObject *parent) : QAbstractListModel(parent)
{
//    m_data.append("Demon Hunter Collapsing");
//    m_data.append("P.O.D. Boom");
//    m_data.append("Green Day Holidays");
//    m_data.append("Jeremy Soul Dragonborne");
//    m_data.append("Jeremy Soul Awake");
//    m_data.append("Demon Hunter Death Flowers");

//    connect(m_player, QOverload<>::of(&QMediaPlayer::metaDataChanged),
//            this, &MediaModel::metaDataChanged);

    connect(m_player, &QMediaPlayer::mediaStatusChanged,
            this, &MediaModel::metaDataChanged);

    connect(m_player, &QMediaPlayer::positionChanged,
            this, [=]{ setPosition(m_player->position()/1000); });

    connect(m_player, &QMediaPlayer::durationChanged,
            this, [=]{ setDuration(m_player->duration()/1000); });

    connect(m_player, &QMediaPlayer::durationChanged,
            this, [&](qint64 dur) { qDebug() << "duration = " << dur; });
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

    return roles;
}

void MediaModel::add(QVariantMap data)
{
    beginInsertRows(QModelIndex(), m_data.size(), m_data.size());
    m_data.append(data);
    endInsertRows();

//    m_data[0] = QString("Size: %1").arg(m_data.size());
    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
    emit dataChanged(index, index);
}

void MediaModel::play()
{            
    m_player->play();
    emit playerStateChanged(m_player->state());
    qDebug() << m_player->position()/1000 << "<==========";
}

void MediaModel::pause()
{
    m_player->pause();
    emit playerStateChanged(m_player->state());
}

void MediaModel::stop()
{
    m_player->stop();
    emit playerStateChanged(m_player->state());
}

void MediaModel::next()
{
    m_playlist->next();
}

void MediaModel::previous()
{
    m_playlist->previous();
}

void MediaModel::random()
{
    m_playlist->setPlaybackMode(QMediaPlaylist::Random);
}

void MediaModel::currentItemInLoop()
{
    m_playlist->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
}

void MediaModel::createPlaylist(QVariant playlist)
{
    QList<QUrl> list = qvariant_cast<QList<QUrl>>(playlist);     

    foreach (const QUrl filename, list) {
        m_playlist->addMedia(filename);

        QString mediaName = QFileInfo(filename.path()).fileName(); //baseName()

        QVariantMap map;
        map.insert("artist", mediaName);
        map.insert("title", "");
        add(map);
    }

    m_player->setPlaylist(m_playlist);
    m_playlist->setPlaybackMode(QMediaPlaylist::Loop);
//    play();
}

void MediaModel::setMediaPosition(int position)
{
    m_player->setPosition(position*1000);
}

void MediaModel::setCurrentMedia(const int index)
{
    m_playlist->setCurrentIndex(index);
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
        qDebug() << "AlbumArtist:" << m_player->metaData(QMediaMetaData::ContributingArtist).toString();
        qDebug() << "Title:" << m_player->metaData(QMediaMetaData::Title).toString();
        qDebug() << "Duration:" << m_player->metaData(QMediaMetaData::Duration).toInt();
        qDebug() << "CoverArtImage:" << m_player->metaData(QMediaMetaData::CoverArtImage);
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
