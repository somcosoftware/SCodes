#pragma once

#include <QObject>
#include <qqml.h>

class FormatHelper : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY(QVariantList supportedFormats READ supportedFormats CONSTANT FINAL)

public:
    explicit FormatHelper(QObject *parent = nullptr);

    QVariantList supportedFormats() const;
};
