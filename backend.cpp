#include "backend.h"
BackEnd::BackEnd(QObject *parent) :
    QObject(parent)
{

}
QString BackEnd::getTime()
{
    return this -> timeFromInt;
}
void BackEnd::setTime(const QString& newTime)
{
    QTime* currentTime = new QTime(0,0,0);
    *currentTime = currentTime->addSecs(newTime.toInt());
    timeFromInt = currentTime->toString("hh:mm:ss");
    emit timeChanged();
}

