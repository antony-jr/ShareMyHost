#include <MongooseBackend.hpp>
#include <MongooseBackendPrivate.hpp>
#include <Helpers.hpp>


MongooseBackend::MongooseBackend(QObject *parent) :
    QObject(parent),
    m_Private(new MongooseBackendPrivate)	
{
	m_Private->moveToThread(&m_Thread);
	m_Thread.start();

	connect(m_Private, &MongooseBackendPrivate::serverStarted, 
		this, &MongooseBackend::serverStarted);
	connect(m_Private, &MongooseBackendPrivate::serverStopped,
		this, &MongooseBackend::serverStopped);
	connect(m_Private, &MongooseBackendPrivate::error,
		this, &MongooseBackend::error);
}

MongooseBackend::~MongooseBackend(){
	m_Private->stopServer();
	m_Thread.quit();
	m_Thread.wait();
}

void MongooseBackend::startServer(){
	getMethod(m_Private, "startServer(void)").invoke(m_Private, Qt::QueuedConnection);
}

void MongooseBackend::stopServer(){
	getMethod(m_Private, "stopServer(void)").invoke(m_Private, Qt::QueuedConnection);
}
