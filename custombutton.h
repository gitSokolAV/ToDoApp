#ifndef CUSTOMBUTTON_H
#define CUSTOMBUTTON_H

#include <QObject>

class CustomButton : public QObject
{
    Q_OBJECT
public:
    explicit CustomButton(QObject *parent = nullptr);
public slots:
    void buttonClicked();
};

#endif
