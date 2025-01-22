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
import 'package:starlightserviceapp/models/app/tank-tank/res-tank-tank-details-model.dart';
import 'package:starlightserviceapp/models/family/response.dart';
import 'package:starlightserviceapp/services/app/tank-tank-service.dart';
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

saveAttachmentTank(
    BuildContext context, String id, String base64, String fileType) async {
  try {
    TankTankService tankService = TankTankService();
    DialogHelper.showLoading(context);
    final temp = {
      "TankManagementID": id,
      "fileType": fileType,
      "AttatchmentTypeCode": 99,
      "AttatchmentType": "Driver",
      "fileContentBase64": base64
    };
    final body = jsonEncode(temp);
    ResAttachmentNoDataModel data =
        await tankService.attatchment(context, body);
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

takePhotoTank(BuildContext context, String id,
    List<TrTankManagementAttatchmentsRow> itemsFile) async {
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
                await saveAttachmentTank(context, id, tempBase64, typefile);
          }
        }
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return response;
}

selectFileTank(BuildContext context, String id,
    List<TrTankManagementAttatchmentsRow> itemsFile) async {
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
            response = await saveAttachmentTank(
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

removeFileTank(BuildContext context, String id) async {
  bool response = false;
  try {
    TankTankService tankService = TankTankService();
    DialogHelper.showLoading(context);
    ResponseModel data = await tankService.deleteAttachment(context, id);
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
