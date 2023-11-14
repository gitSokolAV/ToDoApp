#include "custombutton.h"
#include <QDebug>

CustomButton::CustomButton(QObject *parent) : QObject(parent)
{

}
void CustomButton::buttonClicked()
{
    qDebug() << "Btn click in C++ code";
}
