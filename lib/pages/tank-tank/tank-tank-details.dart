import 'package:flutter/material.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/models/app/res-check-stastus-model.dart';
import 'package:starlightserviceapp/models/app/tank-tank/res-tank-tank-details-model.dart';
import 'package:starlightserviceapp/pages/tank-tank/tank-tank-edit.dart';
import 'package:starlightserviceapp/pages/tank-tank/widget/attachmentsTank.dart';
import 'package:starlightserviceapp/pages/tank-tank/widget/liststafftank.dart';
import 'package:starlightserviceapp/services/app/tank-tank-service.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/utils/format-datatime.dart';
import 'package:starlightserviceapp/utils/input-data-widget.dart';
import 'package:starlightserviceapp/widgets/appbar.dart';
import 'package:starlightserviceapp/widgets/dialog-confirm.dart';

class TankTankDetailsPage extends StatefulWidget {
  final String id;
  final String jobStatus;

  const TankTankDetailsPage(
      {super.key, required this.id, required this.jobStatus});

  @override
  State<TankTankDetailsPage> createState() => _TankTankDetailsPageState();
}

class _TankTankDetailsPageState extends State<TankTankDetailsPage> {
  TankTankService tankService = TankTankService();

  TrTankManagementsRow? dataDetails;
  String itemsDo = "";
  String checkStatus = "";
  String checkStatusCancel = "";

  late TankTankDetailsData tempDataTankDriverDetails;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDataById(widget.id);
    });
  }

  getDataById(String id) async {
    try {
      DialogHelper.showLoadingWithText(context, "loading...");
      TankTankDetailsData data = await tankService.getById(context, id);
      tempDataTankDriverDetails = data;
      if (data.trTankManagements.rows.isNotEmpty) {
        setState(() {
          dataDetails = data.trTankManagements.rows[0];
          if (dataDetails != null) {
            checkStatus = dataDetails?.workStatusCode == "2" ||
                    dataDetails?.workStatusCode == "3" ||
                    dataDetails?.workStatusCode == "9"
                ? dataDetails!.workStatusCode ?? ""
                : "";
            checkStatusCancel = dataDetails?.workStatusCode == "2" ||
                    dataDetails?.workStatusCode == "9"
                ? dataDetails!.workStatusCode ?? ""
                : "";
          }
        });
        DialogHelper.hideLoading(context);
      } else {
        DialogHelper.hideLoading(context);
        DialogHelper.showErrorMessageDialog(context, "ไม่มีข้อมูล");
      }
    } catch (e) {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, e.toString());
    }
  }

  onEdit(BuildContext _context) {
    Navigator.push(
      _context,
      MaterialPageRoute(
          builder: (_context) => TankTankEditPage(
              fromDataTankTankDetails: tempDataTankDriverDetails)),
    ).then((_) => setState(() {
          getDataById(widget.id);
        }));
  }

  onDelete(BuildContext _context, String id, String no) {
    dialogConfirmDelete(context, "ต้องการยกเลิกเลขที่งาน", no);
    showDialog(
        context: _context,
        builder: (_context) {
          return dialogConfirmDelete(
              context, "ต้องการยกเลิกเลขที่งานนี้ใช่หรือไม่?", no);
        }).then((value) async {
      if (value == true)
        setState(() {
          cancelWork(id);
        });
    });
  }

  cancelWork(String id) async {
    try {
      DialogHelper.showLoadingWithText(context, "loading...");

      ResCheckStatusModel data = await tankService.cancelWork(
        context,
        id,
      );
      if (data.result == "success") {
        DialogHelper.hideLoading(context);
        DialogHelper.showSuccessDialog(context, "", 2);
        FocusScope.of(context).requestFocus(new FocusNode());
      } else {
        DialogHelper.hideLoading(context);
        DialogHelper.showErrorMessageDialog(context, data.message);
      }
    } catch (e) {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, e.toString());
    }
  }

  updatestatus() async {
    try {
      DialogHelper.showLoadingWithText(context, "loading...");
      final id = dataDetails?.tankManagementId ?? "";
      ResCheckStatusModel data = await tankService.updatestatus9(context, id);
      if (data.result == "success") {
        DialogHelper.hideLoading(context);
        await getDataById(id);
        onEdit(context);
      } else {
        DialogHelper.hideLoading(context);
        DialogHelper.showErrorMessageDialog(context, data.message);
      }
    } catch (e) {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().backgroundColor(),
      appBar: MyAppBar(
        title: "ปฏิบัติงานล้างแท็งก์ (รายละเอียด)",
        listWidget: [
          if (checkStatusCancel != "")
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: OutlinedButton(
                onPressed: () => onDelete(
                    context,
                    dataDetails?.tankManagementId ?? "",
                    dataDetails?.tankManagementNo ?? ""),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                ),
                child: const Text(
                  "ยกเลิก",
                  style: TextStyle(fontSize: 22, color: Colors.red),
                ),
              ),
            ),
          if (checkStatus != "")
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 8),
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: WidgetStateProperty.all(2),
                      backgroundColor:
                          WidgetStateProperty.all(MyColors().secondary())),
                  onPressed: () =>
                      checkStatus == "2" ? updatestatus() : onEdit(context),
                  child: Text(
                    checkStatus == "2" ? "รับงาน" : "แก้ไข",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  )),
            ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleWithTextHeader(context, "เลขที่งาน",
                        dataDetails?.tankManagementNo ?? ""),
                    titleWithText("สถานะ", dataDetails?.workStatus ?? ""),
                    titleWithText(
                        "วันที่",
                        MyFormatDateTime().formatDateDisplay(
                            dataDetails?.tankManagementDate ?? "")),
                    titleWithText("รหัสแท็งก์", dataDetails?.tankNo ?? ""),
                    titleWithText("ประเภทแทงก์", dataDetails?.tankType ?? ""),
                    titleWithText(
                        "ประเภทการล้าง", dataDetails?.cleanType ?? ""),
                    titleWithText(
                        "วันที่ต้องการนำแท็งก์เข้าล้าง",
                        MyFormatDateTime()
                            .formatDateDisplay(dataDetails?.workDate ?? "")),
                    titleWithText("วัน-เวลาที่เริ่มงาน",
                        "${MyFormatDateTime().formatDateDisplay(dataDetails?.acceptWorkDate ?? "")} ${dataDetails?.acceptWorkTime ?? ""}"),
                    titleWithText("วัน-เวลาที่เสร็จงาน",
                        "${MyFormatDateTime().formatDateDisplay(dataDetails?.closeWorkDate ?? "")} ${dataDetails?.closeWorkTime ?? ""}"),
                    titleWithText(
                        "จำนวนพนักงาน", "${dataDetails?.staffSumary ?? ""}"),
                    if (dataDetails != null)
                      listStaffTank(tempDataTankDriverDetails
                          .trTankManagementDetails.rows),
                    Text("ไฟล์แนบ",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    if (dataDetails != null)
                      attachmentsTankWidget(
                          context,
                          tempDataTankDriverDetails
                              .trTankManagementAttatchments.rows)
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
