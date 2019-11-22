#ifndef MONGOOSE_BACKEND_HPP_INCLUDED
#define MONGOOSE_BACKEND_HPP_INCLUDED 
#include <QObject>
#include <QString>
#include <QThread>

class MongooseBackendPrivate;

class MongooseBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(NOTIFY serverStarted NOTIFY serverStopped NOTIFY error)
	    
    QThread m_Thread;
    MongooseBackendPrivate *m_Private;
public:
    explicit MongooseBackend(QObject *parent = nullptr);
    ~MongooseBackend();
    Q_INVOKABLE void toggleServer();
signals:
    void serverStarted(QString serverAddress);
    void serverStopped();
    void error(QString errorMessage);
};

#endif
