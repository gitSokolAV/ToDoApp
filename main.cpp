#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include <backend.h>
#include <custombutton.h>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/Bubble/main.qml"_qs);
    BackEnd bck;
    CustomButton customButton;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.rootContext()->setContextProperty("bck", &bck);
    engine.rootContext()-> setContextProperty("customButton", &customButton);
    qmlRegisterType<BackEnd>("BackEnd", 1,0,"BackEnd");    
    qmlRegisterType<CustomButton>("CustomControls", 1, 0, "CustomButton");
    engine.load(url);

    return app.exec();
}
