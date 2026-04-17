project(SCodes_tests LANGUAGES CXX)
enable_testing()

file(GLOB_RECURSE SOURCES *.cpp)
add_executable(${PROJECT_NAME} ${SOURCES})

target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/../3rdParty/googletest
)

target_link_libraries(${PROJECT_NAME} PRIVATE
    SCodes
    GTest::gtest
    GTest::gtest_main
    Qt6::Core
    Qt6::Gui
)
