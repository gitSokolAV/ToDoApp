#ifndef CUSTOMBUTTON_H
#define CUSTOMBUTTON_H

#include <QObject>
#include <QString>
#include <QColor>

class CustomButton : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(int width READ width WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ height WRITE setHeight NOTIFY heightChanged)
    Q_PROPERTY(bool visible READ visible WRITE setVisible NOTIFY visibleChanged)
    Q_PROPERTY(QString horizontalAnchor READ horizontalAnchor WRITE setHorizontalAnchor NOTIFY horizontalAnchorChanged)
    Q_PROPERTY(QString verticalAnchor READ verticalAnchor WRITE setVerticalAnchor NOTIFY verticalAnchorChanged)
public:
    explicit CustomButton(QObject *parent = nullptr);

    QString text()const;
    void setText(const QString &text);

    QColor color() const;
    void setColor(const QColor &color);

    int width() const;
    void setWidth(int width);

    int height() const;
    void setHeight(int height);

    bool visible() const;
    void setVisible(bool visible);

    QString horizontalAnchor() const;
    void setHorizontalAnchor(const QString &anchor);

    QString verticalAnchor() const;
    void setVerticalAnchor(const QString &anchor);

public slots:
    void buttonClicked();
signals:
    void textChanged();
    void colorChanged();
    void widthChanged();
    void heightChanged();
    void visibleChanged();
    void horizontalAnchorChanged();
    void verticalAnchorChanged();
private:
    QString m_text;
    QColor m_color;
    int m_width;
    int m_height;
    bool m_visible;
    QString m_horizontalAnchor;
    QString m_verticalAnchor;
};

#endif
