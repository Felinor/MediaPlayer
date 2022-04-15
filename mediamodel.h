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

    Q_INVOKABLE void add();
    Q_INVOKABLE void start();
    Q_INVOKABLE void createPlaylist(QVariant playlist);

private:
    QStringList m_data;
    QMediaPlaylist *m_playlist = new QMediaPlaylist;
    QMediaPlayer *m_player = new QMediaPlayer(this);
};

#endif // MEDIAMODEL_H
