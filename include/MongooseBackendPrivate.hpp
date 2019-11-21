#ifndef MONGOOSE_BACKEND_PRIVATE_HPP_INCLUDED
#define MONGOOSE_BACKEND_PRIVATE_HPP_INCLUDED 
#include <mongoose.h>
#include <QObject>

class MongooseBackendPrivate : public QObject
{
    Q_OBJECT
    bool b_StopRequested;
public:
    explicit MongooseBackendPrivate(QObject *parent = nullptr);
    ~MongooseBackendPrivate();

public slots:
    void startServer();
    void stopServer();
signals:
    void serverStarted();
    void serverStopped();
    void error();
};

#endif
