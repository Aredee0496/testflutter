import 'package:flutter/material.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/models/app/tank-tank/res-tank-tank-details-model.dart';
import 'package:starlightserviceapp/services/app/getfile-service.dart';
import 'package:starlightserviceapp/services/app/tank-tank-service.dart';
import 'package:starlightserviceapp/utils/check-size-file.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/utils/input-file-tank.dart';
import 'package:starlightserviceapp/widgets/dialog-confirm.dart';

Widget attachmentsTankWidget(
    BuildContext context, List<TrTankManagementAttatchmentsRow> items) {
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
                    style: TextStyle(fontSize: 16, color: MyColors().primary()),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(item.attatment ?? "",
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
                      downloadFileTank(
                          context,
                          item.tankManagementAttatmentId ?? "",
                          item.attatment ?? "");
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

Widget attachmentTankEditsWidget(
    BuildContext context, List<TrTankManagementAttatchmentsRow> items,
    {required VoidCallback onReload}) {
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
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(item.attatment ?? "",
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
                        downloadFileTank(
                            context,
                            item.tankManagementAttatmentId ?? "",
                            item.attatment ?? "");
                      } else if (value == "2") {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return dialogConfirmDelete(
                                  context, "ยืนยัน?", "ต้องการลบไฟล์นี้");
                            }).then((value) async {
                          if (value == true) {
                            final finish = await removeFileTank(
                                context, item.tankManagementAttatmentId ?? "");
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

downloadFileTank(BuildContext context, String id, String fileName) async {
  try {
    if (MyFile().isImageFile(fileName)) {
      TankTankService tankService = TankTankService();
      DialogHelper.showLoading(context);
      final result = await tankService.download(context, id);
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
