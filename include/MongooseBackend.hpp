#ifndef MONGOOSE_BACKEND_HPP_INCLUDED
#define MONGOOSE_BACKEND_HPP_INCLUDED 
#include <QObject>
#include <QString>
#include <QThread>

#include <QString>
#include <QUrl>

class MongooseBackendPrivate;

class MongooseBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(NOTIFY serverStarted
	       NOTIFY serverStopped 
	       NOTIFY error
	       NOTIFY mountPointAddError
	       NOTIFY mountPoint
	       NOTIFY mountPointAdded
	       NOTIFY mountPointRemoved)
	    
    QThread m_Thread;
    MongooseBackendPrivate *m_Private;
public:
    explicit MongooseBackend(QObject *parent = nullptr);
    ~MongooseBackend();
    Q_INVOKABLE void toggleServer();
    Q_INVOKABLE void addMountPoint(QString, QUrl);
    Q_INVOKABLE void removeMountPoint(QString);
    Q_INVOKABLE void getAllMountPoints();

signals:
    void serverStarted(QString serverAddress);
    void serverStopped();
    void error(QString errorMessage);
    void mountPointAddError();
    void mountPoint(QString mountPoint);
    void mountPointAdded(QString mountPoint);
    void mountPointRemoved(QString mountPoint);
};

#endif
