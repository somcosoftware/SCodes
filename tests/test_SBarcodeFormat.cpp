#include <gtest/gtest.h>

#include <QString>

#include "SBarcodeFormat.h"

using namespace SCodes;

/* ============================================================
 * Single enum → ZXing enum
 * ============================================================ */

TEST(SBarcodeFormatTest, ToZXingFormat_SingleEnum)
{
    EXPECT_EQ(toZXingFormat(SBarcodeFormat::None),
              ZXing::BarcodeFormat::None);

    EXPECT_EQ(toZXingFormat(SBarcodeFormat::QRCode),
              ZXing::BarcodeFormat::QRCode);

    EXPECT_EQ(toZXingFormat(SBarcodeFormat::Code128),
              ZXing::BarcodeFormat::Code128);

    EXPECT_EQ(toZXingFormat(SBarcodeFormat::DXFilmEdge),
              ZXing::BarcodeFormat::DXFilmEdge);
}

/* ============================================================
 * toString()
 * ============================================================ */

TEST(SBarcodeFormatTest, ToString_UsesZXingCanonicalNames)
{
    EXPECT_EQ(toString(SBarcodeFormat::QRCode),
              QStringLiteral("QRCode"));

    EXPECT_EQ(toString(SBarcodeFormat::EAN13),
              QStringLiteral("EAN-13"));

    EXPECT_EQ(toString(SBarcodeFormat::UPCA),
              QStringLiteral("UPC-A"));

    EXPECT_EQ(toString(SBarcodeFormat::MicroQRCode),
              QStringLiteral("MicroQRCode"));
}

/* ============================================================
 * fromString()
 * ============================================================ */

TEST(SBarcodeFormatTest, FromString_IsCaseInsensitive)
{
    EXPECT_EQ(fromString(QStringLiteral("qrcode")),
              SBarcodeFormat::QRCode);

    EXPECT_EQ(fromString(QStringLiteral("QrCoDe")),
              SBarcodeFormat::QRCode);
}

TEST(SBarcodeFormatTest, FromString_IgnoresDashesUnderscores)
{
    EXPECT_EQ(fromString(QStringLiteral("EAN13")),
              SBarcodeFormat::EAN13);

    EXPECT_EQ(fromString(QStringLiteral("EAN-13")),
              SBarcodeFormat::EAN13);

    EXPECT_EQ(fromString(QStringLiteral("EAN_13")),
              SBarcodeFormat::EAN13);

    EXPECT_EQ(fromString(QStringLiteral("Code[128]")),
              SBarcodeFormat::Code128);
}

TEST(SBarcodeFormatTest, FromString_UnknownReturnsNone)
{
    EXPECT_EQ(fromString(QStringLiteral("TotallyInvalid")),
              SBarcodeFormat::None);

    EXPECT_EQ(fromString(QString()),
              SBarcodeFormat::None);
}

/* ============================================================
 * Round-trip consistency
 * ============================================================ */

TEST(SBarcodeFormatTest, ToStringFromString_RoundTrip)
{
    const SBarcodeFormat values[] = {
        SBarcodeFormat::Aztec,
        SBarcodeFormat::Code39,
        SBarcodeFormat::Code93,
        SBarcodeFormat::Code128,
        SBarcodeFormat::DataMatrix,
        SBarcodeFormat::QRCode,
        SBarcodeFormat::PDF417,
        SBarcodeFormat::MicroQRCode,
        SBarcodeFormat::RMQRCode,
    };

    for (auto v : values) {
        EXPECT_EQ(fromString(toString(v)), v);
    }
}

/* ============================================================
 * Composite ZXing formats are intentionally NOT mapped
 * ============================================================ */

TEST(SBarcodeFormatTest, FromString_DoesNotMapCompositeZXingFormats)
{
    EXPECT_EQ(fromString(QStringLiteral("Linear-Codes")),
              SBarcodeFormat::None);

    EXPECT_EQ(fromString(QStringLiteral("Matrix-Codes")),
              SBarcodeFormat::None);

    EXPECT_EQ(fromString(QStringLiteral("Any")),
              SBarcodeFormat::None);
}

/* ============================================================
 * Flags → ZXing::BarcodeFormats
 * ============================================================ */

TEST(SBarcodeFormatTest, ToZXingFormat_FlagsSingle)
{
    const auto zxing =
        toZXingFormat(SBarcodeFormats{SBarcodeFormat::QRCode});

    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::QRCode));
    EXPECT_FALSE(zxing.testFlag(ZXing::BarcodeFormat::EAN13));
}

TEST(SBarcodeFormatTest, ToZXingFormat_MultipleFlags)
{
    const SBarcodeFormats formats =
        SBarcodeFormat::QRCode |
        SBarcodeFormat::EAN13 |
        SBarcodeFormat::Code128;

    const auto zxing = toZXingFormat(formats);

    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::QRCode));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::EAN13));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::Code128));
    EXPECT_FALSE(zxing.testFlag(ZXing::BarcodeFormat::PDF417));
}

/* ============================================================
 * Predefined SCodes groups
 * ============================================================ */

TEST(SBarcodeFormatTest, OneDCodes_GroupContainsOnlyLinearFormats)
{
    const auto zxing =
        toZXingFormat(SBarcodeFormats{SBarcodeFormat::OneDCodes});

    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::Codabar));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::Code39));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::Code93));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::Code128));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::EAN8));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::EAN13));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::ITF));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::UPCA));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::UPCE));

    EXPECT_FALSE(zxing.testFlag(ZXing::BarcodeFormat::QRCode));
    EXPECT_FALSE(zxing.testFlag(ZXing::BarcodeFormat::DataMatrix));
}

TEST(SBarcodeFormatTest, TwoDCodes_GroupContainsOnlyMatrixFormats)
{
    const auto zxing =
        toZXingFormat(SBarcodeFormats{SBarcodeFormat::TwoDCodes});

    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::Aztec));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::DataMatrix));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::MaxiCode));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::PDF417));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::QRCode));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::MicroQRCode));
    EXPECT_TRUE(zxing.testFlag(ZXing::BarcodeFormat::RMQRCode));

    EXPECT_FALSE(zxing.testFlag(ZXing::BarcodeFormat::Code128));
    EXPECT_FALSE(zxing.testFlag(ZXing::BarcodeFormat::EAN13));
}

/* ============================================================
 * Edge cases
 * ============================================================ */

TEST(SBarcodeFormatTest, EmptyFlagsProduceEmptyZXingFormats)
{
    const auto zxing = toZXingFormat(SBarcodeFormats{});
    EXPECT_TRUE(zxing.empty());
}

TEST(SBarcodeFormatTest, InvalidEnumValueReturnsNone)
{
    const auto invalid =
        static_cast<SBarcodeFormat>(0x7FFFFFFF);

    EXPECT_EQ(toZXingFormat(invalid),
              ZXing::BarcodeFormat::None);
}
