cmake_minimum_required(VERSION 3.16)
project(QmlBarcode LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt5 Qt6)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Multimedia Concurrent Quick REQUIRED)


set(BUILD_GMOCK OFF)
add_subdirectory(3rdParty/googletest)
add_subdirectory(src)
add_subdirectory(examples/QmlBarcodeReader)
add_subdirectory(examples/QmlBarcodeGenerator)
add_subdirectory(tests)
