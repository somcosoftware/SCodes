cmake_minimum_required(VERSION 3.16)

project(SCodes LANGUAGES CXX C)

option(SCODES_DEBUG OFF)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt5 Qt6)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Multimedia Concurrent Quick REQUIRED)

set(COMMON_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/SBarcodeDecoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/SBarcodeFormat.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/SBarcodeGenerator.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/BarcodeFormat.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/BinaryBitmap.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/BitArray.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/BitMatrix.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/BitMatrixIO.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/BitSource.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/CharacterSet.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ConcentricFinder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Content.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/DecodeHints.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ECI.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/GTIN.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/GenericGF.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/GenericGFPoly.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/GlobalHistogramBinarizer.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/GridSampler.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/HRI.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/HybridBinarizer.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/MultiFormatReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/MultiFormatWriter.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/PerspectiveTransform.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ReadBarcode.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ReedSolomonDecoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ReedSolomonEncoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Result.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ResultPoint.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/TextDecoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/TextEncoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/TextUtfEncoding.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Utf.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/WhiteRectDetector.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ZXBigInteger.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZDecoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZDetector.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZEncoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZHighLevelEncoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZToken.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZWriter.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMBitLayout.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMDataBlock.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMDecoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMDetector.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMECEncoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMHighLevelEncoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMSymbolInfo.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMVersion.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMWriter.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/libzueci/zueci.c
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/maxicode/MCBitMatrixParser.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/maxicode/MCDecoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/maxicode/MCReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCodabarReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCodabarWriter.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCode128Patterns.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCode128Reader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCode128Writer.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCode39Reader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCode39Writer.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCode93Reader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCode93Writer.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODDXFilmEdgeReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODDataBarCommon.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODDataBarExpandedBitDecoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODDataBarExpandedReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODDataBarReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODEAN13Writer.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODEAN8Writer.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODITFReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODITFWriter.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODMultiUPCEANReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODRowReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODUPCAWriter.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODUPCEANCommon.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODUPCEWriter.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODWriterHelper.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFBarcodeValue.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFBoundingBox.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFCodewordDecoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFDecoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFDetectionResult.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFDetectionResultColumn.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFDetector.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFEncoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFHighLevelEncoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFModulusGF.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFModulusPoly.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFScanningDecoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFWriter.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRBitMatrixParser.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRCodecMode.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRDataBlock.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRDecoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRDetector.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QREncoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRErrorCorrectionLevel.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRFormatInformation.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRMaskUtil.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRMatrixUtil.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRVersion.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRWriter.cpp
)

set(COMMON_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/SBarcodeDecoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/SBarcodeFormat.h
    ${CMAKE_CURRENT_SOURCE_DIR}/SBarcodeGenerator.h
    ${CMAKE_CURRENT_SOURCE_DIR}/qvideoframeconversionhelper_p.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/BarcodeFormat.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/BinaryBitmap.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/BitArray.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/BitHacks.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/BitMatrix.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/BitMatrixCursor.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/BitMatrixIO.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/BitSource.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ByteArray.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ByteMatrix.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/CharacterSet.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ConcentricFinder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Content.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/CustomData.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/DecodeHints.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/DecoderResult.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/DetectorResult.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ECI.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Error.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Flags.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/GTIN.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Generator.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/GenericGF.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/GenericGFPoly.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/GlobalHistogramBinarizer.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/GridSampler.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/HRI.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/HybridBinarizer.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ImageView.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/LogMatrix.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Matrix.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/MultiFormatReader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/MultiFormatWriter.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Pattern.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/PerspectiveTransform.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Point.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Quadrilateral.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Range.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ReadBarcode.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Reader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ReaderOptions.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ReedSolomonDecoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ReedSolomonEncoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/RegressionLine.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Result.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ResultPoint.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Scope.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/StructuredAppend.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/TextDecoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/TextEncoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/TextUtfEncoding.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ThresholdBinarizer.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/TritMatrix.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/Utf.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/WhiteRectDetector.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ZXAlgorithms.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ZXBigInteger.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ZXConfig.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ZXNullable.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/ZXTestSupport.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZDecoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZDetector.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZDetectorResult.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZEncoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZEncodingState.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZHighLevelEncoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZReader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZToken.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/aztec/AZWriter.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMBitLayout.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMDataBlock.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMDecoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMDetector.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMECEncoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMEncoderContext.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMHighLevelEncoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMReader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMSymbolInfo.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMSymbolShape.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMVersion.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/datamatrix/DMWriter.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/libzueci/zueci.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/libzueci/zueci_big5.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/libzueci/zueci_common.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/libzueci/zueci_gb18030.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/libzueci/zueci_gb2312.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/libzueci/zueci_gbk.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/libzueci/zueci_ksx1001.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/libzueci/zueci_sb.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/libzueci/zueci_sjis.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/maxicode/MCBitMatrixParser.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/maxicode/MCDecoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/maxicode/MCReader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCodabarReader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCodabarWriter.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCode128Patterns.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCode128Reader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCode128Writer.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCode39Reader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCode39Writer.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCode93Reader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODCode93Writer.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODDXFilmEdgeReader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODDataBarCommon.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODDataBarExpandedBitDecoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODDataBarExpandedReader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODDataBarReader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODEAN13Writer.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODEAN8Writer.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODITFReader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODITFWriter.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODMultiUPCEANReader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODReader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODRowReader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODUPCAWriter.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODUPCEANCommon.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODUPCEWriter.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/oned/ODWriterHelper.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFBarcodeMetadata.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFBarcodeValue.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFBoundingBox.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFCodeword.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFCodewordDecoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFCompaction.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFDecoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFDecoderResultExtra.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFDetectionResult.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFDetectionResultColumn.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFDetector.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFEncoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFHighLevelEncoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFModulusGF.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFModulusPoly.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFReader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFScanningDecoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/pdf417/PDFWriter.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRBitMatrixParser.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRCodecMode.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRDataBlock.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRDataMask.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRDecoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRDetector.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRECB.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QREncodeResult.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QREncoder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRErrorCorrectionLevel.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRFormatInformation.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRMaskUtil.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRMatrixUtil.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRReader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRVersion.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src/qrcode/QRWriter.h
)

if (QT_VERSION_MAJOR EQUAL 6)
    set(SRC_FILES ${COMMON_SOURCES}
        ${CMAKE_CURRENT_SOURCE_DIR}/SBarcodeScanner.cpp
    )
    set(HEADER_FILES ${COMMON_HEADERS}
        ${CMAKE_CURRENT_SOURCE_DIR}/SBarcodeScanner.h
    )
	if(ANDROID)
        find_package(Qt6 COMPONENTS GuiPrivate REQUIRED)
    endif()
endif()

if (QT_VERSION_MAJOR EQUAL 5)
    set(SRC_FILES ${COMMON_SOURCES}
        ${CMAKE_CURRENT_SOURCE_DIR}/SBarcodeFilter.cpp
    )
    set(HEADER_FILES ${COMMON_HEADERS}
        ${CMAKE_CURRENT_SOURCE_DIR}/SBarcodeFilter.h
    )
    
    if(ANDROID)
        find_package(Qt5 COMPONENTS AndroidExtras REQUIRED)
    endif()
endif()


add_library(${PROJECT_NAME} STATIC ${HEADER_FILES} ${SRC_FILES})
target_sources(${PROJECT_NAME} PRIVATE private/debug.h)
set_target_properties(${PROJECT_NAME} PROPERTIES
    QT_QML_MODULE_VERSION 1.0
    QT_QML_MODULE_URI com.somcosoftware.scodes

)
if(SCODES_DEBUG)
    message("${PROJECT_NAME} debug messages enabled: ${SS_SCODES_DEBUG}")
    target_compile_definitions(${PROJECT_NAME} PUBLIC SCODES_DEBUG)
endif()


target_link_libraries(${PROJECT_NAME} PUBLIC
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Multimedia
    Qt${QT_VERSION_MAJOR}::Concurrent
    Qt${QT_VERSION_MAJOR}::Quick
)
target_include_directories(${PROJECT_NAME} 
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/zxing-cpp/core/src
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/private
)

if (ANDROID)
    if(QT_VERSION_MAJOR EQUAL 5)
        target_link_libraries(${PROJECT_NAME} PUBLIC Qt5::AndroidExtras)
    else()
        target_link_libraries(${PROJECT_NAME} PUBLIC Qt::GuiPrivate)
    endif()

endif()
