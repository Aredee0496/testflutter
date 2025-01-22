import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/models/app/dropdown-items-model.dart';
import 'package:starlightserviceapp/models/app/res-check-stastus-model.dart';
import 'package:starlightserviceapp/models/app/tank-tank/res-tank-tank-details-model.dart';
import 'package:starlightserviceapp/pages/tank-tank/widget/attachmentsTank.dart';
import 'package:starlightserviceapp/pages/tank-tank/widget/liststafftank.dart';
import 'package:starlightserviceapp/services/app/tank-tank-service.dart';
import 'package:starlightserviceapp/utils/button-style.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/utils/format-datatime.dart';
import 'package:starlightserviceapp/utils/input-data-widget.dart';
import 'package:starlightserviceapp/utils/input-file-tank.dart';
import 'package:starlightserviceapp/widgets/appbar.dart';
import 'package:starlightserviceapp/widgets/input/mydatepicker.dart';
import 'package:starlightserviceapp/widgets/input/mydropdown.dart';
import 'package:starlightserviceapp/widgets/input/mytextfield.dart';
import 'package:starlightserviceapp/widgets/input/mytimepicker.dart';

class TankTankEditPage extends StatefulWidget {
  final TankTankDetailsData fromDataTankTankDetails;
  const TankTankEditPage({
    super.key,
    required this.fromDataTankTankDetails,
  });

  @override
  State<TankTankEditPage> createState() => _TankTankEditPageState();
}

class _TankTankEditPageState extends State<TankTankEditPage> {
  //start controller
  DropdownItemsModel? _selectedJobStatus;
  DropdownItemsModel? _selectedTankNo;
  DropdownItemsModel? _selectedTankType;
  DropdownItemsModel? _selectedCleanType;

  TextEditingController workDateTime = TextEditingController();
  TextEditingController acceptWorkDateTime = TextEditingController();
  TextEditingController closeWorkDateTime = TextEditingController();

  TextEditingController tankNo = TextEditingController();
  TextEditingController tankType = TextEditingController();
  TextEditingController cleanType = TextEditingController();
  TextEditingController driverName = TextEditingController();
  TextEditingController workDate = TextEditingController();

  List<TrTankManagementAttatchmentsRow> itemsFile = [];

  TrTankManagementsRow? data;
  List<TrTankManagementDetailsRow> dataStaff = [];
  List<MsStaffTanksRow> allStaff = [];
  List<MsTankTypesRow> msTankTypes = [];

  List<TrTankManagementAttatchmentsRow> attachments = [];
  List<DropdownItemsModel> itemsDropdownJobstatus = [];
  List<DropdownItemsModel> itemsDropdownTankNos = [];
  List<DropdownItemsModel> itemsDropdownTankTypes = [];
  List<DropdownItemsModel> itemsDropdownCleanTypes = [];

  String tankManagementId = "";
  TankTankService tankService = TankTankService();

  bool requiredField = false;

  //end items

  fetchData(TankTankDetailsData temp, bool isFile) {
    setState(() {
      if (isFile) {
        attachments = temp.trTankManagementAttatchments.rows;
        itemsFile = [];
        for (var i = 0; i < attachments.length; i++) {
          itemsFile.add(attachments[i]);
        }
      } else {
        data = temp.trTankManagements.rows[0];
        dataStaff = temp.trTankManagementDetails.rows;
        allStaff = temp.msStaffTanks.rows;
        tankManagementId = data!.tankManagementId ?? "";
        attachments = temp.trTankManagementAttatchments.rows;

        //items
        final tempItems = temp;
        itemsDropdownJobstatus = tempItems.msJobStatuss.rows.isNotEmpty
            ? tempItems.msJobStatuss.rows
                .map((e) => DropdownItemsModel(
                    value: e.jobStatusCode, text: e.description))
                .toList()
            : [];

        itemsDropdownTankNos = tempItems.msTanks.rows.isNotEmpty
            ? tempItems.msTanks.rows
                .map((e) => DropdownItemsModel(value: e.tankNo, text: e.tankNo))
                .toList()
            : [];

        itemsDropdownTankTypes = tempItems.msTankTypes.rows.isNotEmpty
            ? tempItems.msTankTypes.rows
                .map((e) =>
                    DropdownItemsModel(value: e.tankType, text: e.tankType))
                .toList()
            : [];

        //init data
        final tempData = data;
        try {
          if (itemsDropdownJobstatus.isNotEmpty) {
            _selectedJobStatus = itemsDropdownJobstatus.firstWhere(
                (item) => item.value == tempData?.workStatusCode,
                orElse: null);
          }
        } catch (e) {
          print("$e");
        }
        itemsFile = [];
        for (var i = 0; i < attachments.length; i++) {
          itemsFile.add(attachments[i]);
        }

        try {
          if (itemsDropdownTankNos.isNotEmpty) {
            _selectedTankNo = itemsDropdownTankNos.firstWhere(
                (item) => item.value == tempData?.tankNo,
                orElse: null);
          }
        } catch (e) {
          print("$e");
        }
        try {
          if (itemsDropdownTankTypes.isNotEmpty) {
            _selectedTankType = itemsDropdownTankTypes.firstWhere(
                (item) => item.value == tempData?.tankType,
                orElse: null);

            if (_selectedTankType != null) {
              if (_selectedTankType!.value != "") {
                msTankTypes = tempItems.msTankTypes.rows;
                final msCleanTypes = msTankTypes.firstWhere(
                    (item) => item.tankType == _selectedTankType!.value);
                itemsDropdownCleanTypes = msCleanTypes.msCleanTypes.isNotEmpty
                    ? msCleanTypes.msCleanTypes
                        .map((e) => DropdownItemsModel(
                            value: e.cleanTypeId, text: e.cleanType))
                        .toList()
                    : [];

                if (itemsDropdownCleanTypes.isNotEmpty) {
                  _selectedCleanType = itemsDropdownCleanTypes.firstWhere(
                      (item) => item.value == tempData?.cleanTypeID,
                      orElse: null);
                }
              }
            }
          }
        } catch (e) {
          print("$e");
        }

        //controller
        workDateTime.text = MyFormatDateTime().convertToCustomFormat(
            "${tempData?.workDate ?? ""}T${tempData?.workTime ?? ""}:00");
        acceptWorkDateTime.text = tempData?.closeWorkDate != null
            ? MyFormatDateTime().convertToCustomFormat(
                "${tempData?.acceptWorkDate ?? ""}T${tempData?.acceptWorkTime ?? ""}:00")
            : "";
        closeWorkDateTime.text = tempData?.closeWorkDate != null
            ? MyFormatDateTime().convertToCustomFormat(
                "${tempData?.closeWorkDate ?? ""}T${tempData?.closeWorkTime ?? ""}:00")
            : "";

        tankNo.text = tempData?.tankNo ?? "";
        tankType.text = tempData?.tankType ?? "";
        cleanType.text = tempData?.cleanType ?? "";
        driverName.text = tempData?.driverName ?? "";
        workDate.text =
            "${MyFormatDateTime().formatDateDisplay(tempData?.workDate ?? "")} ${tempData?.workTime}";
      }
    });
  }

  getDataById(String id, bool isFile) async {
    try {
      DialogHelper.showLoadingWithText(context, "loading...");
      TankTankDetailsData _data = await tankService.getById(context, id);
      if (_data.trTankManagements.rows.isNotEmpty) {
        setState(() {
          fetchData(_data, isFile);
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
      if (_selectedJobStatus?.value != "8") {
        if (acceptWorkDateTime.text == "") {
          res.add("วัน-เวลาที่เริ่มงาน");
        }

        if (closeWorkDateTime.text == "") {
          res.add("วัน-เวลาที่เสร็จงาน");
        }
        if (acceptWorkDateTime.text != "" && closeWorkDateTime.text != "") {
          if (!MyFormatDateTime()
              .compareDate(acceptWorkDateTime.text, closeWorkDateTime.text)) {
            res.add("วัน-เวลาที่เริ่มงาน ต้องน้อยกว่า วัน-เวลาที่เสร็จงาน");
          }
        }
        if (dataStaff.length == 0) {
          res.add("ต้องมีคนทำงานอย่างน้อย 1 คน");
        }
      }
    }

    return res;
  }

  checkWarningMile(_context) async {
    bool res = true;

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
        final check = await checkWarningMile(context);
        if (check) {
          final tempAcceptWorkDate = acceptWorkDateTime.text != ""
              ? MyFormatDateTime().convertStringToDate2(acceptWorkDateTime.text)
              : "";
          final tempAcceptWorkTime = acceptWorkDateTime.text != ""
              ? MyFormatDateTime().convertStringToTime(acceptWorkDateTime.text)
              : "";
          final tempCloseWorkDate = closeWorkDateTime.text != ""
              ? MyFormatDateTime().convertStringToDate2(closeWorkDateTime.text)
              : "";
          final tempCloseWorkTime = closeWorkDateTime.text != ""
              ? MyFormatDateTime().convertStringToTime(closeWorkDateTime.text)
              : "";
          final tempTRTankManagementDetail = [];
          for (var i = 0; i < dataStaff.length; i++) {
            final item = dataStaff[i];
            tempTRTankManagementDetail.add({
              "StaffID": item.staffId,
              "StaffName": item.staffName,
              "StaffCode": item.staffCode
            });
          }
          final temp = {
            "WorkStatusCode": _selectedJobStatus?.value,
            "WorkStatus": _selectedJobStatus?.text,
            "TankNo": _selectedTankNo?.value,
            "TankType": _selectedTankType?.value,
            "CleanTypeID": _selectedCleanType?.value,
            "AcceptWorkDate": tempAcceptWorkDate,
            "AcceptWorkTime": tempAcceptWorkTime,
            "CloseWorkDate": tempCloseWorkDate,
            "CloseWorkTime": tempCloseWorkTime,
            "TRTankManagementDetail": tempTRTankManagementDetail
          };
          final body = jsonEncode(temp);
          print("body: $body");
          // DialogHelper.hideLoading(context);
          ResCheckStatusModel data =
              await tankService.update(context, tankManagementId, body);
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

  addStaff(BuildContext context) async {
    List<MsStaffTanksRow> t = [];
    for (var j = 0; j < allStaff.length; j++) {
      bool c = false;
      for (var i = 0; i < dataStaff.length; i++) {
        if (dataStaff[i].staffId == allStaff[j].staffId) {
          c = true;
        }
      }
      if (!c) {
        t.add(allStaff[j]);
      }
    }

    await showDialog(
        context: context,
        builder: (context) {
          return dialogSelectStaff(context, "เพิ่ม", t);
        }).then((value) async {
      if (value != null) {
        final temp = allStaff.firstWhere((item) => item.staffId == value);
        setState(() {
          dataStaff.add(TrTankManagementDetailsRow(
              staffId: temp.staffId,
              staffCode: temp.staffCode,
              staffName: temp.staffName));
        });
      }
    });
  }

  void removeStaff(String id) {
    setState(() {
      final index = dataStaff.lastIndexWhere((item) => item.staffId == id);
      dataStaff.removeAt(index);
    });
  }

  onSelectTankTypes() {
    setState(() {
      if (_selectedTankType != null) {
        if (_selectedTankType!.value != "") {
          final msCleanTypes = msTankTypes
              .firstWhere((item) => item.tankType == _selectedTankType!.value);
          itemsDropdownCleanTypes = msCleanTypes.msCleanTypes.isNotEmpty
              ? msCleanTypes.msCleanTypes
                  .map((e) => DropdownItemsModel(
                      value: e.cleanTypeId, text: e.cleanType))
                  .toList()
              : [];
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    final temp = widget.fromDataTankTankDetails;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData(temp, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> header = ["รหัสพนักงาน", "ชื่อ-นามสกุล", ""];
    return Scaffold(
        backgroundColor: MyColors().backgroundColor(),
        appBar: MyAppBar(
          title: "ปฏิบัติงานล้างแท็งก์ (แก้ไข)",
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
                        titleWithTextHeader(
                            context, "เลขที่งาน", data?.tankManagementNo ?? ""),
                        titleWithWidget(
                            "สถานะ",
                            " *",
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
                            "รหัสแท็งก์",
                            " *",
                            myDropdownMenu3(
                                items: itemsDropdownTankNos,
                                label: "",
                                enabled: true,
                                selectedItems: [],
                                initValue: _selectedTankNo,
                                onSelected: (value) =>
                                    _selectedTankNo = value)),
                        titleWithWidget(
                            "ประเภทแทงก์",
                            " *",
                            myDropdownMenu3(
                                items: itemsDropdownTankTypes,
                                label: "",
                                enabled: true,
                                selectedItems: [],
                                initValue: _selectedTankType,
                                onSelected: (value) {
                                  if (value != null) {
                                    _selectedTankType = value;
                                    onSelectTankTypes();
                                  }
                                })),
                        titleWithWidget(
                            "ประเภทการล้าง",
                            " *",
                            myDropdownMenu3(
                                items: itemsDropdownCleanTypes,
                                label: "",
                                enabled: true,
                                selectedItems: [],
                                initValue: _selectedCleanType,
                                onSelected: (value) =>
                                    _selectedCleanType = value)),
                        titleWithWidget(
                            "พนักงานขับรถ",
                            " *",
                            myTextField(
                                controller: driverName,
                                label: "",
                                clear: false,
                                disable: true,
                                onChanged: (value) {
                                  driverName.text = value ?? "";
                                })),
                        titleWithWidget(
                            "วันที่ต้องการนำแท็งก์เข้าล้าง",
                            "",
                            myTextField(
                                controller: workDate,
                                label: "",
                                clear: false,
                                disable: true,
                                onChanged: (value) {
                                  workDate.text = value ?? "";
                                })),
                        titleWithWidget(
                          "วัน-เวลาที่เริ่มงาน",
                          requiredField ? " *" : "",
                          Row(
                            children: [
                              IntrinsicWidth(
                                child: myDatePicker2(
                                    controller: acceptWorkDateTime,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          acceptWorkDateTime.text = value ?? "";
                                        }),
                                    context: context),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              IntrinsicWidth(
                                child: myTimePicker(
                                    controller: acceptWorkDateTime,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          print("myTimePicker $value");
                                          acceptWorkDateTime.text = value ?? "";
                                        }),
                                    context: context),
                              )
                            ],
                          ),
                        ),
                        titleWithWidget(
                          "วัน-เวลาที่เสร็จงาน",
                          requiredField ? " *" : "",
                          Row(
                            children: [
                              IntrinsicWidth(
                                child: myDatePicker2(
                                    controller: closeWorkDateTime,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          closeWorkDateTime.text = value ?? "";
                                        }),
                                    context: context),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              IntrinsicWidth(
                                child: myTimePicker(
                                    controller: closeWorkDateTime,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          print("myTimePicker $value");
                                          closeWorkDateTime.text = value ?? "";
                                        }),
                                    context: context),
                              )
                            ],
                          ),
                        ),
                        titleWithText("จำนวนพนักงานล้างแท้งก์",
                            "${data?.staffSumary ?? ""}"),
                        if (data != null)
                          titleWithWidget(
                              "พนักงานล้างแท้งก์",
                              "",
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                          style: MyStyle().outlinedButton(
                                              MyColors().secondary()),
                                          onPressed: () => addStaff(context),
                                          child: Text(
                                            "เพิ่ม",
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: MyColors().secondary()),
                                          ))
                                    ],
                                  ),
                                  Table(
                                    border: TableBorder.all(),
                                    columnWidths: const {
                                      0: FlexColumnWidth(1),
                                      1: FlexColumnWidth(3),
                                    },
                                    children: [
                                      TableRow(
                                        children: header
                                            .map(
                                              (col) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Text(
                                                    col,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      if (dataStaff.isEmpty)
                                        const TableRow(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  '',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  'No data',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  '',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ...dataStaff.map(
                                        (item) => TableRow(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text(
                                                "${item.staffCode}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        MyColors().primary()),
                                              )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text(
                                                      "${item.staffName}",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: MyColors()
                                                              .primary()))),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Center(
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () => removeStaff(
                                                      item.staffId ?? ""),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
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
                                                      await selectFileTank(
                                                    context,
                                                    tankManagementId,
                                                    itemsFile,
                                                  );
                                                  if (finish == true) {
                                                    getDataById(
                                                        tankManagementId, true);
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
                                                      await takePhotoTank(
                                                          context,
                                                          tankManagementId,
                                                          itemsFile);
                                                  if (finish == true) {
                                                    getDataById(
                                                        tankManagementId, true);
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
                        attachmentTankEditsWidget(
                          context,
                          itemsFile,
                          onReload: () => getDataById(tankManagementId, true),
                        )
                      ])),
            ),
          ),
        ));
  }
}
