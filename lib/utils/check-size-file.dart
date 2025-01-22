import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:starlightserviceapp/models/app/file/resize-file-model.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';

class MyFile {
  resizeFile(BuildContext context, XFile file) async {
    String base64 = "";
    String typefile = "";
    double fullsize = 4.00;
    final step1 = getSizeFileMB(await file.readAsBytes());
    if (step1 <= fullsize) {
      base64 = base64Encode(await file.readAsBytes());
      typefile = lookupMimeType(file.path) ?? "";
    } else {
      CroppedFile? croppedFile = await cropImage(context, file);
      if (croppedFile != null) {
        final step2 = getSizeFileMB(await croppedFile.readAsBytes());
        if (step2 <= fullsize) {
          base64 = base64Encode(await croppedFile.readAsBytes());
          typefile = lookupMimeType(croppedFile.path) ?? "";
        } else {
          final compressed = await compressFile(croppedFile);
          base64 = base64Encode(compressed);
          typefile = lookupMimeType(croppedFile.path) ?? "";
        }
      }
    }
    return ResizeFileModel(base64, typefile);
  }

  getSizeFileKB(Uint8List bytedata) {
    final bytes = bytedata.lengthInBytes;
    final kb = bytes / 1024;
    return kb;
  }

  getSizeFileMB(Uint8List bytedata) {
    final bytes = bytedata.lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    return double.parse(mb.toStringAsFixed(2));
  }

  cropImage(BuildContext context, XFile photo) async {
    return await ImageCropper().cropImage(
      sourcePath: photo.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: MyColors().primary(),
          toolbarWidgetColor: Colors.white,
          hideBottomControls: true,
          aspectRatioPresets: [
            // CropAspectRatioPreset.original,
            // CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPresetCustom(), // IMPORTANT: iOS supports only one custom aspect ratio in preset list
          ],
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
  }

  compressFile(CroppedFile file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.path,
      minWidth: 500,
      minHeight: 1200,
      quality: 95,
    );
    return result;
  }

  bool isImageFile(String filename) {
    List<String> imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    String extension = filename.split('.').last.toLowerCase();

    return imageExtensions.contains(extension);
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
