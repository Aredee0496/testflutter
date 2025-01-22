import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/models/app/dropdown-items-model.dart';
import 'package:starlightserviceapp/models/app/file/file-model.dart';
import 'package:starlightserviceapp/models/app/file/resize-file-model.dart';
import 'package:starlightserviceapp/models/app/jobmoving/jobmoving-attatchments-model.dart';
import 'package:starlightserviceapp/models/app/jobmoving/jobmoving-model.dart';
import 'package:starlightserviceapp/models/app/masterdata/masterdata-model.dart';
import 'package:starlightserviceapp/models/family/response.dart';
import 'package:starlightserviceapp/services/app/getfile-service.dart';
import 'package:starlightserviceapp/services/app/jobmoving-service.dart';
import 'package:starlightserviceapp/utils/button-style.dart';
import 'package:starlightserviceapp/utils/check-size-file.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/utils/date-picker.dart';
import 'package:starlightserviceapp/utils/format-datatime.dart';
import 'package:starlightserviceapp/utils/input-data-widget.dart';
import 'package:starlightserviceapp/widgets/appbar.dart';
import 'package:intl/intl.dart';
import 'package:starlightserviceapp/widgets/dialog-confirm.dart';
import 'package:mime/mime.dart';
import 'package:starlightserviceapp/widgets/input/mydropdown.dart';

class AddJobMovingWidget extends StatefulWidget {
  const AddJobMovingWidget(
      {super.key, this.id, required this.title, required this.action});
  final String title;
  final String? id;
  final String action;

  @override
  State<AddJobMovingWidget> createState() => _AddJobMovingWidgetState();
}

class _AddJobMovingWidgetState extends State<AddJobMovingWidget> {
  final GlobalKey<FormState> _keyFormJobMoving = GlobalKey<FormState>();

  List<DropdownMenuEntry> itemsLicenseNo = [];
  TextEditingController dataDate = TextEditingController();
  TextEditingController containerNo = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController locationStart = TextEditingController();
  TextEditingController locationEnd = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController driver = TextEditingController();
  TextEditingController remark = TextEditingController();
  TextEditingController licenseNo = TextEditingController();

  DropdownItemsModel? _selectedLicenseNo;
  DropdownItemsModel? _selectedJobStatus;

  List<JobMovingModel> dataDetail = [];

  List<TrJobMovingAttatchmentsModel> itemsFile = [];
  JobMovingService jobMovingService = JobMovingService();

  List<DropdownItemsModel> itemsDropdownJobstatus = [];
  List<DropdownItemsModel> itemsDropdownLicenseNo = [];

  JobMovingModel? jobMoving;

  @override
  void initState() {
    super.initState();
    final temp = widget.id;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMasterData(temp ?? "");
    });
  }

  onRefreshFile(String id) async {
    try {
      DialogHelper.showLoadingWithText(context, "loading...");
      MasterDataModel masterData = await jobMovingService.getById(context, id);
      final attetch = masterData.trJobMovingAttatchments;
      itemsFile = [];
      setState(() {
        if (attetch.isNotEmpty) {
          for (var item in attetch) {
            itemsFile.add(TrJobMovingAttatchmentsModel(
                jobMovingAttatmentId: item.jobMovingAttatmentId,
                attatment: item.attatment,
                fileId: item.fileId,
                fullFilePath: item.fullFilePath));
          }
        }
      });
      DialogHelper.hideLoading(context);
      FocusScope.of(context).requestFocus(new FocusNode());
    } catch (e) {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, e.toString());
    }
  }

  getMasterData(String id) async {
    try {
      DialogHelper.showLoadingWithText(context, "loading...");
      print("1");
      MasterDataModel masterData = await jobMovingService.getById(context, id);
      print("2");
      setState(() {
        jobMoving =
            masterData.jobMovings.isNotEmpty ? masterData.jobMovings[0] : null;
        print("3");
        itemsDropdownJobstatus = masterData.msJobStatus.isNotEmpty
            ? masterData.msJobStatus
                .map((e) => DropdownItemsModel(
                    value: e.jobStatusCode, text: e.description))
                .toList()
            : [];

        itemsDropdownLicenseNo = [];
        print("4");
        if (masterData.msDriver.isNotEmpty) {
          for (var i = 0; i < masterData.msDriver.length; i++) {
            final temp = masterData.msDriver[i].msLicenseNos;
            print("5");
            if (temp.isNotEmpty) {
              for (var item in temp) {
                itemsDropdownLicenseNo.add(DropdownItemsModel(
                    value: item.licenseNoId, text: item.licenseNo));
              }
            }
          }

          // final indexDriver = masterData.msDriver
          //     .indexWhere((e) => e.driverId == jobMoving?.driverId);
          // if (indexDriver > -1) {
          //   final temp = masterData.msDriver[indexDriver].msLicenseNos;
          //   if (temp.isNotEmpty) {
          //     for (var item in temp) {
          //       itemsDropdownLicenseNo.add(DropdownItemsModel(
          //           value: item.licenseNoId, text: item.licenseNo));
          //     }
          //   }
          // }
        }
        try {
          if (itemsDropdownLicenseNo.isNotEmpty) {
            _selectedLicenseNo = itemsDropdownLicenseNo.firstWhere(
                (item) => item.value == jobMoving?.licenseNoId,
                orElse: null);
          }
        } catch (e) {
          print("$e");
        }
        try {
          if (itemsDropdownJobstatus.isNotEmpty) {
            _selectedJobStatus = itemsDropdownJobstatus.firstWhere(
                (item) => item.value == jobMoving?.jobStatus,
                orElse: null);
          }
        } catch (e) {
          print("$e");
        }

        dataDate.text =
            MyFormatDateTime().formatDateDisplay(jobMoving?.dateWork ?? "");
        containerNo.text = "${jobMoving?.containerNo}";
        locationStart.text = "${jobMoving?.locationStart}";
        locationEnd.text = "${jobMoving?.locationEnd}";
        reason.text = "${jobMoving?.reason}";
        driver.text = "${jobMoving?.driver}";
        remark.text = "${jobMoving?.remark}";
        itemsFile = [];
        final attetch = masterData.trJobMovingAttatchments;
        if (attetch.isNotEmpty) {
          for (var item in attetch) {
            itemsFile.add(TrJobMovingAttatchmentsModel(
                jobMovingAttatmentId: item.jobMovingAttatmentId,
                attatment: item.attatment,
                fileId: item.fileId,
                fullFilePath: item.fullFilePath));
          }
        }
      });
      DialogHelper.hideLoading(context);
      FocusScope.of(context).requestFocus(new FocusNode());
    } catch (e) {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, e.toString());
    }
  }

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
      print("ios");
      var status = await Permission.photos.status;
      print("ios => ${status.isGranted}");
      if (status.isGranted) {
        response = true;
      } else {
        final result = await Permission.photos.request();
        print("ios => ${result}");
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

  saveAttachment(String base64, String fileType) async {
    try {
      DialogHelper.showLoading(context);
      final temp = {
        "JobID": widget.id,
        "fileType": fileType,
        "fileContentBase64": base64
      };
      print("saveAttachment => $temp");
      final body = jsonEncode(temp);
      ResponseModel data = await jobMovingService.attatchment(context, body);
      if (data.result == "success") {
        DialogHelper.hideLoading(context);
        // DialogHelper.showSuccessDialog(context, "", 1);
        FocusScope.of(context).requestFocus(new FocusNode());

        setState(() {
          onRefreshFile(widget.id ?? "");
        });
      } else {
        DialogHelper.hideLoading(context);
        DialogHelper.showErrorMessageDialog(context, data.message);
      }
    } catch (e) {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, e.toString());
    }
  }

  takePhoto() async {
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
              saveAttachment(tempBase64, typefile);
            }
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  selectFile() async {
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
              await saveAttachment(tempBase64, typefile ?? "");
            }
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  removeFile(String id) async {
    try {
      DialogHelper.showLoading(context);
      ResponseModel data = await jobMovingService.deleteAttachment(context, id);
      if (data.result == "success") {
        DialogHelper.hideLoading(context);
        // DialogHelper.showSuccessDialog(context, "", 1);
        setState(() {
          onRefreshFile(widget.id ?? "");
        });
      } else {
        DialogHelper.hideLoading(context);
        DialogHelper.showErrorMessageDialog(context, data.message);
      }
    } catch (e) {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, e.toString());
    }
  }

  downloadFile(String id, String fileName) async {
    try {
      if (MyFile().isImageFile(fileName)) {
        DialogHelper.showLoading(context);
        final result = await jobMovingService.download(context, id);
        if (result.result == "success") {
          final tempUrl = result.data;
          if (tempUrl != "") {
            GetFileService getFileService = GetFileService();
            final byte = await getFileService.getfile(tempUrl);
            if (byte != null) {
              DialogHelper.hideLoading(context);
              DialogHelper.showDialogViewImageByte(context, byte);
            } else {
              DialogHelper.hideLoading(context);
              DialogHelper.showErrorMessageDialog(
                  context, "ไม่สามารถดาวน์โหลดไฟล์นี้");
            }
            //   if (await checkPermissionGallery()) {
            //     String? selectedDirectory =
            //         await FilePicker.platform.getDirectoryPath();
            //     if (selectedDirectory == null) {
            //       DialogHelper.hideLoading(context);
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(
            //           content: Text(
            //             "No directory selected",
            //             style: TextStyle(color: Colors.white),
            //           ),
            //           backgroundColor: Colors.red,
            //         ),
            //       );
            //     } else {
            //       await FlutterDownloader.enqueue(
            //           url: tempUrl,
            //           fileName: fileName.replaceAll("/", "_"),
            //           headers: {}, // optional: header send with url (auth token etc)
            //           savedDir: selectedDirectory,
            //           showNotification:
            //               true, // show download progress in status bar (for Android)
            //           openFileFromNotification:
            //               true, // click on notification to open downloaded file (for Android)
            //           saveInPublicStorage: true);
            //       DialogHelper.hideLoading(context);
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: const Text(
            //             "Save file success",
            //             style: TextStyle(color: Colors.white),
            //           ),
            //           backgroundColor: MyColors().secondary(),
            //         ),
            //       );
            //     }
            //   } else {
            //     DialogHelper.hideLoading(context);
            //   }
          } else {
            DialogHelper.hideLoading(context);
            DialogHelper.showErrorMessageDialog(context, "ไม่พบ URL ไฟล์");
          }
        } else {
          DialogHelper.hideLoading(context);
          DialogHelper.showErrorMessageDialog(context, result.message);
        }
      } else {
        DialogHelper.hideLoading(context);
        DialogHelper.showErrorMessageDialog(context, "ต้องเป็นไฟล์รูปเท่านั้น");
      }
    } catch (e) {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, e.toString());
    }
  }

  Future<void> saveXFileToDownloads(FileModel item) async {
    try {
      if (await checkPermissionGallery()) {
        String? selectedDirectory =
            await FilePicker.platform.getDirectoryPath();
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

  checkRequire() {
    List<String> res = [];
    if (_selectedJobStatus == null) {
      res.add("สถานะ");
    } else {
      if (containerNo.text == "") {
        res.add("เบอร์ตู้");
      }
    }
    return res;
  }

  onUpdate() async {
    try {
      DialogHelper.showLoading(context);

      List<String> checkReq = await checkRequire();
      if (checkReq.isNotEmpty) {
        String tempMessage = "";
        for (var i = 0; i < checkReq.length; i++) {
          final temp = checkReq[i];
          if (i == 0) {
            tempMessage = "$tempMessage$temp";
          } else {
            tempMessage = "$tempMessage\n$temp";
          }
        }
        DialogHelper.hideLoading(context);
        DialogHelper.showErrorMessageDialog(context, tempMessage);
      } else {
        int tempJobStatus = int.parse(_selectedJobStatus!.value);

        final temp = {
          "JobStatus": tempJobStatus,
          "DocumentNo": jobMoving?.documentNo,
          "PlantCode": jobMoving?.plantCode,
          "DateWork": jobMoving?.dateWork,
          "ContainerNo": containerNo.text,
          "Remark": remark.text,
          "DriverID": jobMoving?.driverId,
          "Driver": jobMoving?.driver,
          "Email": jobMoving?.email,
          "LicenseNoID": _selectedLicenseNo?.value,
          "LicenseNo": _selectedLicenseNo?.text,
          "Supplementary2": jobMoving?.supplementary2,
          "ReasonID": jobMoving?.reasonId,
          "Reason": jobMoving?.reason,
          "LocationStart": jobMoving?.locationStart,
          "LocationEnd": jobMoving?.locationEnd,
          "CreatebyTH": jobMoving?.createbyTh,
          "CreatebyEN": jobMoving?.createbyEn,
          "RateType": null,
          "Status": jobMoving?.status
        };
        final body = jsonEncode(temp);
        ResponseModel data =
            await jobMovingService.update(context, widget.id ?? "", body);
        if (data.result == "success") {
          DialogHelper.hideLoading(context);
          DialogHelper.showSuccessDialog(context, "", 1);
          FocusScope.of(context).requestFocus(new FocusNode());
          setState(() {
            getMasterData(widget.id ?? "");
          });
        } else {
          DialogHelper.hideLoading(context);
          DialogHelper.showErrorMessageDialog(context, data.message);
        }
      }
    } catch (e) {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyFormJobMoving,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(
          title: widget.title,
          listWidget: [
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 8),
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: WidgetStateProperty.all(2),
                      backgroundColor:
                          WidgetStateProperty.all(MyColors().secondary())),
                  onPressed: () => onUpdate(),
                  child: const Text(
                    "บันทึก",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  )),
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleWithWidget(
                      "สถานะ",
                      "",
                      myDropdownMenu2(
                          items: itemsDropdownJobstatus,
                          label: "",
                          enabled: true,
                          selectedItems: [],
                          initValue: _selectedJobStatus,
                          onSelected: (value) => setState(() {
                                _selectedJobStatus = value;
                              }))),
                  titleWithWidget(
                    "วันที่",
                    " *",
                    TextFormField(
                      onTap: () async {
                        final temp = await chooseDate(context, DateTime.now());
                        if (temp != null) {
                          dataDate.text =
                              DateFormat(FORMATE_DATE_DISPLAY).format(temp);
                        }
                      },
                      controller: dataDate,
                      enabled: false,
                      readOnly: true,
                      style: TextStyle(fontSize: 18, height: null),
                      decoration:
                          inputDecorationIcon(Icon(Icons.calendar_month), ""),
                    ),
                  ),
                  titleWithWidget(
                    "เบอร์ตู้",
                    " *",
                    TextFormField(
                      controller: containerNo,
                      enabled: true,
                      readOnly: false,
                      style: TextStyle(fontSize: 18, height: null),
                      decoration: inputDecoration(""),
                    ),
                  ),
                  titleWithWidget(
                    "ลากจาก",
                    "",
                    TextFormField(
                      controller: locationStart,
                      enabled: false,
                      readOnly: false,
                      style: TextStyle(fontSize: 18, height: null),
                      decoration: inputDecoration(""),
                    ),
                  ),
                  titleWithWidget(
                    "ไปยัง",
                    "",
                    TextFormField(
                      controller: locationEnd,
                      enabled: false,
                      readOnly: false,
                      style: TextStyle(fontSize: 18, height: null),
                      decoration: inputDecoration(""),
                    ),
                  ),
                  titleWithWidget(
                    "สาเหตุการเคลื่อนย้าย",
                    "",
                    TextFormField(
                      controller: reason,
                      enabled: false,
                      readOnly: false,
                      style: TextStyle(fontSize: 18, height: null),
                      decoration: inputDecoration(""),
                    ),
                  ),
                  titleWithWidget(
                    "ผู้รับ",
                    " *",
                    TextFormField(
                      controller: driver,
                      enabled: false,
                      readOnly: false,
                      style: TextStyle(fontSize: 18, height: null),
                      decoration: inputDecoration(""),
                    ),
                  ),
                  titleWithWidget(
                    "หมายเหตุ",
                    "",
                    TextFormField(
                      controller: remark,
                      readOnly: false,
                      style: TextStyle(fontSize: 18, height: null),
                      decoration: inputDecoration(""),
                    ),
                  ),
                  titleWithWidget(
                      "ทะเบียนรถเทรลเลอร์",
                      "",
                      myDropdownMenu2(
                          items: itemsDropdownLicenseNo,
                          label: "",
                          enabled: true,
                          selectedItems: [],
                          initValue: _selectedLicenseNo,
                          onSelected: (value) => _selectedLicenseNo = value)),
                  titleWithWidget(
                      "ไฟล์แนบ",
                      "",
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: MyColors().primary()),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5),
                                      child: Icon(
                                        Icons.cloud_upload_outlined,
                                        size: 40,
                                        weight: 1,
                                        color: MyColors().secondary(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: ElevatedButton(
                                          style: MyStyle().elevatedButton(),
                                          onPressed: () {
                                            selectFile();
                                          },
                                          child: const Text("เลือกรูป")),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: VerticalDivider(
                                  color: MyColors().primary(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5),
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 40,
                                        weight: 1,
                                        color: MyColors().secondary(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: ElevatedButton(
                                          style: MyStyle().elevatedButton(),
                                          onPressed: () {
                                            takePhoto();
                                          },
                                          child: const Text("ถ่ายรูป")),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  attachmentEditsWidget(context, itemsFile)
                ],
              ),
            )),
      ),
    );
  }

  Widget attachmentEditsWidget(
      BuildContext context, List<TrJobMovingAttatchmentsModel> items) {
    final List<String> header = ["No.", "ไฟล์", ""];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Table(
          border: TableBorder.all(),
          columnWidths: {
            0: const FlexColumnWidth(1),
            1: const FlexColumnWidth(5),
            3: const FlexColumnWidth(1),
          },
          children: [
            TableRow(
              children: header
                  .map(
                    (col) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          col,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            if (items.isEmpty)
              const TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        '',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'No data',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        '',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ...items.asMap().entries.map((entry) {
              int index = entry.key; // This is the index
              final item = entry.value; // This is the actual item
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      "${index + 1}",
                      style: const TextStyle(fontSize: 16),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(item.attatment ?? "",
                            style: const TextStyle(fontSize: 16))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                        child: PopupMenuButton(
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      onSelected: (value) {
                        if (value == "1") {
                          downloadFile(item.jobMovingAttatmentId ?? "",
                              item.attatment ?? "");
                        } else if (value == "2") {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return dialogConfirmDelete(
                                    context, "ยืนยัน?", "ต้องการลบไฟล์นี้");
                              }).then((value) async {
                            if (value == true) {
                              removeFile(item.jobMovingAttatmentId ?? "");
                            }
                          });
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: "1",
                          child: ListTile(
                            leading: Icon(
                              Icons.visibility,
                              color: MyColors().secondary(),
                            ),
                            title: const Text('ดูรูป'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: "2",
                          child: ListTile(
                            leading: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            title: Text('ลบ'),
                          ),
                        )
                      ],
                    )),
                  ),
                ],
              );
            }),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget listFile(List<TrJobMovingAttatchmentsModel> items) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            style: ListTileStyle.list,
            title: Text(item.attatment ?? ""),
            subtitle: Text(""),
            leading: InkWell(
              onTap: () {
                // if (item.fromType != 3) {
                //   saveXFileToDownloads(item);
                // } else {
                if (item.jobMovingAttatmentId != null &&
                    item.attatment != null) {
                  downloadFile(
                      item.jobMovingAttatmentId ?? "", item.attatment ?? "");
                }

                // }
              },
              child: Icon(
                Icons.download_rounded,
                color: MyColors().secondary(),
              ),
            ),
            trailing: InkWell(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return dialogConfirm(
                          context, "ลบข้อมูล?", "ยืนยันการลบข้อมูล");
                    }).then((value) async {
                  if (value == true) {
                    if (item.jobMovingAttatmentId != null) {
                      removeFile(item.jobMovingAttatmentId ?? "");
                    }
                  }
                });
              },
              child: const Icon(
                Icons.highlight_off,
                color: Colors.red,
              ),
            ),
          );
        });
  }
}
