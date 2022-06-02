#include "mediamodel.h"
#include <QMediaPlaylist>
#include <QMediaPlayer>
#include <QDir>
#include <QFileDialog>
#include <QStandardPaths>
#include <QMediaMetaData>
#include <QMediaObject>


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

    switch (role) {
    case ColorRole:
        return QVariant(index.row() < 2 ? "orange" : "skyblue");
    case TextRole:
        return m_data.at(index.row());
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> MediaModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[ColorRole] = "color";
    roles[TextRole] = "text";

    return roles;
}

void MediaModel::add(QString data)
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

    foreach (QUrl filename, list) {
        QString awesomePath = filename.toString().remove(0, 7);
        m_playlist->addMedia(QMediaContent(QUrl::fromLocalFile(awesomePath)));
        qDebug() << awesomePath;
        add(awesomePath);
    }
    m_player->setPlaylist(m_playlist);
    m_playlist->setCurrentIndex(1);
    m_playlist->setPlaybackMode(QMediaPlaylist::Loop);
    play();

//    auto duration = m_player->metaData(QMediaMetaData::Title).toString();
    //    qDebug() << "Duration" << duration;
}

void MediaModel::setMediaPosition(int position)
{
    m_player->setPosition(position*1000);
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

//         if (metadatalist.at(i) == "ContributingArtist" || "Title")
//             m_name = player->metaData(metadatalist.at(i)).toString();
//             qDebug() << m_name;

        qDebug() << metadata_key << var_data.toString();
       }
}

void MediaModel::metaDataChanged(QMediaPlayer::MediaStatus status)
{
//    qDebug() << "AlbumArtist" << m_player->metaData(QMediaMetaData::AlbumArtist).toString();
//    qDebug() << "Title" << m_player->metaData(QMediaMetaData::Title).toString();
//    qDebug() << "Duration" << m_player->metaData(QMediaMetaData::Duration).toInt();

//    qDebug() << "STATUS" << status;
    if (status == QMediaPlayer::BufferedMedia) {
        getMetaData(m_player);
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
