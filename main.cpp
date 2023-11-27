#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include <backend.h>
#include <custombutton.h>
#include <tictactoegame.h>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/Bubble/main.qml"_qs);
    BackEnd bck;
    CustomButton customButton;
    TicTacToeGame tttg;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.rootContext()->setContextProperty("bck", &bck);
    engine.rootContext()-> setContextProperty("customButton", &customButton);
    engine.rootContext()-> setContextProperty("TicTacToeGame", &tttg);
    qmlRegisterType<BackEnd>("BackEnd", 1,0,"BackEnd");
    qmlRegisterType<CustomButton>("CustomButton", 1, 0, "CustomButton");
    qmlRegisterType<TicTacToeGame>("TicTacToeGame", 1, 0, "TicTacToeGame");
    engine.load(url);

    return app.exec();
}
