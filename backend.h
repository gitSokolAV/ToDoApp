#ifndef BACKEND_H
#define BACKEND_H
#include <QObject>
#include <QString>
#include <QTime>
#include <qqml.h>
#include <QRandomGenerator>

class BackEnd : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString timeFromInt READ getTime WRITE setTime NOTIFY timeChanged)
    //Q_PROPERTY(int randomInt READ getRandomInt)
    QML_ELEMENT

        public:
                 explicit BackEnd(QObject *parent = nullptr);

    QString getTime();
    int getRandomInt();
    void setTime(const QString& newTime);
    QString intToTimeString(int timeInSecs);

signals:
    void timeChanged();

private:
    QString timeFromInt;
    int randomInt;
};
#endif // BACKEND_H
