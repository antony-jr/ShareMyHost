#include <MongooseBackendPrivate.hpp>
#include <mongoose.h>

#include <QCoreApplication>
#include <QThread>
#include <QNetworkInterface>
#include <QList>
#include <QDebug>

#include <errno.h>

static void ev_handler(struct mg_connection *c, int ev, void *p) {
  if (ev == MG_EV_HTTP_REQUEST) {
    struct http_message *hm = (struct http_message *) p;

    if(c->user_data != NULL){
	    MongooseBackendPrivate *p = (MongooseBackendPrivate*)c->user_data;
    }

    // We have received an HTTP request. Parsed request is contained in `hm`.
    // Send HTTP reply to the client which shows full original request.
    mg_send_head(c, 200, hm->message.len, "Content-Type: text/plain");
    mg_printf(c, "%.*s", (int)hm->message.len, hm->message.p);
  }
}

MongooseBackendPrivate::MongooseBackendPrivate(QObject *parent) :
    QObject(parent),
    b_StopRequested(false),
    b_Running(false)
{
}

MongooseBackendPrivate::~MongooseBackendPrivate(){
	if(b_Running)
		stopServer();
}

void MongooseBackendPrivate::toggleServer(){
	if(b_Running){
		stopServer();
		return;
	}
	startServer();
}

void MongooseBackendPrivate::startServer(){
	struct mg_mgr mgr;
	if(b_Running){
		emit serverStarted(m_Address);
		return;
	}

	// Get local ip address
	QList<QHostAddress> list = QNetworkInterface::allAddresses();
	for(int nIter=0; nIter<list.count(); nIter++)
	{
		if(!list[nIter].isLoopback())
			if (list[nIter].protocol() == QAbstractSocket::IPv4Protocol )
				m_Address = list[nIter].toString();
	}

	if(m_Address.isEmpty()){
		emit error(QString::fromUtf8("Cannot determine local IP"));
		return;
	}

	// For now lets only support binding on port 8080
	// if that fails then we complain to user and 
	// thats it.
	QString address = m_Address + ":8080";
	QByteArray inByteArray = address.toLatin1();
	const char *http_ip = inByteArray.constData();

	mg_mgr_init(&mgr, NULL);
	struct mg_connection *c = NULL;
	c = mg_bind(&mgr, http_ip, ev_handler);
	if(c == NULL){
		mg_mgr_free(&mgr);
		char *error_str = strerror(errno);
		emit error(QString::fromUtf8(error_str));
		return;
	}
	c->user_data = (void*)this;
	mg_set_protocol_http_websocket(c);
	
	m_Address = address;
	b_Running = true;
	emit serverStarted(m_Address);
	
	for(;;){
		mg_mgr_poll(&mgr, 1000);
		QCoreApplication::processEvents();
		if(b_StopRequested){
			b_StopRequested = b_Running = false;
			break;
		}
	}

	emit serverStopped();
	mg_mgr_free(&mgr);
}

void MongooseBackendPrivate::stopServer(){
	b_StopRequested = true;
}
