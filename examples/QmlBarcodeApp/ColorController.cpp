#include "ColorController.h"

ColorController::ColorController(QObject *parent)
    : QObject{parent}
{}

bool ColorController::checkColor(const QString &color)
{
    return QColor(color).isValid();
}

QColor ColorController::constractColor(const QColor &color)
{
    // Counting the perceptive luminance - human eye favors green color...
    double luminance = (0.299 * color.red() + 0.587 * color.green() + 0.114 * color.blue())/255;

    if (luminance > 0.5)
        return QColorConstants::Black; // bright colors - black font
    else
        return QColorConstants::White; // dark colors - white font
}

QColor ColorController::convertStringToColor(const QString &color)
{
    return QColor(color);
}
