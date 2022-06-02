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
    Q_PROPERTY(int duration READ duration WRITE setDuration NOTIFY durationChanged)
    Q_PROPERTY(int position READ position WRITE setPosition NOTIFY positionChanged)

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
    Q_INVOKABLE void stop();
    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();
    Q_INVOKABLE void random();
    Q_INVOKABLE void currentItemInLoop();
    Q_INVOKABLE void createPlaylist(QVariant playlist);
    Q_INVOKABLE void setMediaPosition(int position);
    void getMetaData(QMediaPlayer *player);

    int duration() const;
    void setDuration(int newDuration);

    int position() const;
    void setPosition(int newPosition);

public slots:
    void metaDataChanged(QMediaPlayer::MediaStatus status);   

signals:
    void durationChanged();
    void positionChanged();
    void playerStateChanged(QMediaPlayer::State state);

private:
    QStringList m_data;
    QMediaPlaylist *m_playlist = new QMediaPlaylist;
    QMediaPlayer *m_player = new QMediaPlayer(this);
    int m_duration = 0;
    int m_position = 0;
};

#endif // MEDIAMODEL_H
