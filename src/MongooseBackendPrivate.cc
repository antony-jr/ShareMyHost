#include <MongooseBackendPrivate.hpp>
#include <mongoose.h>

#include <QCoreApplication>
#include <QThread>
#include <QNetworkInterface>
#include <QList>
#include <QPair>
#include <QDebug>
#include <QFile>
#include <QJsonDocument>


#include <errno.h>
#include <assert.h>

static void ev_handler(struct mg_connection *c, int ev, void *p) {
  if (ev == MG_EV_HTTP_REQUEST) {
    struct http_message *hm = (struct http_message *) p;
    char *uri = (char*)calloc(hm->uri.len + 1, sizeof *uri);
    MongooseBackendPrivate *obj = qobject_cast<MongooseBackendPrivate*>((QObject*)c->user_data);
    if(!uri || !obj){
	    // send internal server error in case
	    // we have some trouble allocating space or 
	    // the user data is not our backend object
	    mg_http_send_error(c, 500, NULL);
	    return;
    }
    strncpy(uri, hm->uri.p, hm->uri.len);

    struct mg_serve_http_opts opts;
    memset(&opts, 0, sizeof(opts));  // Reset all options to defaults
   

    // Set original uri length to zero for default behaviour of
    // http serve
    c->orig_uri =  NULL;
    
    // Now go through the mount points and 
    // redirect.
    QStringList mountPoints = (obj->m_MountPoints).keys();
    bool mountPointServed = false;
    for(QString mountPoint : mountPoints){
	    QByteArray bArray = mountPoint.toLatin1();
	    const char *mnt = bArray.constData();
	    auto len = bArray.size();

	    if(!qstrncmp(uri , mnt, len)){
	   // Now we want to change the uri in the http message
	   // avoiding the mount point name because its 
	   // just a pesudo
		  
	   // Before we override the original uri we need to 
	   // store it in the connection struct for later use.
            
           // We also need to avoid this step for KODI HTTP clients.
           // Kodi seems to avoid listing of stuff which have absolute links.
           // Don't know why, so we have to check if the user agent is Kodi,
           // if so then we avoid making a absolute link.
           // Obviously, this will not work when Kodi is not sending user-agents 
           // but I've never seen a request from Kodi without a user-agent so
           // it's our best bet.
	   // Side Note: 
	   // 	if c->orig_uri is NULL then the directory listing href simply list the contents
	   // 	without the mount point.
	   // 	(i.e) /Anime/Erased becomes /Erased
	   //
	   // 	This makes it impossible for browsers to go through but strangely, Kodi seems to go through
	   // 	only when the link is in the above mentioned format.
           bool isKodi = false;
	   for(int i = 0; i < MG_MAX_HTTP_HEADERS ; ++i){
                 mg_str name = hm->header_names[i];
                 mg_str value = hm->header_values[i];
                 if(name.len == 0){ /* indicates the last header in the list(citation needed). */
                     break;
                 }

		 if(!qstrncmp(name.p , "User-Agent", name.len)){ // Only look for User-Agent
			 if(strstr(value.p, "Kodi")){ // We just need Kodi in the user-agent
				 isKodi = true;
			 }else{
				 break; // We have no business anymore.
			 }
		 }
           }

//	   if(isKodi){
//		   qDebug() << "Kodi client detected, will be avoid using absolute href.";
//	   }

	   if(!isKodi){
           c->orig_uri  = (char *)calloc(hm->uri.len + 1, sizeof(char));
		   if(!c->orig_uri){
			   mg_http_send_error(c, 500, NULL);
			   free(uri);
			   return;
		   }
		   strncpy(c->orig_uri, hm->uri.p, hm->uri.len);
	   }
		   if(hm->uri.len ==  len){ // No files directly requested 
			memset(&hm->uri.p + 1 , 0, hm->uri.len - 1);
			hm->uri.len = 1;
		   }else if(hm->uri.len > len){
			char *past_mnt_point = (char*)
				calloc(hm->uri.len - len + 1, sizeof(char));
			if(!past_mnt_point){
				mg_http_send_error(c, 500, NULL);
				free(c->orig_uri);
				free(uri);
				c->orig_uri = NULL;
				return;
			}
			strncpy(past_mnt_point, hm->uri.p + len, hm->uri.len - len);
			char *p = past_mnt_point;
			for(int iter = 0; iter < hm->uri.len ; ++iter){
				if(iter > hm->uri.len - len){
					*(((char*)hm->uri.p) + iter) = '\0';
					continue;
				}
				*(((char*)hm->uri.p) + iter) = *p++;
			}
			hm->uri.len = strlen(past_mnt_point);
			free(past_mnt_point);
		   }

		   QString localFile = (obj->m_MountPoints).value(mountPoint).toString();
		   
		   QByteArray localFileByteArray = localFile.toLatin1();
		   char *root = (char*)calloc(localFileByteArray.size() + 1, sizeof *root);
		   strncpy(root, localFileByteArray.constData(), localFileByteArray.size());
		   
		   opts.document_root = root;

//		   qDebug() << "Serving Mount Point: " << root;
		   mg_serve_http(c, hm , opts);
		   mountPointServed = true;
		   if(c->orig_uri){
			   free(c->orig_uri);
			   c->orig_uri = NULL;
		   }
		   free(root);
		   break;
	    }

    }

    free(uri);
    if(!mountPointServed){
	    QFile file;
	    file.setFileName(":/index_a.html");
	    if(!file.open(QIODevice::ReadOnly)){
		    mg_http_send_error(c, 500, NULL);	
		    return;
	    }
	   
	    mg_printf(c, "HTTP/1.1 200 OK\r\n\r\n");

	    while(!file.atEnd()){
		    QByteArray data = file.read(1024);
		    mg_printf(c, "%.*s", data.size(), data.constData());
	    }
	    file.close();

	    for(QString mountPoint : mountPoints){
		    mg_printf(c,
		    "<button type=\"button\" class=\"list-group-item\""
		    " onclick=\"window.location.href = '%s';\" >%s</button>",
		    mountPoint.toStdString().c_str(),
		    mountPoint.toStdString().c_str());
	    }
	    
	    file.setFileName(":/index_b.html");
	    if(!file.open(QIODevice::ReadOnly)){
		    mg_http_send_error(c, 500, NULL);	
		    return;
	    }
	    
	    while(!file.atEnd()){
		    QByteArray data = file.read(1024);
		    mg_printf(c, "%.*s", data.size(), data.constData());
	    }
	    file.close();
	    c->flags |= MG_F_SEND_AND_CLOSE;
    }
  }
}

MongooseBackendPrivate::MongooseBackendPrivate(QObject *parent) :
    QObject(parent),
    b_StopRequested(false),
    b_Running(false)
{
	// Get all mount points from settings
	// Workaround for https://bugreports.qt.io/browse/QTBUG-48313
	QByteArray json = m_Settings.value("MountPoints").toByteArray();
	if(!json.isEmpty()){
		m_MountPoints = (QJsonDocument::fromJson(json)).object();
	}
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

void MongooseBackendPrivate::addMountPoint(QString mountPoint, QUrl local){
	mountPoint.prepend("/");
	if(!m_MountPoints.contains(mountPoint)){
		m_MountPoints.insert(mountPoint, local.toLocalFile());
		QJsonDocument doc(m_MountPoints);
		m_Settings.setValue("MountPoints", doc.toJson());
		emit mountPointAdded(mountPoint);
	}
}

void MongooseBackendPrivate::removeMountPoint(QString mountPoint){
	if(m_MountPoints.contains(mountPoint)){
		m_MountPoints.remove(mountPoint);
		QJsonDocument doc(m_MountPoints);
		m_Settings.setValue("MountPoints", doc.toJson());
		emit mountPointRemoved(mountPoint);
	}
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
		mg_mgr_poll(&mgr, 200);
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

void MongooseBackendPrivate::getAllMountPoints(){
	QStringList mountPoints = m_MountPoints.keys();
	for(QString mountPoint : mountPoints){
		emit mntPoint(mountPoint);
	}
}
