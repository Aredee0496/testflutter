import 'package:flutter/material.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-attachment-model.dart';
import 'package:starlightserviceapp/services/app/getfile-service.dart';
import 'package:starlightserviceapp/services/app/worklist-service.dart';
import 'package:starlightserviceapp/utils/check-size-file.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/utils/input-file-worklist.dart';
import 'package:starlightserviceapp/widgets/dialog-confirm.dart';

Widget attachmentsWidget(
    BuildContext context, List<TrWorklistAttachmentRow> items) {
  final List<String> header = ["No.", "ไฟล์", "Type", ""];
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Table(
        border: TableBorder.all(),
        columnWidths: {
          0: const FlexColumnWidth(1),
          1: const FlexColumnWidth(5),
          2: const FlexColumnWidth(2),
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
                    style: TextStyle(fontSize: 16, color: MyColors().primary()),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(item.attatchmentName ?? "",
                          style: TextStyle(
                              fontSize: 16, color: MyColors().primary()))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(item.attatchmentType ?? "",
                          style: TextStyle(
                              fontSize: 16, color: MyColors().primary()))),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                      child: IconButton(
                    icon: Icon(
                      Icons.visibility,
                      color: MyColors().secondary(),
                    ),
                    onPressed: () {
                      downloadFileWorklist(context, item.attatmentID ?? "",
                          item.attatchmentName ?? "");
                    },
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

Widget attachmentEditsWidget(
    BuildContext context, List<TrWorklistAttachmentRow> items,
    {required VoidCallback onReload}) {
  final List<String> header = ["No.", "ไฟล์", "Type", ""];
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Table(
        border: TableBorder.all(),
        columnWidths: {
          0: const FlexColumnWidth(1),
          1: const FlexColumnWidth(5),
          2: const FlexColumnWidth(2),
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
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(item.attatchmentName ?? "",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.grey))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(item.attatchmentType ?? "",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.grey))),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                      child: PopupMenuButton(
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    onSelected: (value) {
                      if (value == "1") {
                        downloadFileWorklist(context, item.attatmentID ?? "",
                            item.attatchmentName ?? "");
                      } else if (value == "2") {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return dialogConfirmDelete(
                                  context, "ยืนยัน?", "ต้องการลบไฟล์นี้");
                            }).then((value) async {
                          if (value == true) {
                            final finish = await removeFileWorklist(
                                context, item.attatmentID ?? "");
                            if (finish) {
                              onReload();
                            }
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
                      if (item.attatchmentType == "Driver")
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

downloadFileWorklist(BuildContext context, String id, String fileName) async {
  try {
    if (MyFile().isImageFile(fileName)) {
      WorklistService worklistService = WorklistService();
      DialogHelper.showLoading(context);
      final result = await worklistService.download(context, id);
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

          // if (await checkPermissionGallery()) {
          //   String? selectedDirectory =
          //       await FilePicker.platform.getDirectoryPath();
          //   if (selectedDirectory == null) {
          //     DialogHelper.hideLoading(context);
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(
          //         content: Text(
          //           "No directory selected",
          //           style: TextStyle(color: Colors.white),
          //         ),
          //         backgroundColor: Colors.red,
          //       ),
          //     );
          //   } else {
          //     await FlutterDownloader.enqueue(
          //         url: tempUrl,
          //         fileName: fileName.replaceAll("/", "_"),
          //         headers: {}, // optional: header send with url (auth token etc)
          //         savedDir: selectedDirectory,
          //         showNotification:
          //             true, // show download progress in status bar (for Android)
          //         openFileFromNotification:
          //             true, // click on notification to open downloaded file (for Android)
          //         saveInPublicStorage: true);
          //     DialogHelper.hideLoading(context);
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: const Text(
          //           "Save file success",
          //           style: TextStyle(color: Colors.white),
          //         ),
          //         backgroundColor: MyColors().secondary(),
          //       ),
          //     );
          //   }
          // } else {
          //   DialogHelper.hideLoading(context);
          // }
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
