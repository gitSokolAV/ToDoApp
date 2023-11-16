#include "custombutton.h"
#include <QDebug>

CustomButton::CustomButton(QObject *parent) : QObject(parent), m_width(100), m_height(50), m_visible(true)
{
    m_text  = "Test text";
    m_color = QColor(Qt::yellow);
}
QString CustomButton::text() const
{
        return m_text;
}
void CustomButton::setText(const QString &text)
{
        if(m_text != text){
            m_text = text;
            emit textChanged();
        }
}
QColor CustomButton::color() const
{
        return m_color;
}
void CustomButton:: setColor(const QColor &color)
{
        if(m_color != color){
            m_color = color;
            emit colorChanged();
        }
}
int CustomButton::width() const
{
        return m_width;
}
void CustomButton::setWidth(int width)
{
        if(m_width != width){
            m_width = width;
            emit widthChanged();
        }
}
int CustomButton::height() const
{
        return m_height;
}
void CustomButton::setHeight(int height)
{
        if(m_height != height){
            m_height = height;
            emit heightChanged();
        }
}
bool CustomButton::visible() const
{
        return m_visible;
}
void CustomButton::setVisible(bool visible)
{
        if(m_visible != visible){
            m_visible = visible;
            emit visibleChanged();
        }
}
void CustomButton::buttonClicked()
{
    qDebug() << "Btn click in C++ code";
}
