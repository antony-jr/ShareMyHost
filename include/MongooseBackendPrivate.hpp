#ifndef MONGOOSE_BACKEND_PRIVATE_HPP_INCLUDED
#define MONGOOSE_BACKEND_PRIVATE_HPP_INCLUDED 
#include <mongoose.h>
#include <QObject>
#include <QString>
#include <QPair>
#include <QVector>
#include <QUrl>
#include <QSettings>
#include <QJsonObject>

class MongooseBackendPrivate : public QObject
{
    Q_OBJECT
    bool b_StopRequested;
    bool b_Running;
    QString m_Address;
    QSettings m_Settings;
public:
    QJsonObject m_MountPoints; // This must be accessible by mongoose callbacks.

    explicit MongooseBackendPrivate(QObject *parent = nullptr);
    ~MongooseBackendPrivate();

public slots:
    void toggleServer();
    void addMountPoint(QString, QUrl);
    void removeMountPoint(QString);
    void getAllMountPoints();

private slots:
    void startServer();
    void stopServer();
signals:
    void serverStarted(QString);
    void serverStopped();
    void error(QString);
    void mountPointAddError();
    void mntPoint(QString);
    void mountPointAdded(QString);
    void mountPointRemoved(QString);
};

#endif
