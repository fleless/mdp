import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageCompressor {
  Future<File> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 30,
      rotate: 0,
    );
    return result;
  }
}
