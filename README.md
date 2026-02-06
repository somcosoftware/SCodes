![SCodes ](/assets/SCodes.png)
# SCodes

This project is Qt & Qml wrapper for [ZXing-C++ Library](https://github.com/nu-book/zxing-cpp) that is used for decoding and generating 1D and 2D barcodes. This particular C++ ZXing port is one of the most recent C++ versions of popular ZXing library using modern compilers.

Thanks to SCodes you can start scanning barcodes in few steps. We used Qt 5.15.2 and Qt 6.3.0 to built wrapper and example applications, but it's compatible with older Qt versions as well.

Implementation of same method for both Qt version does not seems possible([check why](#porting)). We have ported the SCodes wrapper to Qt6 by following the multimedia [changes](https://doc-snapshots.qt.io/qt6-6.3/qtmultimedia-changes-qt6.html).

---

[![Somco Software](./assets/Group%201.png)](https://somcosoftware.com)

[![Built with Qt](./assets/buildWithQt.png)](https://qt.io)

---

## Supported Formats

There are plenty of supported formats and we constantly work on adding new.

## Supported 1D Formats

|      Format      |    Supports scanning     |    Supports generating
| ---------------- | ------------------------ |    -------------------
|      UPC-A       |   <center>✔️</center>    |   <center>✔️</center>
|      UPC-E       |   <center>✔️</center>    |   <center>✔️</center>
|      EAN-8       |   <center>✔️</center>    |   <center>✔️</center>
|      EAN-13      |   <center>✔️</center>    |   <center>✔️</center>
|     DataBar      |   <center>✔️</center>    |   <center>❌</center>
| DataBar Expanded |   <center>❌</center>    |   <center>❌</center>
|     Code 39      |   <center>✔️</center>    |   <center>✔️</center>
|     Code 93      |   <center>✔️</center>    |   <center>✔️</center>
|     Code 128     |   <center>✔️</center>    |   <center>✔️</center>
|     Codabar      |   <center>✔️</center>    |   <center>✔️</center>
|       ITF        |   <center>❌</center>    |   <center>✔️</center>

## Supported 2D Formats

|    Format    |    Supports scanning     |    Supports generating
| ------------ | ------------------------ |    -------------------
|   QR Code    |   <center>✔️</center>    |   <center>✔️</center>
|  DataMatrix  |   <center>✔️</center>    |   <center>✔️</center>
|    Aztec     |   <center>✔️</center>    |   <center>✔️</center>
|    PDF417    |   <center>✔️</center>    |   <center>✔️</center>
|   MaxiCode   |   <center>❌</center>    |   <center>❌</center>


# How to use wrapper?
![SCodes Scanner Preview](/assets/scanner.gif)![SCodes Generator Preview](/assets/generator.gif)

## Using 

Feel free to read ["How to scan barcodes in Qt Qml application" blog post](https://somcosoftware.com/en/blog/how-to-scan-barcodes-in-qt-qml-application) if you are interested in the details behind scanning mechanism. Also you can try out the QmlReaderExample in order to see how it is working.

SCodes supports generating barcodes as well. It is covered in ["How to generate barcode in Qt Qml" application blog post](https://somcosoftware.com/en/blog/how-to-generate-barcode-in-qt-qml-application).  Also you can try out the QmlGeneratorExample in order to see how it is working.

Above blog posts contains step by step tutorial on how to do that for Qt5 version. For Qt6 ([see here](#porting)).

### qmake
All you need to do is to follow these steps.

1. Add SCodes as submodule, by typing `git submodule add git@github.com:scytheStudio/SCodes.git`
2. Update submodule `git submodule update --recursive --init` (you can also put wrapper files to your project manually without adding submodule)
3. Add `include(scodes/src/SCodes.pri)` to your .pro file
4. If you want to use barcode reader functionality you need to register `SBarcodeFilter` class for Qt5 or `SBarcodeScanner` class for Qt6. For both version, separate them with if directive to register as we did in barcode reader example([how to register reader class](#register-reader)). As for barcode generator functionality you just need to register `SBarcodeGenerator` class([how to register generator class](#register-generator)).
5. Import SCodes in your Qml file `import com.scythestudio.scodes 1.0`
6. Import multimedia module `import QtMultimedia 5.15` for Qt5 or `import QtMultimedia` for Qt6.
7. If build fails, try to add `CONFIG += c++17` to your .pro file
8. You are done. Get inspired by [Qt5 QML Barcode Reader demo](https://github.com/scytheStudio/SCodes/blob/master/examples/QmlBarcodeReader/qml/Qt5ScannerPage.qml) or [Qt6 QML Barcode Reader demo](https://github.com/scytheStudio/SCodes/blob/master/examples/QmlBarcodeReader/qml/Qt6ScannerPage.qml) to test wrapper.

### CMake

1. Add SCodes as submodule, by typing `git submodule add git@gitlab.com:scythestudio/scodes.git`
2. Update submodule `git submodule update --recursive --init` (you can also put wrapper files to your project manually without adding submodule)
3. Add to your project SCodes library

    ```CMake
        add_subdirectory(SCodes)
    ```

4. Link SCodes library to your library or executable. 

    ```CMake 
        target_link_libraries(${PROJECT_NAME} PUBLIC SCodes)
    ```

5. Import SCodes in your Qml file 

    ```qml
        import com.scythestudio.scodes 1.0
    ```

6. You are done. Get inspired by [QML Barcode Reader demo](https://github.com/scytheStudio/SCodes/blob/master/examples/QmlBarcodeReader/qml/ScannerPage.qml) to test wrapper.

<a name="register-reader"></a>
### How to do
Registering the barcode reader classes with if directive:

```c++
    #if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
        qmlRegisterType<SBarcodeFilter>("com.scythestudio.scodes", 1, 0, "SBarcodeScanner");
    #else
        qmlRegisterType<SBarcodeScanner>("com.scythestudio.scodes", 1, 0, "SBarcodeScanner");
    #endif
```
<a name="register-generator"></a>
Registering the barcode generator class with associated enum:
```c++
    qmlRegisterType<SBarcodeGenerator>("com.scythestudio.scodes", 1, 0, "SBarcodeGenerator");
    qmlRegisterUncreatableMetaObject(SCodes::staticMetaObject, "com.scythestudio.scodes", 1, 0, "SCodes", "Error: only enums");
```

<a name="porting"></a>
### Implementation details in Qt6

Qt's multimedia library has major changes. The most importants are, changes in QML `VideoOutput`, absence of `QVideoFilterRunnable` and `QAbstractVideoFilter` classes in Qt6.

SCodes library is using `SBarcodeFilter` class for Qt5 and `SBarcodesScanner` class for Qt6 version. 

If you want to read more about implementation details of the library in Qt6 read the document: [Implementation Details in Qt6](https://github.com/scytheStudio/SCodes/blob/master/doc/detailsQt6.md)


### Trying various formats
`SBarcodeFilter` is a class that you need to use for scanning case. By default it scans only specific basic formats of code (Code 39, Code 93, Code 128, QR Code and DataMatrix.).
The goal of that is to limit number of possible formats and improve performance.

To specify formats that should be accepted by the `SBarcodeFilter` instance, you need to set it's `format` property accordingly. This property allows setting multiple enum values as it's for flags. Add the following to your `SBarcodeFilter` item in Qml code:
```qml
Component.onCompleted: {
    barcodeFilter.format = SCodes.OneDCodes
}
```
See the enumeration values that represent supported formats in [SBarcodeFormat.h](https://github.com/scytheStudio/SCodes/blob/master/src/SBarcodeFormat.h)
To accept all supported formats use `SCodes.Any`.

## Note 

Both build systems have their examples located in same directory. All you need to do is to just open proper file(CMakeLists.txt or *.pro file) for different build system to be used.


### The examples tested on below kits:

#### Qt5.15.2 or less,

| PROJECT | BUILD SYSTEM | WINDOWS-MinGW | WINDOWS-MSVC | LINUX-GCC | ANDROID |
| ------ | ------ | ------ | ------ | ------ | ------ |
| QmlBarcodeReader | qmake |<center>✔️</center>|<center>✔️</center>|<center>✔️</center>|<center>✔️</center>|
| QmlBarcodeGenerator | qmake |<center>✔️</center>|<center>✔️</center>|<center>✔️</center>|<center>✔️</center>|
| QmlBarcodeReader | CMake |<center>❌</center>|<center>✔️</center>|<center>✔️</center>|<center>✔️</center>|
| QmlBarcodeGenerator | CMake |<center>❌</center>|<center>✔️</center>|<center>✔️</center>|<center>✔️</center>|

#### Qt6.3.0,

| PROJECT | BUILD SYSTEM | WINDOWS-MinGW | WINDOWS-MSVC | LINUX-GCC | ANDROID |
| ------ | ------ | ------ | ------ | ------ | ------ |
| QmlBarcodeReader | qmake |<center>✔️</center>|<center>✔️</center>|<center>✔️</center>|<center>✔️</center>|
| QmlBarcodeGenerator | qmake |<center>✔️</center>|<center>✔️</center>|<center>✔️</center>|<center>✔️</center>|
| QmlBarcodeReader | CMake |<center>✔️</center>|<center>✔️</center>|<center>✔️</center>|<center>✔️</center>|
| QmlBarcodeGenerator | CMake |<center>✔️</center>|<center>✔️</center>|<center>✔️</center>|<center>✔️</center>|

Please ensure that proper Java & NDK version installed on your system. This examples tested w/ Java 11 and 22.1.7171670 Android NDK version.

## About Somco Software (previously Scythe Studio)
[Somco Software (previously Scythe Studio)](https://somcosoftware.com/en/) is an embedded and cross-platform software development company with a strong focus on Qt and C++, delivering reliable, high-quality solutions for regulated industries, with particular expertise in medical devices. We are an ISO 9001 and ISO 13485 certified software house, specializing in GUI development, Linux-based systems, and advanced connectivity solutions. Somco Software is an official Qt Service Partner and a trusted partner of leading hardware manufacturers.

<table style="margin: 0 auto; border:0;">
    <tr style="border:0">
        <td style="border:0">
            <a href="https://somcosoftware.com/">
                <img src="./assets/Qt-service-partner-badge.png">
            </a>
        </td>
        <td style="border:0">
            <a href="https://clutch.co/profile/scythe-studio">
                <img height="150" width="150"
                    src="https://github.com/user-attachments/assets/023e102e-84c1-4e7e-b9de-cae476e681e7">
            </a>
        </td>
        <td style="border:0">
            <a href="https://somcosoftware.com/en/iso">
                <img src="./assets/iso 13485.png" style="background: #031813;">
            </a>
        </td>
        <td style="border:0">
            <a href="https://somcosoftware.com/en/iso">
                <img src="./assets/iso 9001.png" style="background: #031813;">
            </a>
        </td>
    </tr>
</table>

We support projects from design to delivery, offering UX/UI design, custom Yocto Linux images, and development in Qt as well as LVGL and TouchGFX. We also help with software modernization, training, and technical consulting. With a practical, developer-focused approach, we build efficient, reliable solutions that fit real project needs.

## Professional Support
Need help with anything? We’ve got you covered. Our professional support services are here to assist you with. For more details about support options and pricing, just drop us a line at https://somcosoftware.com/en/contact.

## Follow us
Check out those links if you want to see Somco Software in action and follow the newest trends saying about Qt Qml development.

* 🌐 [Somco Software Website](https://somcosoftware.com/en/)
* ✍️ [Somco Software Blog Website](https://somcosoftware.com/en/blog)
* 👔 [Somco Software LinkedIn Profile](https://www.linkedin.com/company/scythestudio/mycompany/)
* 🎥 [Somco Software Youtube Channel](https://www.youtube.com/channel/UCf4OHosddUYcfmLuGU9e-SQ/featured)
