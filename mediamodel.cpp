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
    m_player->setPlaylist(m_playlist);
    m_playlist->setCurrentIndex(1);
    m_playlist->setPlaybackMode(QMediaPlaylist::Loop);
    m_player->play();
    //    qDebug() << m_player->metaData(QMediaMetaData::Author) << "<==========";
}

void MediaModel::stop()
{
    m_player->stop();
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
    play();
}

