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

}
