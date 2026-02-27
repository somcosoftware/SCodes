#pragma once

#include <QObject>
#include <QColor>

class ColorController : public QObject
{
    Q_OBJECT
public:
    explicit ColorController(QObject *parent = nullptr);
    Q_INVOKABLE static QColor convertStringToColor(const QString &color);

    Q_INVOKABLE bool checkColor(const QString &color);

    Q_INVOKABLE QColor constractColor(const QColor& color);
};
