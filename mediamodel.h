#ifndef MEDIAMODEL_H
#define MEDIAMODEL_H

#include <QAbstractListModel>
#include <QStringList>
#include <qqml.h>

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

private:
    QStringList m_data;
};

#endif // MEDIAMODEL_H
