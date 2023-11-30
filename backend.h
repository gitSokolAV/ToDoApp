#ifndef BACKEND_H
#define BACKEND_H
#include <QObject>
#include <QString>
#include <QTime>
#include <qqml.h>


class BackEnd : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString timeFromInt READ getTime WRITE setTime NOTIFY timeChanged)    
    QML_ELEMENT

 public:
    explicit BackEnd(QObject *parent = nullptr);
    QString getTime();
    void setTime(const QString& newTime);
    QString intToTimeString(int timeInSecs);

signals:
    void timeChanged();

private:
    QString timeFromInt;
};


#endif // BACKEND_H
