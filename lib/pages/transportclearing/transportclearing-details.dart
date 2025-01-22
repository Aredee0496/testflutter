import 'package:flutter/material.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/models/app/transportclearing/res-transportclearing-getbyid-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-attachment-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-evaluations-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-expenses-rategroup1-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-shipments-model.dart';
import 'package:starlightserviceapp/pages/transportclearing/widget/transportclearing-expenses.dart';
import 'package:starlightserviceapp/services/app/transportclearing-service.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/utils/format-datatime.dart';
import 'package:starlightserviceapp/utils/input-data-widget.dart';
import 'package:starlightserviceapp/widgets/appbar.dart';

class TransportClearingDetailsPage extends StatefulWidget {
  final String id;
  final String jobStatus;

  const TransportClearingDetailsPage(
      {super.key, required this.id, required this.jobStatus});

  @override
  State<TransportClearingDetailsPage> createState() =>
      _TransportClearingDetailsPageState();
}

class _TransportClearingDetailsPageState
    extends State<TransportClearingDetailsPage> {
  TransportClearingService transportClearingService =
      TransportClearingService();
  List<TrWorklistExpensesRateGroup1Row> rateGroup1 = [];
  List<TrWorklistExpensesRateGroup1Row> rateGroup2 = [];
  List<TrWorklistEvaluationsRow> evaluations = [];
  List<TrWorklistShipmentsRow> shipment = [];
  String itemsDo = "";
  List<TrWorklistAttachmentRow> attachments = [];
  String checkStatus = "";

  TrWorklistsInTrcRow? dataDetails;
  List<TrWorklistExpensesRow> trWorklistExpenses = [];

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
      ResTransportClearingGetByIdModel data =
          await transportClearingService.getById(context, id);
      if (data.data.trWorklists.rows.isNotEmpty) {
        final tempTrWorklists = data.data.trWorklists.rows[0];
        final tempTrWorklistExpenses = data.data.trWorklistExpenses;
        setState(() {
          dataDetails = tempTrWorklists;
          trWorklistExpenses = tempTrWorklistExpenses.rows;
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
        title: "รายการเบิกค่าใช้จ่ายการเดินทาง (รายละเอียด)",
        listWidget: [],
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
                    titleWithText(
                        "วันที่ปฏิบัติงาน",
                        MyFormatDateTime()
                            .formatDateDisplay(dataDetails?.workdate ?? "")),
                    titleWithText(
                        "พนักงานขับรถ", dataDetails?.driverName ?? ""),
                    titleWithText(
                        "ทะเบียนรถเทรลเลอร์", "${dataDetails?.licenseNo}"),
                    titleWithText("ต้นทาง-ปลายทาง",
                        "${dataDetails?.routeCode} (${dataDetails?.route})"),
                    Divider(),
                    titleWithText("รอบวันที่โอน",
                        "${MyFormatDateTime().formatDateDisplay(dataDetails?.transferDate ?? "")}"),
                    titleWithText("รอบวันที่ Clear Transection",
                        "${MyFormatDateTime().formatDateDisplay(dataDetails?.clearTransactionDate ?? "")}"),
                    Divider(),
                    titleWithText("รวม เบี้ยเลี้ยงอื่นๆ+เบี้ยเลี้ยง(SAP)",
                        "${dataDetails?.sumALLGroup1}"),
                    titleWithText("รวม น้ำมันอื่นๆ+น้ำมัน(SAP)",
                        "${dataDetails?.sumALLGroup2}"),
                    Divider(),
                    titleWithText("รวม น้ำมันอื่นๆ",
                        "${dataDetails?.totalExpenseRateGroup1}"),
                    titleWithText("รวม เบี้ยเลี้ยงอื่นๆ",
                        "${dataDetails?.totalExpenseRateGroup2}"),
                    Divider(),
                    titleWithText("ค่าเบี้ยเลี้ยง(SAP)",
                        "${dataDetails?.driverAllowanceSAP ?? ""}"),
                    titleWithText(
                        "ค่าน้ำมัน(SAP)", "${dataDetails?.fuelSumSAP ?? ""}"),
                    Divider(),
                    Text("บันทึกค่าใช้จ่ายเพิ่มเติม",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    expensesTransportClearing(context, trWorklistExpenses),
                    titleWithText("รายการบวกเพิ่มเติม (เบี้ยเลี้ยง)",
                        "${dataDetails?.addMoneyRateGroup1 ?? ""}"),
                    titleWithText("รายการหักเพิ่มเติม (เบี้ยเลี้ยง)",
                        "${dataDetails?.delMoneyRateGroup1 ?? ""}"),
                    titleWithText("รายการบวกเพิ่มเติม (น้ำมัน)",
                        "${dataDetails?.addMoneyRateGroup2 ?? ""}"),
                    titleWithText("รายการหักเพิ่มเติม (น้ำมัน)",
                        "${dataDetails?.delMoneyRateGroup2 ?? ""}"),
                    titleWithText("บันทึกเพิ่มเติม(Admin)",
                        "${dataDetails?.remarkAdmin}"),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
