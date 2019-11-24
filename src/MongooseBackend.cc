#include <MongooseBackend.hpp>
#include <MongooseBackendPrivate.hpp>
#include <Helpers.hpp>


MongooseBackend::MongooseBackend(QObject *parent) :
    QObject(parent),
    m_Private(new MongooseBackendPrivate) {
    m_Private->moveToThread(&m_Thread);
    m_Thread.start();

    connect(m_Private, &MongooseBackendPrivate::serverStarted,
            this, &MongooseBackend::serverStarted);
    connect(m_Private, &MongooseBackendPrivate::serverStopped,
            this, &MongooseBackend::serverStopped);
    connect(m_Private, &MongooseBackendPrivate::error,
            this, &MongooseBackend::error);
    connect(m_Private, &MongooseBackendPrivate::mntPoint,
            this, &MongooseBackend::mountPoint);
    connect(m_Private, &MongooseBackendPrivate::mountPointAdded,
            this, &MongooseBackend::mountPointAdded);
    connect(m_Private, &MongooseBackendPrivate::mountPointRemoved,
            this, &MongooseBackend::mountPointRemoved);
    connect(m_Private, &MongooseBackendPrivate::mountPointAddError,
            this, &MongooseBackend::mountPointAddError);

}

MongooseBackend::~MongooseBackend() {
    m_Private->deleteLater();
    m_Thread.quit();
    m_Thread.wait();
}

void MongooseBackend::toggleServer() {
    getMethod(m_Private, "toggleServer(void)").invoke(m_Private, Qt::QueuedConnection);
}

void MongooseBackend::addMountPoint(QString mountPoint, QUrl loc) {
    getMethod(m_Private, "addMountPoint(QString,QUrl)")
    .invoke(m_Private, Qt::QueuedConnection, Q_ARG(QString, mountPoint),
            Q_ARG(QUrl, loc));
}

void MongooseBackend::removeMountPoint(QString mountPoint) {
    getMethod(m_Private, "removeMountPoint(QString)")
    .invoke(m_Private, Qt::QueuedConnection, Q_ARG(QString, mountPoint));
}

void MongooseBackend::getAllMountPoints() {
    getMethod(m_Private, "getAllMountPoints(void)").invoke(m_Private, Qt::QueuedConnection);
}
