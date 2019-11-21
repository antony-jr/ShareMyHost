#ifndef MONGOOSE_BACKEND_HPP_INCLUDED
#define MONGOOSE_BACKEND_HPP_INCLUDED 
#include <QObject>
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
    Q_INVOKABLE void startServer();
    Q_INVOKABLE void stopServer();
signals:
    void serverStarted();
    void serverStopped();
    void error();
};

#endif
