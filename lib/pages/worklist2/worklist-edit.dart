import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/models/app/dropdown-items-model.dart';
import 'package:starlightserviceapp/models/app/masterdata/mstemplate-checklists-model.dart';
import 'package:starlightserviceapp/models/app/res-check-stastus-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trsap-shipment-outbounds-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-attachment-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-evaluations-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-expenses-rategroup1-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-shipments-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklists-model.dart';
import 'package:starlightserviceapp/models/app/worklist/worklist-details-model.dart';
import 'package:starlightserviceapp/pages/worklist/widget/attachments.dart';
import 'package:starlightserviceapp/services/app/worklist-service.dart';
import 'package:starlightserviceapp/utils/button-style.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/utils/format-datatime.dart';
import 'package:starlightserviceapp/utils/input-data-widget.dart';
import 'package:starlightserviceapp/utils/input-file-worklist.dart';
import 'package:starlightserviceapp/widgets/appbar.dart';
import 'package:starlightserviceapp/widgets/dialog-confirm.dart';
import 'package:starlightserviceapp/widgets/input/mydatepicker.dart';
import 'package:starlightserviceapp/widgets/input/mydropdown.dart';
import 'package:starlightserviceapp/widgets/input/mytextfield.dart';
import 'package:starlightserviceapp/widgets/input/mytimepicker.dart';

class WorklistEditPage extends StatefulWidget {
  final DataWorklistDetails fromDataWorklistDetails;
  const WorklistEditPage({
    super.key,
    required this.fromDataWorklistDetails,
  });

  @override
  State<WorklistEditPage> createState() => _WorklistEditPageState();
}

class _WorklistEditPageState extends State<WorklistEditPage> {
  WorklistService worklistService = WorklistService();
  TextEditingController jobStatus = TextEditingController();
  //start controller
  DropdownItemsModel? _selectedJobStatus;
  DropdownItemsModel? _selectedLicenseNos;
  DropdownItemsModel? _selectedLicenseNo2s;
  DropdownItemsModel? _selectedZData;
  DropdownItemsModel? _selectedQuantityUOMs;
  DropdownItemsModel? _selectedMileError;
  DropdownItemsModel? _selectedContainerType;

  TextEditingController containerNo = TextEditingController();
  TextEditingController containerNo2 = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController mile1 = TextEditingController();
  TextEditingController mile2 = TextEditingController();
  TextEditingController distanctKM = TextEditingController();
  TextEditingController remarkDriver = TextEditingController();

  TextEditingController checkInDate = TextEditingController();
  TextEditingController checkOutDate = TextEditingController();
  TextEditingController shipmentStartDate = TextEditingController();
  TextEditingController shipmentEndDate = TextEditingController();
  TextEditingController containerInDate = TextEditingController();
  TextEditingController containerOutDate = TextEditingController();

  //end controller

  List<TrsapShipmentOutboundsRow> itemsDropdownShipment = [];

  List<TrsapShipmentOutboundsRow?> selectedItemsShipment = [];

  List<String> _selectedValues = [];

  //start items

  List<TrWorklistAttachmentRow> itemsFile = [];

  TrWorklistsRow? data;
  List<TrWorklistExpensesRateGroup1Row> rateGroup1 = [];
  List<TrWorklistExpensesRateGroup1Row> rateGroup2 = [];
  List<TrWorklistEvaluationsRow> evaluations = [];
  List<TrWorklistShipmentsRow> shipment = [];
  String itemsDo = "";
  List<TrWorklistAttachmentRow> attachments = [];
  List<DropdownItemsModel> itemsDropdownJobstatus = [];
  List<DropdownItemsModel> itemsDropdownLicenseNos = [];
  List<DropdownItemsModel> itemsDropdownLicenseNo2s = [];
  List<DropdownItemsModel> itemsDropdownZData = [];
  List<DropdownItemsModel> itemsDropdownQuantityUOMs = [];
  List<MsTemplateChecklistsRow> itemsTemplateChecklists = [];
  List<DropdownItemsModel> itemsDropdownMileError = [
    DropdownItemsModel(value: "Y", text: "ไมล์ขาด"),
    DropdownItemsModel(value: "N", text: "ปกติ")
  ];
  List<DropdownItemsModel> itemsDropdownContainerType = [
    DropdownItemsModel(value: "1", text: "ตู้เปล่า"),
    DropdownItemsModel(value: "2", text: "ตีเปล่า")
  ];

  String worklistId = "";
  bool requiredField = false;

  //end items

  void _selectAllNormal() {
    setState(() {
      for (int i = 0; i < _selectedValues.length; i++) {
        _selectedValues[i] = "Y";
      }
    });
  }

  void addDropdown() {
    setState(() {
      selectedItemsShipment.add(null);
    });
  }

  void removeDropdown(int index) {
    setState(() {
      selectedItemsShipment.removeAt(index);
    });
  }

  onSelectedDate(value) {
    setState(() {
      checkInDate.text = value ?? "";
    });
  }

  fetchData(DataWorklistDetails temp, bool isFile) {
    setState(() {
      if (isFile) {
        attachments = temp.trWorklistAttatchments.rows;
        itemsFile = [];
        for (var i = 0; i < attachments.length; i++) {
          itemsFile.add(attachments[i]);
        }
      } else {
        data = temp.trWorklists.rows[0];
        worklistId = data!.worklistId ?? "";
        rateGroup1 = temp.trWorklistExpensesRateGroup1.rows;
        rateGroup2 = temp.trWorklistExpensesRateGroup2.rows;
        evaluations = temp.trWorklistEvaluations.rows;
        shipment = temp.trWorklistShipments.rows;
        attachments = temp.trWorklistAttatchments.rows;

        itemsDropdownShipment = temp.trsapShipmentOutbounds.rows;
        itemsTemplateChecklists = temp.msTemplateChecklists.rows;

        _selectedValues = [];

        if (evaluations.isNotEmpty) {
          for (var i = 0; i < evaluations.length; i++) {
            _selectedValues.add(evaluations[i].result);
          }
        } else if (itemsTemplateChecklists.isNotEmpty) {
          for (var i = 0; i < itemsTemplateChecklists.length; i++) {
            _selectedValues.add("");
          }
        }

        //items
        final tempItems = temp;
        itemsDropdownJobstatus = tempItems.msJobStatuss.rows.isNotEmpty
            ? tempItems.msJobStatuss.rows
                .map((e) => DropdownItemsModel(
                    value: e.jobStatusCode ?? "", text: e.description))
                .toList()
            : [];
        itemsDropdownLicenseNos = tempItems.msLicenseNos.rows.isNotEmpty
            ? tempItems.msLicenseNos.rows
                .map((e) => DropdownItemsModel(
                    value: e.licenseNoId ?? "", text: e.licenseNo ?? ""))
                .toList()
            : [];

        itemsDropdownLicenseNo2s = tempItems.msLicenseNo2S.rows.isNotEmpty
            ? tempItems.msLicenseNo2S.rows
                .map((e) => DropdownItemsModel(
                    value: e.licenseNo2Id ?? "", text: e.licenseNo2 ?? ""))
                .toList()
            : [];

        itemsDropdownZData = tempItems.mszDatas.rows.isNotEmpty
            ? tempItems.mszDatas.rows
                .map((e) => DropdownItemsModel(
                    value: e.zDataId ?? "", text: e.description ?? ""))
                .toList()
            : [];
        itemsDropdownQuantityUOMs = tempItems.msQuantityUoMs.rows.isNotEmpty
            ? tempItems.msQuantityUoMs.rows
                .map((e) => DropdownItemsModel(
                    value: e.quantityID ?? "", text: e.unit ?? ""))
                .toList()
            : [];

        //init data
        final tempData = temp.trWorklists.rows[0];
        try {
          if (itemsDropdownJobstatus.isNotEmpty) {
            if (tempData.jobStatus == "9") {
              _selectedJobStatus = itemsDropdownJobstatus
                  .firstWhere((item) => item.value == "3", orElse: null);
            } else {
              _selectedJobStatus = itemsDropdownJobstatus.firstWhere(
                  (item) => item.value == tempData.jobStatus,
                  orElse: null);
            }

            if (_selectedJobStatus?.value == "3") {
              requiredField = true;
            }
          }
        } catch (e) {
          print("$e");
        }
        try {
          if (itemsDropdownLicenseNos.isNotEmpty) {
            _selectedLicenseNos = itemsDropdownLicenseNos.firstWhere(
                (item) => item.value == tempData.licenseNoId,
                orElse: null);
          }
        } catch (e) {
          print("$e");
        }
        try {
          if (itemsDropdownLicenseNo2s.isNotEmpty) {
            _selectedLicenseNo2s = itemsDropdownLicenseNo2s.firstWhere(
                (item) => item.value == tempData.licenseNo2Id,
                orElse: null);
          }
        } catch (e) {
          print("$e");
        }
        try {
          if (itemsDropdownZData.isNotEmpty) {
            _selectedZData = itemsDropdownZData.firstWhere(
                (item) => item.value == tempData.zDataId,
                orElse: null);
          }
        } catch (e) {
          print("$e");
        }
        try {
          if (itemsDropdownQuantityUOMs.isNotEmpty) {
            _selectedQuantityUOMs = itemsDropdownQuantityUOMs.firstWhere(
                (item) => item.value == tempData.quantityId,
                orElse: null);
          }
        } catch (e) {
          print("$e");
        }
        try {
          if (itemsDropdownContainerType.isNotEmpty) {
            _selectedContainerType = itemsDropdownContainerType.firstWhere(
                (item) => item.value == tempData.containerNoTypeCode,
                orElse: null);
          }
        } catch (e) {
          print("$e");
        }

        try {
          if (itemsDropdownMileError.isNotEmpty) {
            _selectedMileError = itemsDropdownMileError.firstWhere(
                (item) => item.value == tempData.mileErrorCode,
                orElse: null);
          }
        } catch (e) {
          print("$e");
        }

        final tempShipment = itemsDropdownShipment.where((item) {
          return shipment.any((e) =>
              e.deliveryOrderNo == item.deliveryOrderNo &&
              e.shipmentNo == item.shipmentNo);
        }).toList();
        selectedItemsShipment = [];
        for (var i = 0; i < tempShipment.length; i++) {
          selectedItemsShipment.add(tempShipment[i]);
        }

        itemsFile = [];
        for (var i = 0; i < attachments.length; i++) {
          itemsFile.add(attachments[i]);
        }

        //controller
        containerNo.text = tempData.containerNo ?? "";
        containerNo2.text = tempData.containerNo2 ?? "";
        quantity.text = tempData.quantity == null ? "" : "${tempData.quantity}";
        mile1.text = tempData.mile1 == null ? "" : "${tempData.mile1}";
        mile2.text = tempData.mile2 == null ? "" : "${tempData.mile2}";
        distanctKM.text =
            tempData.distanctKm == null ? "" : "${tempData.distanctKm}";
        remarkDriver.text = tempData.remarkDriver ?? "";
        checkInDate.text = MyFormatDateTime()
            .convertToCustomFormat(tempData.checkInDate ?? "");
        checkOutDate.text = MyFormatDateTime()
            .convertToCustomFormat(tempData.checkOutDate ?? "");
        shipmentStartDate.text = MyFormatDateTime()
            .convertToCustomFormat(tempData.shipmentStartDate ?? "");
        shipmentEndDate.text = MyFormatDateTime()
            .convertToCustomFormat(tempData.shipmentEndDate ?? "");
        containerInDate.text = MyFormatDateTime()
            .convertToCustomFormat(tempData.containerInDate ?? "");
        containerOutDate.text = MyFormatDateTime()
            .convertToCustomFormat(tempData.containerOutDate ?? "");
      }
    });
  }

  getDataById(String id, bool isFile) async {
    try {
      DialogHelper.showLoadingWithText(context, "loading...");
      WorklistDetailsModel data = await worklistService.getById(context, id);
      if (data.data.trWorklists.rows.isNotEmpty) {
        final temp = data.data;
        setState(() {
          fetchData(temp, isFile);
        });
      }

      DialogHelper.hideLoading(context);
    } catch (e) {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, e.toString());
    }
  }

  checkRequire() {
    List<String> res = [];

    if (_selectedJobStatus == null) {
      res.add("สถานะ");
    } else {
      // ถ้า status เป็น ปิดงาน

      if (containerNo.text != "") {
        if (containerNo.text.length != 11) {
          res.add("หมายเลขตู้คอนเทนเนอร์ (ตู้หนัก) ต้องครบ 11 หลัก");
        }
      }
      if (containerNo2.text != "") {
        if (containerNo2.text.length != 11) {
          res.add("หมายเลขตู้คอนเทนเนอร์ (ตู้เปล่า) ต้องครบ 11 หลัก");
        }
      }
      if (_selectedJobStatus!.value == "3") {
        if (_selectedLicenseNos == null) {
          res.add("ทะเบียนรถเทรลเลอร์");
        }
        if (_selectedLicenseNo2s == null) {
          res.add("ทะเบียนหางเทรลเลอร์");
        }

        if (_selectedZData == null) {
          res.add("ประเภทหาง");
        }

        if (checkInDate.text == "") {
          res.add("เช็คอิน");
        }
        if (checkOutDate.text == "") {
          res.add("เช็คเอาท์");
        }

        if (checkInDate.text != "" && checkOutDate.text != "") {
          if (!MyFormatDateTime()
              .compareDate(checkInDate.text, checkOutDate.text)) {
            res.add("เช็คอิน ต้องน้อยกว่า เช็คเอาท์");
          }
        }

        if (shipmentStartDate.text == "") {
          res.add("วันที่ทำงาน");
        }
        if (shipmentEndDate.text == "") {
          res.add("วันที่เสร็จงาน");
        }

        if (shipmentStartDate.text != "" && shipmentEndDate.text != "") {
          if (!MyFormatDateTime()
              .compareDate(shipmentStartDate.text, shipmentEndDate.text)) {
            res.add("วันที่ทำงาน ต้องน้อยกว่า วันที่เสร็จงาน");
          }
        }

        // if (containerInDate.text == "") {
        //   res.add("วันที่ลากตู้เข้า");
        // }
        // if (containerOutDate.text == "") {
        //   res.add("วันที่ลากตู้ออก");
        // }

        if (containerInDate.text != "" && containerOutDate.text != "") {
          if (!MyFormatDateTime()
              .compareDate(containerInDate.text, containerOutDate.text)) {
            res.add("วันที่ลากตู้เข้า ต้องน้อยกว่า วันที่ลากตู้ออก");
          }
        }

        if (_selectedMileError == null) {
          res.add("สภาพเลขไมล์");
        } else {
          if (_selectedMileError!.value == "N") {
            if (mile1.text == "") {
              res.add("เลขไมล์ก่อน");
            }
            if (mile2.text == "") {
              res.add("เลขไมล์หลัง");
            }

            if (mile1.text != "" && mile2.text != "") {
              final m1 = int.parse(mile1.text);
              final m2 = int.parse(mile2.text);
              if (m1 == 0 || m2 == 0) {
                res.add("เลขไมล์ต้องมากกว่า 0");
              }
              if (m1 < 1000000 && m2 < 1000000) {
                print("AAAAAAA2");
                if (m1 <= 998000) {
                  print("AAAAAAA3");
                  if (m1 >= m2) {
                    res.add("เลขไมล์ก่อน ต้องน้อยกว่า เลขไมล์หลัง");
                  }
                }
              } else {
                res.add("เลขไมล์ ต้องไม่เกิน 1,000,000");
              }
            }
          }
          // else {
          //   if (distanctKM.text == "") {
          //     res.add("ระยะทาง(กรณีเลขไมล์ขาด)");
          //   } else {
          //     final tempdistanctKM = int.parse(distanctKM.text);
          //     if (tempdistanctKM <= 0) {
          //       res.add("ระยะทางต้องมากกว่า 0");
          //     }
          //   }
          // }
        }

        if (_selectedValues.isNotEmpty) {
          int check = 0;
          for (var item in _selectedValues) {
            if (item == "") {
              check++;
            }
          }
          if (check > 0) {
            res.add("แบบประเมิน ไม่สมบูรณ์");
          }
        } else {
          res.add("แบบประเมิน");
        }
      } else {
        if (checkInDate.text != "" && checkOutDate.text != "") {
          if (!MyFormatDateTime()
              .compareDate(checkInDate.text, checkOutDate.text)) {
            res.add("เช็คอิน ต้องน้อยกว่า เช็คเอาท์");
          }
        }
        if (shipmentStartDate.text != "" && shipmentEndDate.text != "") {
          if (!MyFormatDateTime()
              .compareDate(shipmentStartDate.text, shipmentEndDate.text)) {
            res.add("วันที่ทำงาน ต้องน้อยกว่า วันที่เสร็จงาน");
          }
        }
        if (containerInDate.text != "" && containerOutDate.text != "") {
          if (!MyFormatDateTime()
              .compareDate(containerInDate.text, containerOutDate.text)) {
            res.add("วันที่ลากตู้เข้า ต้องน้อยกว่า วันที่ลากตู้ออก");
          }
        }
      }
    }

    return res;
  }

  checkWarningMile(_context) async {
    bool res = true;
    if (mile1.text != "" && mile2.text != "") {
      final m1 = int.parse(mile1.text);
      final m2 = int.parse(mile2.text);
      if (m1 > 998000) {
        if (m2 < m1) {
          await showDialog(
              context: _context,
              builder: (_context) {
                return dialogConfirmDelete(
                    context, "ยืนยัน?", "ไมล์หลังน้อยกว่าไมล์ก่อน");
              }).then((value) async {
            res = value ?? false;
          });
        }
      }
    }
    return res;
  }

  onUpdate() async {
    try {
      DialogHelper.showLoading(context);

      List<String> checkReq = await checkRequire();
      print("checkReq ==> $checkReq");
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
        final check = await checkWarningMile(context);
        print("checkWarningMile ==> $check");
        if (check) {
          final tempTRWorklistShipment = [];
          if (selectedItemsShipment.isNotEmpty) {
            for (final item in selectedItemsShipment) {
              if (item != null) {
                tempTRWorklistShipment.add(
                  {
                    "ShipmentNo": item.shipmentNo,
                    "TextProductDescription": item.textProductDescription ?? ""
                  },
                );
              }
            }
          }

          print("tempTRWorklistShipment ==> $tempTRWorklistShipment");

          final tempEvaluation = [];
          if (_selectedValues.isNotEmpty) {
            if (evaluations.isNotEmpty) {
              for (var i = 0; i < evaluations.length; i++) {
                final selected = _selectedValues[i];
                final dataCheck = evaluations[i];
                var tempResult = {
                  "EvalID": dataCheck.evalId,
                  "TemplateID": dataCheck.templateId,
                  "TemplateName": dataCheck.templateName,
                  "CheckListID": dataCheck.checkListId,
                  "Checklist": dataCheck.checklist,
                  "Running": dataCheck.running,
                };
                if (selected == "Y") {
                  tempResult["Option1"] = 1;
                  tempResult["Option2"] = 0;
                  tempResult["Option3"] = 0;
                } else if (selected == "N") {
                  tempResult["Option1"] = 0;
                  tempResult["Option2"] = 1;
                  tempResult["Option3"] = 0;
                } else if (selected == "C") {
                  tempResult["Option1"] = 0;
                  tempResult["Option2"] = 0;
                  tempResult["Option3"] = 1;
                }
                tempEvaluation.add(tempResult);
              }
            } else if (itemsTemplateChecklists.isNotEmpty) {
              for (var i = 0; i < itemsTemplateChecklists.length; i++) {
                final selected = _selectedValues[i];
                final dataCheck = itemsTemplateChecklists[i];
                var tempResult = {
                  "EvalID": "",
                  "TemplateID": dataCheck.templateId,
                  "TemplateName": dataCheck.templateName,
                  "CheckListID": dataCheck.checkListId,
                  "Checklist": dataCheck.checklist,
                  "Running": dataCheck.running,
                };
                if (selected == "Y") {
                  tempResult["Option1"] = 1;
                  tempResult["Option2"] = 0;
                  tempResult["Option3"] = 0;
                } else if (selected == "N") {
                  tempResult["Option1"] = 0;
                  tempResult["Option2"] = 1;
                  tempResult["Option3"] = 0;
                } else if (selected == "C") {
                  tempResult["Option1"] = 0;
                  tempResult["Option2"] = 0;
                  tempResult["Option3"] = 1;
                }
                tempEvaluation.add(tempResult);
              }
            }
          }

          print("tempEvaluation ==> $tempEvaluation");

          int m1 = 0;
          int m2 = 0;

          if (mile1.text != "" && mile2.text != "") {
            m1 = int.parse(mile1.text);
            m2 = int.parse(mile2.text);
          }

          final temp = {
            "JobStatus": _selectedJobStatus?.value,
            "JobStatusDescription": _selectedJobStatus?.text,
            "LicenseNoID": _selectedLicenseNos?.value,
            "LicenseNo": _selectedLicenseNos?.text,
            "ContainerNo": containerNo.text,
            "ContainerNo2": containerNo2.text,
            "LicenseNo2ID": _selectedLicenseNo2s?.value,
            "LicenseNo2": _selectedLicenseNo2s?.text,
            "ZDataID": _selectedZData?.value,
            "Quantity": quantity.text == "" ? null : quantity.text,
            "QuantityID": _selectedQuantityUOMs?.value,
            "QuantityUOMUnit": _selectedQuantityUOMs?.text,
            "ContainerNoTypeCode": _selectedContainerType?.value,
            "ContainerNoType": _selectedContainerType?.text,
            "CheckInDate": checkInDate.text,
            "CheckOutDate": checkOutDate.text,
            "ShipmentStartDate": shipmentStartDate.text,
            "ShipmentEndDate": shipmentEndDate.text,
            "ContainerInDate":
                containerInDate.text == "" ? null : containerInDate.text,
            "ContainerOutDate":
                containerOutDate.text == "" ? null : containerOutDate.text,
            "MileErrorCode": _selectedMileError?.value,
            "MileError": _selectedMileError?.text,
            "Mile1": m1 == 0 ? null : m1,
            "Mile2": m2 == 0 ? null : m2,
            "DistanctKM": distanctKM.text == "" || distanctKM.text == "null"
                ? null
                : distanctKM.text,
            "RemarkDriver": remarkDriver.text,
            "TRWorklistShipment": tempTRWorklistShipment,
            "Evaluation": tempEvaluation
          };
          final body = jsonEncode(temp);
          ResCheckStatusModel data =
              await worklistService.update(context, worklistId, body);
          if (data.result == "success") {
            DialogHelper.hideLoading(context);
            DialogHelper.showSuccessDialog(context, "", 2);
            FocusScope.of(context).requestFocus(new FocusNode());
          } else {
            DialogHelper.hideLoading(context);
            DialogHelper.showErrorMessageDialog(context, data.message);
          }
        }
      }
    } catch (e) {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, e.toString());
    }
  }

  @override
  void initState() {
    containerNo.text = "";
    super.initState();
    final temp = widget.fromDataWorklistDetails;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData(temp, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors().backgroundColor(),
        appBar: MyAppBar(
          title: "ใบปฏิบัติงาน (แก้ไข)",
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
                        Text(
                          "เลขที่งาน : ${data?.worklistDocumentNo ?? ""}",
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        titleWithWidget(
                            "สถานะ",
                            requiredField ? " *" : "",
                            myDropdownMenu2(
                                items: itemsDropdownJobstatus,
                                label: "",
                                enabled: true,
                                selectedItems: [],
                                initValue: _selectedJobStatus,
                                onSelected: (value) => setState(() {
                                      _selectedJobStatus = value;
                                      if (value != null) {
                                        if (value.value == "3") {
                                          requiredField = true;
                                        } else {
                                          requiredField = false;
                                        }
                                      }
                                    }))),
                        titleWithWidget(
                            "ทะเบียนรถเทรลเลอร์",
                            requiredField ? " *" : "",
                            myDropdownMenu3(
                                items: itemsDropdownLicenseNos,
                                label: "",
                                enabled: true,
                                selectedItems: [],
                                initValue: _selectedLicenseNos,
                                onSelected: (value) =>
                                    _selectedLicenseNos = value)),
                        titleWithWidget(
                            "ทะเบียนหางเทรลเลอร์",
                            requiredField ? " *" : "",
                            myDropdownMenu3(
                                items: itemsDropdownLicenseNo2s,
                                label: "",
                                enabled: true,
                                selectedItems: [],
                                initValue: _selectedLicenseNo2s,
                                onSelected: (value) =>
                                    _selectedLicenseNo2s = value)),
                        titleWithWidget(
                            "หมายเลขตู้คอนเทนเนอร์ (ตู้หนัก)",
                            "",
                            myTextField(
                                controller: containerNo,
                                label: "",
                                clear: false,
                                maxLength: 11,
                                onChanged: (value) {
                                  print(value ?? "");
                                  if (value != null) {
                                    containerNo.text = value.toUpperCase();
                                  } else {
                                    containerNo.text = "";
                                  }
                                })),
                        titleWithWidget(
                            "หมายเลขตู้คอนเทนเนอร์ (ตู้เปล่า)",
                            "",
                            myTextField(
                                controller: containerNo2,
                                label: "",
                                clear: false,
                                maxLength: 11,
                                onChanged: (value) {
                                  print(value ?? "");
                                  if (value != null) {
                                    containerNo2.text = value.toUpperCase();
                                  } else {
                                    containerNo2.text = "";
                                  }
                                })),

                        titleWithWidget(
                            "ประเภทหาง (รายละเอียด)",
                            requiredField ? " *" : "",
                            myDropdownMenu3(
                                items: itemsDropdownZData,
                                label: "",
                                enabled: true,
                                selectedItems: [],
                                initValue: _selectedZData,
                                onSelected: (value) => _selectedZData = value)),
                        titleWithWidget(
                            "Quantity/จำนวนสินค้า/น้ำหนักยางที่บรรทุก",
                            "",
                            myTextField(
                                controller: quantity,
                                label: "",
                                clear: false,
                                onChanged: (value) {
                                  print(value ?? "");
                                  quantity.text = value ?? "";
                                })),
                        titleWithWidget(
                            "QuantityUOM/หน่วย",
                            "",
                            myDropdownMenu2(
                                items: itemsDropdownQuantityUOMs,
                                label: "",
                                enabled: true,
                                selectedItems: [],
                                initValue: _selectedQuantityUOMs,
                                onSelected: (value) =>
                                    _selectedQuantityUOMs = value)),
                        titleWithWidget(
                            "ตู้เปล่า/ตีเปล่า",
                            "",
                            myDropdownMenu2(
                                items: itemsDropdownContainerType,
                                label: "",
                                enabled: true,
                                selectedItems: [],
                                initValue: _selectedContainerType,
                                onSelected: (value) =>
                                    _selectedContainerType = value)),
                        titleWithWidget(
                          "เลขที่ DO",
                          "",
                          Column(
                            children: [
                              Table(border: TableBorder.all(), columnWidths: {
                                0: const FlexColumnWidth(3),
                                1: const FlexColumnWidth(1),
                              }, children: [
                                const TableRow(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          'เลขที่ DO',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          'Action',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (selectedItemsShipment.isNotEmpty)
                                  for (int i = 0;
                                      i < selectedItemsShipment.length;
                                      i++)
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownSearch<
                                              TrsapShipmentOutboundsRow>(
                                            compareFn: (item1, item2) =>
                                                item1.deliveryOrderNo ==
                                                item2.deliveryOrderNo,
                                            popupProps: PopupProps.menu(
                                              showSearchBox: true,
                                              showSelectedItems: true,
                                              disabledItemFn: (item) =>
                                                  selectedItemsShipment.contains(
                                                      itemsDropdownShipment
                                                          .firstWhere((element) =>
                                                              element
                                                                  .deliveryOrderNo ==
                                                              item.deliveryOrderNo)),
                                              itemBuilder:
                                                  (context, item, isSelected) {
                                                bool isDisabled = selectedItemsShipment
                                                    .contains(itemsDropdownShipment
                                                        .firstWhere((element) =>
                                                            element
                                                                .deliveryOrderNo ==
                                                            item.deliveryOrderNo));
                                                return ListTile(
                                                  title: Text(
                                                    item.deliveryOrderNo,
                                                    style: TextStyle(
                                                      color: isDisabled
                                                          ? Colors.grey
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  enabled: !isDisabled,
                                                  onTap: isDisabled
                                                      ? null
                                                      : () {
                                                          setState(() {
                                                            selectedItemsShipment[
                                                                    i] =
                                                                itemsDropdownShipment.firstWhere(
                                                                    (element) =>
                                                                        element
                                                                            .deliveryOrderNo ==
                                                                        item.deliveryOrderNo);
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                );
                                              },
                                            ),
                                            items: itemsDropdownShipment,
                                            itemAsString: (item) =>
                                                item.deliveryOrderNo,
                                            selectedItem: selectedItemsShipment[
                                                        i] !=
                                                    null
                                                ? itemsDropdownShipment
                                                    .firstWhere((item) =>
                                                        item ==
                                                        selectedItemsShipment[
                                                            i])
                                                : null,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedItemsShipment[i] =
                                                    itemsDropdownShipment
                                                        .firstWhere((item) =>
                                                            item.deliveryOrderNo ==
                                                            value
                                                                ?.deliveryOrderNo);
                                              });
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () => removeDropdown(i),
                                          ),
                                        ),
                                      ],
                                    )
                              ]),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          fixedSize: WidgetStateProperty.all(
                                              Size.infinite),
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  MyColors().secondary())),
                                      onPressed: () => addDropdown(),
                                      child: const Text(
                                        "Add DO",
                                        style: TextStyle(
                                            height: 0.0,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                        titleWithWidget(
                          "เช็คอิน",
                          requiredField ? " *" : "",
                          Row(
                            children: [
                              IntrinsicWidth(
                                child: myDatePicker2(
                                    controller: checkInDate,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          checkInDate.text = value ?? "";
                                        }),
                                    context: context),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              IntrinsicWidth(
                                child: myTimePicker(
                                    controller: checkInDate,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          print("myTimePicker $value");
                                          checkInDate.text = value ?? "";
                                        }),
                                    context: context),
                              )
                            ],
                          ),
                        ),
                        titleWithWidget(
                          "เช็คเอาท์",
                          requiredField ? " *" : "",
                          Row(
                            children: [
                              IntrinsicWidth(
                                child: myDatePicker2(
                                    controller: checkOutDate,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          checkOutDate.text = value ?? "";
                                        }),
                                    context: context),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              IntrinsicWidth(
                                child: myTimePicker(
                                    controller: checkOutDate,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          print("myTimePicker $value");
                                          checkOutDate.text = value ?? "";
                                        }),
                                    context: context),
                              )
                            ],
                          ),
                        ),
                        titleWithWidget(
                          "วันที่ทำงาน",
                          requiredField ? " *" : "",
                          Row(
                            children: [
                              IntrinsicWidth(
                                child: myDatePicker2(
                                    controller: shipmentStartDate,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          shipmentStartDate.text = value ?? "";
                                        }),
                                    context: context),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              IntrinsicWidth(
                                child: myTimePicker(
                                    controller: shipmentStartDate,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          print("myTimePicker $value");
                                          shipmentStartDate.text = value ?? "";
                                        }),
                                    context: context),
                              )
                            ],
                          ),
                        ),
                        titleWithWidget(
                          "วันที่เสร็จงาน",
                          requiredField ? " *" : "",
                          Row(
                            children: [
                              IntrinsicWidth(
                                child: myDatePicker2(
                                    controller: shipmentEndDate,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          shipmentEndDate.text = value ?? "";
                                        }),
                                    context: context),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              IntrinsicWidth(
                                child: myTimePicker(
                                    controller: shipmentEndDate,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          print("myTimePicker $value");
                                          shipmentEndDate.text = value ?? "";
                                        }),
                                    context: context),
                              )
                            ],
                          ),
                        ),
                        titleWithWidget(
                          "วันที่ลากตู้เข้า",
                          requiredField ? "" : "",
                          Row(
                            children: [
                              IntrinsicWidth(
                                child: myDatePicker2(
                                    controller: containerInDate,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          containerInDate.text = value ?? "";
                                        }),
                                    context: context),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              IntrinsicWidth(
                                child: myTimePicker(
                                    controller: containerInDate,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          print("myTimePicker $value");
                                          containerInDate.text = value ?? "";
                                        }),
                                    context: context),
                              )
                            ],
                          ),
                        ),
                        titleWithWidget(
                          "วันที่ลากตู้ออก",
                          requiredField ? "" : "",
                          Row(
                            children: [
                              IntrinsicWidth(
                                child: myDatePicker2(
                                    controller: containerOutDate,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          containerOutDate.text = value ?? "";
                                        }),
                                    context: context),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              IntrinsicWidth(
                                child: myTimePicker(
                                    controller: containerOutDate,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          print("myTimePicker $value");
                                          containerOutDate.text = value ?? "";
                                        }),
                                    context: context),
                              )
                            ],
                          ),
                        ),
                        titleWithWidget(
                            "สภาพเลขไมล์",
                            requiredField ? " *" : "",
                            myDropdownMenu2(
                                items: itemsDropdownMileError,
                                label: "",
                                enabled: true,
                                selectedItems: [],
                                initValue: _selectedMileError,
                                onSelected: (value) => setState(() {
                                      _selectedMileError = value;
                                      print(
                                          "_selectedMileError => $_selectedMileError");
                                      if (value!.value == "N") {
                                        mile1.text = "";
                                        mile2.text = "";
                                      }
                                      //  else {
                                      //   distanctKM.text = "0";
                                      // }
                                    }))),
                        if (_selectedMileError != null)
                          if (_selectedMileError!.value == "N")
                            titleWithWidget(
                                "เลขไมล์ก่อน",
                                requiredField ? " *" : "",
                                myTextField(
                                    controller: mile1,
                                    label: "",
                                    clear: false,
                                    textInputType: TextInputType.number,
                                    onChanged: (value) {
                                      print(value ?? "");
                                      mile1.text = value ?? "";
                                    })),
                        if (_selectedMileError != null)
                          if (_selectedMileError!.value == "N")
                            titleWithWidget(
                                "เลขไมล์หลัง",
                                requiredField ? " *" : "",
                                myTextField(
                                    controller: mile2,
                                    label: "",
                                    clear: false,
                                    textInputType: TextInputType.number,
                                    onChanged: (value) {
                                      print(value ?? "");
                                      mile2.text = value ?? "";
                                    })),
                        // if (_selectedMileError != null)
                        //   if (_selectedMileError!.value != "N")
                        //     titleWithWidget(
                        //         "ระยะทาง(กรณีเลขไมล์ขาด)",
                        //         requiredField ? " *" : "",
                        //         myTextField(
                        //             controller: distanctKM,
                        //             label: "",
                        //             clear: false,
                        //             textInputType: TextInputType.number,
                        //             onChanged: (value) {
                        //               print(value ?? "");
                        //               distanctKM.text = value ?? "";
                        //             })),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text("แบบประเมิน",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  Text(requiredField ? " *" : "",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 18)),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _selectAllNormal,
                              child: const Text("ปกติทั้งหมด"),
                            ),
                          ],
                        ),
                        Table(
                          border: TableBorder.all(),
                          columnWidths: {
                            0: const FlexColumnWidth(3),
                            1: const FlexColumnWidth(1),
                            2: const FlexColumnWidth(1),
                            3: const FlexColumnWidth(1),
                          },
                          children: [
                            _buildTableHeader(),
                            if (evaluations.isNotEmpty)
                              ...evaluations.asMap().entries.map((entry) {
                                int index = entry.key;

                                return _buildTableRow(
                                    entry.value.checklist, index);
                              })
                            else if (itemsTemplateChecklists.isNotEmpty)
                              ...itemsTemplateChecklists
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int index = entry.key;

                                return _buildTableRow(
                                    entry.value.checklist ?? "", index);
                              })
                          ],
                        ),
                        titleWithWidget(
                            "การแก้ไขกรณีไม่ปกติ/บันทึกเพิ่มเติม",
                            "",
                            myTextField(
                                controller: remarkDriver,
                                label: "",
                                clear: false,
                                onChanged: (value) {
                                  print(value ?? "");
                                  remarkDriver.text = value ?? "";
                                })),
                        titleWithWidget(
                            "ไฟล์แนบ",
                            "",
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: MyColors().primary()),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                                style:
                                                    MyStyle().elevatedButton(),
                                                onPressed: () async {
                                                  final finish =
                                                      await selectFileWorklist(
                                                    context,
                                                    worklistId,
                                                    itemsFile,
                                                  );
                                                  if (finish == true) {
                                                    getDataById(
                                                        worklistId, true);
                                                  }
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
                                                style:
                                                    MyStyle().elevatedButton(),
                                                onPressed: () async {
                                                  final finish =
                                                      await takePhotoWorklist(
                                                          context,
                                                          worklistId,
                                                          itemsFile);
                                                  if (finish == true) {
                                                    getDataById(
                                                        worklistId, true);
                                                  }
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
                        attachmentEditsWidget(
                          context,
                          itemsFile,
                          onReload: () => getDataById(worklistId, true),
                        )
                      ])),
            ),
          ),
        ));
  }

  TableRow _buildTableHeader() {
    return const TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: Text("หัวข้อประเด็น")),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: Text("ปกติ")),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: Text("ไม่ปกติ")),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: Text("ไม่ตรวจ")),
        ),
      ],
    );
  }

  TableRow _buildTableRow(String title, int rowIndex, {bool isHeader = false}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Center(
              child: Text(
            title.trim(),
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Center(
            child: Radio(
              value: "Y",
              groupValue: _selectedValues[rowIndex],
              onChanged: (value) {
                setState(() {
                  _selectedValues[rowIndex] = value ?? "";
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Center(
            child: Radio(
              value: "N",
              groupValue: _selectedValues[rowIndex],
              onChanged: (value) {
                setState(() {
                  _selectedValues[rowIndex] = value ?? "";
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Center(
            child: Radio(
              value: "C",
              groupValue: _selectedValues[rowIndex],
              onChanged: (value) {
                setState(() {
                  _selectedValues[rowIndex] = value ?? "";
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
