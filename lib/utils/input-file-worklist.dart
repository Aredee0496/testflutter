import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/models/app/file/file-model.dart';
import 'package:starlightserviceapp/models/app/file/res-attachment-nodata-model.dart';
import 'package:starlightserviceapp/models/app/file/resize-file-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-attachment-model.dart';
import 'package:starlightserviceapp/models/family/response.dart';
import 'package:starlightserviceapp/services/app/worklist-service.dart';
import 'package:starlightserviceapp/utils/check-size-file.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:path/path.dart' as path;

checkPermissionCamera() async {
  var status = await Permission.camera.status;
  if (status.isGranted) {
    return true;
  } else {
    final result = await Permission.camera.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}

checkPermissionGallery() async {
  bool response = false;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var status = await Permission.photos.status;
    if (status.isGranted) {
      response = true;
    } else {
      final result = await Permission.photos.request();
      if (result.isGranted) {
        response = true;
      }
    }
  } else {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (Platform.isAndroid && androidInfo.version.sdkInt >= 30) {
      var status = await Permission.photos.status;
      if (status.isGranted) {
        response = true;
      } else {
        final result = await Permission.photos.request();
        if (result.isGranted) {
          response = true;
        }
      }
    } else {
      var status = await Permission.storage.status;
      if (status.isGranted) {
        response = true;
      } else {
        final result = await Permission.storage.request();
        if (result.isGranted) {
          response = true;
        }
      }
    }
  }

  return response;
}

saveAttachmentWorklist(
    BuildContext context, String id, String base64, String fileType) async {
  try {
    WorklistService worklistService = WorklistService();
    DialogHelper.showLoading(context);
    final temp = {
      "WorklistID": id,
      "fileType": fileType,
      "AttatchmentTypeCode": 2,
      "AttatchmentType": "Driver",
      "fileContentBase64": base64
    };
    final body = jsonEncode(temp);
    ResAttachmentNoDataModel data =
        await worklistService.attatchment(context, body);
    if (data.result == "success") {
      DialogHelper.hideLoading(context);
      // DialogHelper.showSuccessDialog(context, "", 1);
      FocusScope.of(context).requestFocus(new FocusNode());
      return true;
    } else {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, data.message);
      return false;
    }
  } catch (e) {
    DialogHelper.hideLoading(context);
    DialogHelper.showErrorMessageDialog(context, e.toString());
    return false;
  }
}

takePhotoWorklist(BuildContext context, String id,
    List<TrWorklistAttachmentRow> itemsFile) async {
  bool response = false;
  try {
    if (itemsFile.length > 9) {
      DialogHelper.showErrorMessageDialog(context, "limit 10 file");
    } else {
      if (await checkPermissionCamera()) {
        final ImagePicker picker = ImagePicker();
        final XFile? photo = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 100,
        );
        if (photo != null) {
          ResizeFileModel result = await MyFile().resizeFile(context, photo);
          //Save image
          if (result.base64 != "" && result.typefile != "") {
            final tempBase64 = result.base64;
            final typefile = result.typefile;
            response =
                await saveAttachmentWorklist(context, id, tempBase64, typefile);
          }
        }
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return response;
}

selectFileWorklist(BuildContext context, String id,
    List<TrWorklistAttachmentRow> itemsFile) async {
  bool response = false;
  try {
    if (itemsFile.length > 9) {
      DialogHelper.showErrorMessageDialog(context, "limit 10 file");
    } else {
      if (await checkPermissionGallery()) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
        );
        print(result);
        if (result != null) {
          for (var element in result.xFiles) {
            final dataBytes = await element.readAsBytes();

            final tempBase64 = base64Encode(dataBytes);
            final typefile = lookupMimeType(element.path);
            response = await saveAttachmentWorklist(
                context, id, tempBase64, typefile ?? "");
          }
        }
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return response;
}

removeFileWorklist(BuildContext context, String id) async {
  bool response = false;
  try {
    WorklistService worklistService = WorklistService();
    DialogHelper.showLoading(context);
    ResponseModel data = await worklistService.deleteAttachment(context, id);
    if (data.result == "success") {
      response = true;
      DialogHelper.hideLoading(context);
      // DialogHelper.showSuccessDialog(context, "", 1);
      FocusScope.of(context).requestFocus(new FocusNode());
    } else {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, data.message);
    }
  } catch (e) {
    DialogHelper.hideLoading(context);
    DialogHelper.showErrorMessageDialog(context, e.toString());
  }
  return response;
}

// downloadFileWorklist(BuildContext context, String id, String fileName) async {
//   try {
//     WorklistService worklistService = WorklistService();
//     DialogHelper.showLoading(context);
//     final result = await worklistService.download(context, id);
//     if (result.result == "success") {
//       final tempUrl = result.data;
//       if (tempUrl != "") {
//         if (await checkPermissionGallery()) {
//           String? selectedDirectory =
//               await FilePicker.platform.getDirectoryPath();
//           if (selectedDirectory == null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text(
//                   "No directory selected",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           } else {
//             await FlutterDownloader.enqueue(
//                 url: tempUrl,
//                 fileName: fileName.replaceAll("/", "_"),
//                 headers: {}, // optional: header send with url (auth token etc)
//                 savedDir: selectedDirectory,
//                 showNotification:
//                     true, // show download progress in status bar (for Android)
//                 openFileFromNotification:
//                     true, // click on notification to open downloaded file (for Android)
//                 saveInPublicStorage: true);
//             DialogHelper.hideLoading(context);
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: const Text(
//                   "Save file success",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 backgroundColor: MyColors().secondary(),
//               ),
//             );
//           }
//         }
//       } else {
//         DialogHelper.hideLoading(context);
//         DialogHelper.showErrorMessageDialog(context, "Url not found");
//       }
//     } else {
//       DialogHelper.hideLoading(context);
//       DialogHelper.showErrorMessageDialog(context, result.message);
//     }
//   } catch (e) {
//     DialogHelper.hideLoading(context);
//     DialogHelper.showErrorMessageDialog(context, e.toString());
//   }
// }

Future<void> saveXFileToDownloadsWorklist(
    BuildContext context, FileModel item) async {
  try {
    if (await checkPermissionGallery()) {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "No directory selected",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        final bytes = await item.file!.readAsBytes();
        final filePath = path.join(selectedDirectory, item.name);
        final file = await File(filePath).create(recursive: true);
        await file.writeAsBytes(bytes);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Save file success",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: MyColors().secondary(),
          ),
        );
      }
    }
  } catch (e) {
    print("$e");
  }
}
