#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QIcon>


#define ENABLE_DEV_MODE
#ifdef ENABLE_DEV_MODE
#include <QFileSystemWatcher>
#include <QDebug>
#include <QFileInfo>
#endif

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(QString::fromUtf8(":/logo.png")));    
    QQuickStyle::setStyle("Material"); // Use Google Material Design
    QQmlApplicationEngine engine;
#ifndef ENABLE_DEV_MODE
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
#else
    qDebug() << "Dev Mode Enabled.";
    qDebug() << "Hot reloading is enabled!";
    QString path;
    if(argc == 1){
	    qDebug() << "Assuming ./main.qml as the main qml file";
	    path = QString::fromUtf8("main.qml");
    }else{
	    path = QString(argv[1]);
    }

    QFileSystemWatcher watcher;
    watcher.addPath(path);
    engine.load(QUrl(path)); 

    QObject::connect(&watcher, &QFileSystemWatcher::fileChanged,
    [&](QString p){
    	Q_UNUSED(p);
    	qDebug() << "Reloading app... ";
	QObject *r = engine.rootObjects().first();
	if(r){r->deleteLater();}
	engine.clearComponentCache();
	engine.load(QUrl(path));
    });
#endif
    return app.exec();
}
