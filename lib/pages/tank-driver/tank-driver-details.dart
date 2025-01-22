import 'package:flutter/material.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/models/app/res-check-stastus-model.dart';
import 'package:starlightserviceapp/models/app/tank-driver/res-tank-details-model.dart';
import 'package:starlightserviceapp/pages/tank-driver/tank-driver-edit.dart';
import 'package:starlightserviceapp/services/app/tank-service.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/utils/format-datatime.dart';
import 'package:starlightserviceapp/utils/input-data-widget.dart';
import 'package:starlightserviceapp/widgets/appbar.dart';
import 'package:starlightserviceapp/widgets/dialog-confirm.dart';

class TankDriverDetailsPage extends StatefulWidget {
  final String id;
  final String jobStatus;

  const TankDriverDetailsPage(
      {super.key, required this.id, required this.jobStatus});

  @override
  State<TankDriverDetailsPage> createState() => _TankDriverDetailsPageState();
}

class _TankDriverDetailsPageState extends State<TankDriverDetailsPage> {
  TankService tankService = TankService();

  TrTankManagementsDetailsRow? dataDetails;
  String itemsDo = "";
  String checkStatus = "";

  late TankDetailsDataModel tempDataTankDriverDetails;

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
      TankDetailsDataModel data = await tankService.getById(context, id);
      tempDataTankDriverDetails = data;
      if (data.trTankManagements.rows.isNotEmpty) {
        setState(() {
          dataDetails = data.trTankManagements.rows[0];
          if (dataDetails != null) {
            checkStatus = dataDetails?.workStatusCode == "2"
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
          builder: (_context) => TankDriverEditPage(
              fromDataTankDriverDetails: tempDataTankDriverDetails)),
    ).then((_) => setState(() {
          getDataById(widget.id);
        }));
  }

  onDelete(BuildContext _context, String id, String no) {
    dialogConfirmDelete(context, "ต้องการลบเลขที่งาน", no);
    showDialog(
        context: _context,
        builder: (_context) {
          return dialogConfirmDelete(
              context, "ต้องการลบเลขที่งานนี้ใช่หรือไม่?", no);
        }).then((value) async {
      if (value == true)
        setState(() {
          deleteItem(id);
        });
    });
  }

  deleteItem(String id) async {
    try {
      DialogHelper.showLoadingWithText(context, "loading...");
      ResCheckStatusModel data = await tankService.deleteById(context, id);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().backgroundColor(),
      appBar: MyAppBar(
        title: "แจ้งล้างแท้งก์ (รายละเอียด)",
        listWidget: [
          if (checkStatus != "")
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
                  "ลบ",
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
                  onPressed: () => onEdit(context),
                  child: const Text(
                    "แก้ไข",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  )),
            )
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
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
