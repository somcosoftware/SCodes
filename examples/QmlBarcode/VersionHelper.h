#pragma once

#include <QObject>
#include <QtGlobal>

class VersionHelper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isQt6 READ isQt6 CONSTANT)

public:
    explicit VersionHelper(QObject *parent = nullptr) : QObject(parent) {}

    inline bool isQt6() const {
#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
        return true;
#else
        return false;
#endif
    }
};
