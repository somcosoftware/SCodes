#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "ColorController.h"
#include "VersionHelper.h"

#include "SBarcodeGenerator.h"
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
#include "SBarcodeFilter.h"
#else
#include "SBarcodeScanner.h"
#endif

int main(int argc, char* argv[])
{
    QCoreApplication::setAttribute(Qt::AA_UseDesktopOpenGL);

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#else
    qputenv("QT_QUICK_CONTROLS_STYLE", QByteArray("Basic"));
#endif

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    qmlRegisterType<SBarcodeFilter>("com.somcosoftware.scodes", 1, 0, "SBarcodeScanner");
#else
    qmlRegisterType<SBarcodeScanner>("com.somcosoftware.scodes", 1, 0, "SBarcodeScanner");
#endif

    qmlRegisterType<SBarcodeGenerator>("com.somcosoftware.scodes", 1, 0, "SBarcodeGenerator");
    ColorController colorController;
    qmlRegisterSingletonInstance<ColorController>("com.somcosoftware.scodes", 1, 0, "ColorController", &colorController);
    VersionHelper versionHelper;
    qmlRegisterSingletonInstance<VersionHelper>("com.somcosoftware.scodes", 1, 0, "VersionHelper", &versionHelper);

    qmlRegisterUncreatableMetaObject(
        SCodes::staticMetaObject, "com.somcosoftware.scodes", 1, 0, "SCodes", "Error, enum type");

    qmlRegisterSingletonType(QUrl("qrc:/qml/Theme.qml"), "Theme", 1, 0, "Theme");

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
