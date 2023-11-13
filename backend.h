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
struct str_complex
{
private:
    double re, im, arg, mod;
public:

    str_complex(double a_re, double a_im)
    {
        re = a_re, im = a_im;
        mod = sqrt(re*re + im*im);
        arg = atan2(im, re);
    }
    double get_re(){return re;}
    double get_im(){return im;}
    double modulo(){return mod;}
    double argument(){return arg;}
};

#endif // BACKEND_H
