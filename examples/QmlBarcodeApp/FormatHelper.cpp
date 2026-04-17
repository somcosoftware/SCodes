#include "FormatHelper.h"

#include "SBarcodeFormat.h"

using namespace SCodes;

FormatHelper::FormatHelper(QObject *parent)
    : QObject(parent)
{
}

QVariantList FormatHelper::supportedFormats() const
{
    static const std::vector<SBarcodeFormat> formats = {
        SBarcodeFormat::QRCode,
        SBarcodeFormat::Aztec,
        SBarcodeFormat::Codabar,
        SBarcodeFormat::Code39,
        SBarcodeFormat::Code93,
        SBarcodeFormat::Code128,
        SBarcodeFormat::DataMatrix,
        SBarcodeFormat::EAN8,
        SBarcodeFormat::EAN13,
        SBarcodeFormat::ITF,
        SBarcodeFormat::PDF417,
        SBarcodeFormat::UPCA,
        SBarcodeFormat::UPCE,
        // add any new ones here in the future
    };

    QVariantList list;
    for (auto fmt : formats) {
        QVariantMap item;
        item["text"]  = SCodes::toString(fmt);
        item["value"] = QVariant::fromValue(fmt);
        list.append(item);
    }
    return list;
}
