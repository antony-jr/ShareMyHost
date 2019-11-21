#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QIcon>

#include <MongooseBackend.hpp>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QGuiApplication::setOrganizationName("ShareMyHost");
    QGuiApplication::setApplicationName("ShareMyHost");

    qmlRegisterType<MongooseBackend>("Core.MongooseBackend", 1, 0, "MongooseBackend");

    app.setWindowIcon(QIcon(QString::fromUtf8(":/logo.png")));    
    QQuickStyle::setStyle("Material"); // Use Google Material Design
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
