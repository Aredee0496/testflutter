import 'package:flutter/material.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/models/app/res-check-stastus-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-attachment-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-evaluations-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-expenses-rategroup1-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-shipments-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklists-model.dart';
import 'package:starlightserviceapp/models/app/worklist/worklist-details-model.dart';
import 'package:starlightserviceapp/pages/worklist/widget/assessment.dart';
import 'package:starlightserviceapp/pages/worklist/widget/attachments.dart';
import 'package:starlightserviceapp/pages/worklist/widget/rategroup.dart';
import 'package:starlightserviceapp/pages/worklist/worklist-edit.dart';
import 'package:starlightserviceapp/services/app/worklist-service.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/utils/format-datatime.dart';
import 'package:starlightserviceapp/utils/input-data-widget.dart';
import 'package:starlightserviceapp/widgets/appbar.dart';

class WorklistDetailsPage extends StatefulWidget {
  final String id;
  final String jobStatus;

  const WorklistDetailsPage(
      {super.key, required this.id, required this.jobStatus});

  @override
  State<WorklistDetailsPage> createState() => _WorklistDetailsPageState();
}

class _WorklistDetailsPageState extends State<WorklistDetailsPage> {
  WorklistService worklistService = WorklistService();
  TrWorklistsRow? dataDetails;
  List<TrWorklistExpensesRateGroup1Row> rateGroup1 = [];
  List<TrWorklistExpensesRateGroup1Row> rateGroup2 = [];
  List<TrWorklistEvaluationsRow> evaluations = [];
  List<TrWorklistShipmentsRow> shipment = [];
  String itemsDo = "";
  List<TrWorklistAttachmentRow> attachments = [];
  String checkStatus = "";

  late DataWorklistDetails tempDataWorklistDetails;
  onEdit(BuildContext _context) {
    Navigator.push(
      _context,
      MaterialPageRoute(
          builder: (_context) => WorklistEditPage(
              fromDataWorklistDetails: tempDataWorklistDetails)),
    ).then((_) => setState(() {
          getDataById(widget.id);
        }));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDataById(widget.id);
    });
  }

  updatestatus() async {
    try {
      DialogHelper.showLoadingWithText(context, "loading...");
      final id = dataDetails?.worklistId ?? "";
      ResCheckStatusModel data =
          await worklistService.updatestatus9(context, id);
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

  getDataById(String id) async {
    try {
      DialogHelper.showLoadingWithText(context, "loading...");
      WorklistDetailsModel data = await worklistService.getById(context, id);
      if (data.data.trWorklists.rows.isNotEmpty) {
        final temp = data.data;
        tempDataWorklistDetails = temp;
        List<TrWorklistShipmentsRow> tempShipment =
            data.data.trWorklistShipments.rows;
        String tempDO = "";
        for (var i = 0; i < tempShipment.length; i++) {
          final itemDo = tempShipment[i];
          if (i == 0) {
            tempDO = tempDO + "${itemDo.deliveryOrderNo}";
          } else {
            tempDO = tempDO + "\n${itemDo.deliveryOrderNo}";
          }
        }
        setState(() {
          dataDetails = temp.trWorklists.rows[0];
          checkStatus = dataDetails?.jobStatus == "2" ||
                  dataDetails?.jobStatus == "3" ||
                  dataDetails?.jobStatus == "9"
              ? dataDetails?.jobStatus ?? ""
              : "";
          rateGroup1 = temp.trWorklistExpensesRateGroup1.rows;
          rateGroup2 = temp.trWorklistExpensesRateGroup2.rows;
          evaluations = temp.trWorklistEvaluations.rows;
          shipment = temp.trWorklistShipments.rows;
          itemsDo = tempDO;
          attachments = temp.trWorklistAttatchments.rows;
        });
      }

      DialogHelper.hideLoading(context);
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
        title: "ใบปฏิบัติงาน (รายละเอียด)",
        listWidget: [
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
            )
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
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
                        "${dataDetails?.worklistDocumentNo}"),
                    titleWithText(
                        "สถานะ", dataDetails?.jobStatusDescription ?? ""),
                    titleWithText("รายละเอียดที่ต้องแก้ไข",
                        dataDetails?.remarkEditDocument ?? ""),
                    titleWithText("บันทึกเพิ่มเติม(Admin)",
                        dataDetails?.remarkAdmin ?? ""),
                    titleWithText(
                        "วันที่ปฏิบัติงาน",
                        MyFormatDateTime()
                            .formatDateDisplay(dataDetails?.workdate ?? "")),
                    titleWithText(
                        "พนักงานขับรถ", dataDetails?.driverName ?? ""),
                    titleWithText(
                        "ประเภทเที่ยววิ่ง", dataDetails?.workType ?? ""),
                    titleWithText(
                        "บุ๊คกิ้ง(ตู้เปล่า)", dataDetails?.booking2 ?? ""),
                    titleWithText("ต้นทาง-ปลายทาง",
                        "${dataDetails?.routeCode} (${dataDetails?.route})"),
                    titleWithText("ลูกค้า", "${dataDetails?.customerName}"),
                    titleWithText(
                        "ประเภทสินค้าที่บรรทุก", "${dataDetails?.product}"),
                    titleWithText(
                        "บุ๊คกิ้ง(ตู้หนัก)", "${dataDetails?.booking}"),
                    titleWithText("Quantity/จำนวนสินค้า/น้ำหนักยางที่บรรทุก",
                        "${dataDetails?.quantity ?? ""}"),
                    titleWithText(
                        "QuantityUOM/หน่วย", "${dataDetails?.quantityUomUnit}"),
                    titleWithText("เลขที่ DO", itemsDo),
                    titleWithText("เช็คอิน",
                        "${MyFormatDateTime().formatDateTimeDisplay(dataDetails?.checkInDate ?? "")}"),
                    titleWithText("เช็คเอาท์",
                        "${MyFormatDateTime().formatDateTimeDisplay(dataDetails?.checkOutDate ?? "")}"),
                    titleWithText("วันที่ทำงาน",
                        "${MyFormatDateTime().formatDateTimeDisplay(dataDetails?.shipmentStartDate ?? "")}"),
                    titleWithText("วันที่เสร็จงาน",
                        "${MyFormatDateTime().formatDateTimeDisplay(dataDetails?.shipmentEndDate ?? "")}"),
                    titleWithText("วันที่ลากตู้เข้า",
                        "${MyFormatDateTime().formatDateTimeDisplay(dataDetails?.containerInDate ?? "")}"),
                    titleWithText("วันที่ลากตู้ออก",
                        "${MyFormatDateTime().formatDateTimeDisplay(dataDetails?.containerOutDate ?? "")}"),
                    titleWithText("สภาพเลขไมล์", "${dataDetails?.mileError}"),
                    if (dataDetails?.mileErrorCode == "N")
                      titleWithText("เลขไมล์ก่อน", "${dataDetails?.mile1}"),
                    if (dataDetails?.mileErrorCode == "N")
                      titleWithText("เลขไมล์หลัง", "${dataDetails?.mile2}"),
                    if (dataDetails?.mileErrorCode != "N")
                      titleWithText("ระยะทาง(กรณีไมล์เสีย)",
                          "${dataDetails?.distanctKm}"),
                    Text("บันทึกค่าใช้จ่ายเพิ่มเติม",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    rateGroup(
                        context,
                        "${dataDetails?.addMoneyRateGroup1 ?? ""}",
                        "${dataDetails?.delMoneyRateGroup1 ?? ""}",
                        rateGroup1,
                        "${dataDetails?.addMoneyRateGroup2 ?? ""}",
                        "${dataDetails?.delMoneyRateGroup2 ?? ""}",
                        rateGroup2),
                    Text("แบบประเมิน",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    assessment(evaluations, dataDetails?.remarkDriver ?? ""),
                    Text("ไฟล์แนบ",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    attachmentsWidget(context, attachments)
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
