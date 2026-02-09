#include <gtest/gtest.h>

#include "SBarcodeGenerator.h"
#include "SBarcodeDecoder.h"        // reuse the project's own decoder
#include "SBarcodeFormat.h"

#include <QDir>
#include <QFile>
#include <QImage>
#include <QStandardPaths>

// Helper to decode a generated image using the exact same code the library uses
static QString decodeGeneratedImage(const QString& imagePath)
{
    QImage img(imagePath);
    if (img.isNull())
        return "";

    SBarcodeDecoder decoder;
    ZXing::BarcodeFormats formats = ZXing::BarcodeFormat::Any;

    decoder.process(img, formats);
    return decoder.captured();
}

TEST(SBarcodeGenerator, DefaultsAreSensible)
{
    SBarcodeGenerator gen;
    EXPECT_EQ(gen.format(), SCodes::SBarcodeFormat::Code128);
    EXPECT_EQ(gen.foregroundColor(), QColor("black"));
    EXPECT_EQ(gen.backgroundColor(), QColor("white"));
    EXPECT_EQ(gen.centerImageRatio(), 5);
    EXPECT_TRUE(gen.generatedFilePath().isEmpty()); // or property("filePath")
}

TEST(SBarcodeGenerator, GenerateRejectsEmptyString)
{
    SBarcodeGenerator gen;
    EXPECT_FALSE(gen.generate(""));
}

TEST(SBarcodeGenerator, GenerateCreatesValidQRCode)
{
    SBarcodeGenerator gen;
    gen.setFormat(SCodes::SBarcodeFormat::QRCode);

    const QString input = "https://github.com/somcosoftware/scodes";
    EXPECT_TRUE(gen.generate(input));

    const QString path = gen.generatedFilePath();
    EXPECT_FALSE(path.isEmpty());
    EXPECT_TRUE(QFile::exists(path));

    // Verify it decodes back to the original text
    EXPECT_EQ(decodeGeneratedImage(path), input);

    QFile::remove(path); // cleanup
}

TEST(SBarcodeGenerator, CenterImageOnQRCodeIsSupportedAndStillDecodable)
{
    SBarcodeGenerator gen;
    gen.setFormat(SCodes::SBarcodeFormat::QRCode);
    gen.setCenterImageRatio(4); // smaller logo

    // Create a fake center image
    QImage logo(200, 200, QImage::Format_RGB32);
    logo.fill(Qt::red);
    const QString logoPath = QDir::tempPath() + "/test_logo.png";
    logo.save(logoPath);

    gen.setImagePath(logoPath);

    const QString input = "QR with logo";
    EXPECT_TRUE(gen.generate(input));

    const QString path = gen.generatedFilePath();
    EXPECT_EQ(decodeGeneratedImage(path), input); // still decodable thanks to ECC=8

    QFile::remove(path);
    QFile::remove(logoPath);
}

TEST(SBarcodeGenerator, CenterImageIsIgnoredForNonQR)
{
    SBarcodeGenerator gen;
    gen.setFormat(SCodes::SBarcodeFormat::Code128);

    QImage logo(100, 100, QImage::Format_RGB32);
    logo.fill(Qt::green);
    const QString logoPath = QDir::tempPath() + "/test_logo2.png";
    logo.save(logoPath);
    gen.setImagePath(logoPath);

    const QString input = "1234567890";
    EXPECT_TRUE(gen.generate(input));

    const QString path = gen.generatedFilePath();
    EXPECT_EQ(decodeGeneratedImage(path), input); // still works, logo was ignored

    QFile::remove(path);
    QFile::remove(logoPath);
}

TEST(SBarcodeGenerator, ForegroundAndBackgroundColorsAreApplied)
{
    SBarcodeGenerator gen;
    gen.setFormat(SCodes::SBarcodeFormat::QRCode);
    gen.setForegroundColor(Qt::red);
    gen.setBackgroundColor(Qt::blue);

    EXPECT_TRUE(gen.generate("Color test"));

    QImage img(gen.generatedFilePath());
    ASSERT_FALSE(img.isNull());

    // Margin area should be background
    EXPECT_EQ(img.pixelColor(0, 0), Qt::blue);
    // At least one module should be foreground (QR has many black modules normally)
    bool hasRed = false;
    for (int y = 0; y < img.height() && !hasRed; ++y)
        for (int x = 0; x < img.width(); ++x)
            if (img.pixelColor(x, y) == Qt::red) {
                hasRed = true;
                break;
            }
    EXPECT_TRUE(hasRed);

    QFile::remove(gen.generatedFilePath());
}

TEST(SBarcodeGenerator, SaveImageCopiesToDocuments)
{
    SBarcodeGenerator gen;
    gen.setFormat(SCodes::SBarcodeFormat::QRCode);
    gen.generate("Save test");

    const QString original = gen.generatedFilePath();
    EXPECT_TRUE(gen.saveImage());

    const QString docPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) +
                            "/" + gen.property("fileName").toString() + "." +
                            gen.property("extension").toString();

    EXPECT_TRUE(QFile::exists(docPath));

    // cleanup
    QFile::remove(original);
    QFile::remove(docPath);
}

TEST(SBarcodeGenerator, FormatStringOverloadWorks)
{
    SBarcodeGenerator gen;
    gen.setFormat("QRCode");
    EXPECT_EQ(gen.format(), SCodes::SBarcodeFormat::QRCode);

    gen.setFormat("invalid");
    EXPECT_EQ(gen.format(), SCodes::SBarcodeFormat::QRCode); // unchanged
}
