import 'dart:typed_data';

import 'package:http/http.dart';

class GetFileService {
  Future<Uint8List?> getfile(String url) async {
    try {
      final _url = Uri.parse(url);
      final response = await get(_url);
      Uint8List file = response.bodyBytes;
      return file;
    } catch (e) {
      print("$e");
    }
    return null;
  }

  bool isImageFile(String filename) {
    List<String> imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    String extension = filename.split('.').last.toLowerCase();

    return imageExtensions.contains(extension);
  }
}
