#ifndef MEDIAMODEL_H
#define MEDIAMODEL_H

#include <QAbstractListModel>
#include <QStringList>
#include <qqml.h>
#include <QMediaPlaylist>
#include <QMediaPlayer>

class MediaModel : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

public:
    MediaModel(QObject *parent = 0);

    enum Roles {
        ColorRole = Qt::UserRole + 1,
        TextRole
    };

    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE void add(QString data);
    Q_INVOKABLE void play();
    Q_INVOKABLE void pause();
    Q_INVOKABLE int position();
    Q_INVOKABLE int duration();
    Q_INVOKABLE void stop();
    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();
    Q_INVOKABLE void random();
    Q_INVOKABLE void currentItemInLoop();
    Q_INVOKABLE void createPlaylist(QVariant playlist);
    void getMetaData(QMediaPlayer *player);

public slots:
    void metaDataChanged(QMediaPlayer::MediaStatus status);

private:
    QStringList m_data;
    QMediaPlaylist *m_playlist = new QMediaPlaylist;
    QMediaPlayer *m_player = new QMediaPlayer(this);
};

#endif // MEDIAMODEL_H
