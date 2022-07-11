#ifndef MEDIAMODEL_H
#define MEDIAMODEL_H

#include <QAbstractListModel>
#include <QMediaPlaylist>
#include <QMediaPlayer>
#include <QRadioTuner>
#include <taglib/fileref.h>

class MediaModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int duration READ duration WRITE setDuration NOTIFY durationChanged)
    Q_PROPERTY(int position READ position WRITE setPosition NOTIFY positionChanged)
    Q_PROPERTY(int currentMediaIndex READ currentMediaIndex WRITE setCurrentMediaIndex NOTIFY currentMediaIndexChanged)
    Q_PROPERTY(QMediaPlayer::State mediaPlayerState READ mediaPlayerState WRITE setMediaPlayerState NOTIFY mediaPlayerStateChanged)
    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged)

public:
    MediaModel(QObject *parent = 0);

    enum Roles {
        Album = Qt::UserRole,
        Artist = Qt::UserRole + 2,
        CoverImage = Qt::UserRole + 3,
        Time = Qt::UserRole + 4,
        Title = Qt::UserRole + 5
    };

    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    void add(QVariantMap &data);
    Q_INVOKABLE void play();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void stop();
    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();
    Q_INVOKABLE void random();
    Q_INVOKABLE void loopCurrentItem();
    Q_INVOKABLE void createPlaylist(QVariant playlist);
    Q_INVOKABLE void setMediaPosition(int position);
    Q_INVOKABLE void setCurrentMedia(const int index);
    Q_INVOKABLE void applyVolume(int volumeSliderValue);
    Q_INVOKABLE void setMedia(QString url);
    Q_INVOKABLE void playRadio(float freq);
    Q_INVOKABLE void searchForward();
    Q_INVOKABLE void searchBackward();
    void getMetaData(QMediaPlayer *player);
    QUrl getSourceImage(QImage image);

    int duration() const;
    void setDuration(int newDuration);

    int position() const;
    void setPosition(int newPosition);

    int currentMediaIndex() const;
    void setCurrentMediaIndex(int newCurrentMediaIndex);

    QMediaPlayer::State mediaPlayerState() const;
    void setMediaPlayerState(QMediaPlayer::State newMediaPlayerState);

    int volume() const;
    void setVolume(int newVolume);

public slots:
    void metaDataChanged(QMediaPlayer::MediaStatus status);
    void freqChanged(int newFrequency);

signals:
    void durationChanged();
    void positionChanged();
    void currentMediaIndexChanged();
    void mediaPlayerStateChanged();

    void volumeChanged();

private:
    QVariantMap getMetadata(TagLib::FileRef &reference);

private:
    QVariantList m_data;
    QMediaPlaylist *m_playlist = new QMediaPlaylist(this);
    QMediaPlayer *m_player = new QMediaPlayer(this);
    int m_duration = 0;
    int m_position = 0;

    QString testString;
    int m_currentMediaIndex;
    QMediaPlayer::State m_mediaPlayerState;
    int m_volume = 100;

    QRadioTuner *m_radio = new QRadioTuner(this);
    float m_radioStationFrequency = 105.7;
};

#endif // MEDIAMODEL_H
