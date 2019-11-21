#include <MongooseBackendPrivate.hpp>
#include <mongoose.h>

#include <QCoreApplication>
#include <QThread>

static const char *s_http_port = "8080";

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
    b_StopRequested(false)
{
}

MongooseBackendPrivate::~MongooseBackendPrivate(){
}

void MongooseBackendPrivate::startServer(){
	struct mg_mgr mgr;
	mg_mgr_init(&mgr, NULL);
	struct mg_connection *c = NULL;
	c = mg_bind(&mgr, s_http_port, ev_handler);
	if(c == NULL){
		perror("Some error");
		emit error();
		return;
	}
	c->user_data = (void*)this;
	mg_set_protocol_http_websocket(c);
	emit serverStarted();

	for(;;){
		mg_mgr_poll(&mgr, 1000);
		QCoreApplication::processEvents();
		if(b_StopRequested){
			b_StopRequested = false;
			break;
		}
	}

	emit serverStopped();
	mg_mgr_free(&mgr);
}

void MongooseBackendPrivate::stopServer(){
	b_StopRequested = true;
}
