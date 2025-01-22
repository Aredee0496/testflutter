import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/models/app/dropdown-items-model.dart';
import 'package:starlightserviceapp/models/app/masterdata/masterdata-tank-model.dart';
import 'package:starlightserviceapp/models/app/res-check-stastus-model.dart';
import 'package:starlightserviceapp/models/app/tank-driver/res-tank-details-model.dart';
import 'package:starlightserviceapp/services/app/tank-service.dart';
import 'package:starlightserviceapp/services/storage-service.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/utils/format-datatime.dart';
import 'package:starlightserviceapp/utils/input-data-widget.dart';
import 'package:starlightserviceapp/widgets/appbar.dart';
import 'package:starlightserviceapp/widgets/input/mydatepicker.dart';
import 'package:starlightserviceapp/widgets/input/mydropdown.dart';
import 'package:starlightserviceapp/widgets/input/mytextfield.dart';
import 'package:starlightserviceapp/widgets/input/mytimepicker.dart';

class TankDriverEditPage extends StatefulWidget {
  final TankDetailsDataModel? fromDataTankDriverDetails;
  final String? action;
  const TankDriverEditPage({
    super.key,
    this.action,
    this.fromDataTankDriverDetails,
  });

  @override
  State<TankDriverEditPage> createState() => _TankDriverEditPageState();
}

class _TankDriverEditPageState extends State<TankDriverEditPage> {
  TankService tankService = TankService();
  //start controller
  DropdownItemsModel? _selectedJobStatus;
  DropdownItemsModel? _selectedDriver;
  DropdownItemsModel? _selectedTankNo;
  DropdownItemsModel? _selectedTankType;
  DropdownItemsModel? _selectedCleanType;

  TextEditingController tankManagementDate = TextEditingController();
  TextEditingController workDate = TextEditingController();
  TextEditingController workTime = TextEditingController();

  TrTankManagementsDetailsRow? data;
  List<MsTankTypesRow> msTankTypes = [];
  List<DropdownItemsModel> itemsDropdownJobstatus = [];
  List<DropdownItemsModel> itemsDropdownDrivers = [];
  List<DropdownItemsModel> itemsDropdownTankNos = [];
  List<DropdownItemsModel> itemsDropdownTankTypes = [];
  List<DropdownItemsModel> itemsDropdownCleanTypes = [];

  bool checkSubmit = false;
  String tankManagementId = "";
  TextEditingController testJobStatus = TextEditingController();
  TextEditingController showDriver = TextEditingController();

  fetchData(TankDetailsDataModel temp) {
    setState(() {
      data = temp.trTankManagements.rows[0];
      tankManagementId = data?.tankManagementId ?? "";
      //มาต่อตรงนี้

      //items
      final tempItems = temp;
      itemsDropdownJobstatus = tempItems.msJobStatuss.rows.isNotEmpty
          ? tempItems.msJobStatuss.rows
              .map((e) => DropdownItemsModel(
                  value: e.jobStatusCode, text: e.description ?? ""))
              .toList()
          : [];
      itemsDropdownDrivers = tempItems.msDrivers.rows.isNotEmpty
          ? tempItems.msDrivers.rows
              .map((e) => DropdownItemsModel(
                  value: e.driverId, text: e.description ?? ""))
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
      try {
        if (itemsDropdownDrivers.isNotEmpty) {
          _selectedDriver = itemsDropdownDrivers.firstWhere(
              (item) => item.value == tempData?.driverID,
              orElse: null);

          if (_selectedDriver != null) {
            showDriver.text = "${_selectedDriver?.text}";
          }
        }
      } catch (e) {
        print("$e");
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
              final tempTankType = tempItems.msTankTypes.rows;
              final msCleanTypes = tempTankType.firstWhere(
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
      tankManagementDate.text = MyFormatDateTime()
          .formatDateDisplay(tempData?.tankManagementDate ?? "");
      workDate.text = MyFormatDateTime().convertToCustomFormat(
          "${tempData?.workDate ?? ""}T${tempData?.workTime ?? ""}:00");
      workTime.text = MyFormatDateTime().convertToCustomFormat(
          "${tempData?.workDate ?? ""}T${tempData?.workTime ?? ""}:00");
    });
  }

  getDataById(String id) async {
    try {
      DialogHelper.showLoadingWithText(context, "loading...");
      TankDetailsDataModel data = await tankService.getById(context, id);
      if (data.trTankManagements.rows.isNotEmpty) {
        final temp = data;
        setState(() {
          fetchData(temp);
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

    if (widget.action != "add") {
      if (_selectedJobStatus == null) {
        res.add("สถานะ");
      }
    }

    if (_selectedJobStatus?.value != "8") {
      if (_selectedDriver == null) {
        res.add("พนักงานขับรถ");
      }

      if (_selectedTankNo == null) {
        res.add("รหัสแท็งก์");
      }

      if (_selectedTankType == null) {
        res.add("ประเภทแทงก์");
      }

      if (_selectedCleanType == null) {
        res.add("ประเภทการล้าง");
      }

      if (workDate.text == "") {
        res.add("วันที่ต้องการนำแท็งก์เข้าล้าง");
      }
      if (workTime.text == "") {
        res.add("เวลาต้องการนำแท็งก์เข้าล้าง");
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
          final tempWorkDate = workDate.text != ""
              ? MyFormatDateTime().convertStringToDate2(workDate.text)
              : "";
          final tempWorkTime = workTime.text != ""
              ? MyFormatDateTime().convertStringToTime(workTime.text)
              : "";
          final temp = {
            "TankNo": _selectedTankNo?.value,
            "DriverID": _selectedDriver?.value,
            "TankType": _selectedTankType?.value,
            "CleanTypeID": _selectedCleanType?.value,
            "WorkDate": tempWorkDate,
            "WorkTime": tempWorkTime,
          };
          if (widget.action == "add") {
            final tempTankManagementDate = tankManagementDate.text != ""
                ? MyFormatDateTime().formatDateToApi(tankManagementDate.text)
                : "";
            temp["TankManagementDate"] = tempTankManagementDate;
          } else {
            temp["WorkStatusCode"] = _selectedJobStatus?.value;
            temp["WorkStatus"] = _selectedJobStatus?.text;
          }
          final body = jsonEncode(temp);
          // DialogHelper.hideLoading(context);
          ResCheckStatusModel data = widget.action == "add"
              ? await tankService.insert(context, body)
              : await tankService.update(context, tankManagementId, body);
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

  getMasterData() async {
    try {
      DialogHelper.showLoadingWithText(context, "loading...");
      MasterDataTankModel data = await tankService.getMasterData(context);
      setState(() {
        setupAdd(data);
      });

      DialogHelper.hideLoading(context);
    } catch (e) {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, e.toString());
    }
  }

  setupAdd(MasterDataTankModel data) async {
    if (data.msJobStatus.rows.isNotEmpty) {
      final temp = data.msJobStatus.rows[0];
      testJobStatus.text = temp.description;
    }

    final datenow = DateTime.now();
    final tempdatenow = MyFormatDateTime().formatDateTimeToOrignal(datenow);
    TimeOfDay tempInitialDate = TimeOfDay.fromDateTime(datenow);

    final tempTime =
        MyFormatDateTime().convertTimeToStringDisplay(tempInitialDate);

    tankManagementDate.text = MyFormatDateTime().formatDateDisplay(tempdatenow);
    workDate.text = MyFormatDateTime()
        .convertToCustomFormat("${tempdatenow}T${tempTime}:00");
    workTime.text = MyFormatDateTime()
        .convertToCustomFormat("${tempdatenow}T${tempTime}:00");

    if (data.msDrivers.rows.isNotEmpty) {
      final temp = data.msDrivers.rows;
      itemsDropdownDrivers = temp.isNotEmpty
          ? temp
              .map((e) => DropdownItemsModel(
                  value: e.driverId, text: e.description ?? ""))
              .toList()
          : [];

      if (itemsDropdownDrivers.isNotEmpty) {
        StorageApp storageApp = StorageApp();
        final user = await storageApp.getUser();
        final employeeCodeLogin = user.employeeCode ?? "";

        final mydriver = temp.firstWhere(
            (item) => item.driver == employeeCodeLogin,
            orElse: null);

        _selectedDriver = itemsDropdownDrivers.firstWhere(
            (item) => item.value == mydriver.driverId,
            orElse: null);
        if (_selectedDriver != null) {
          showDriver.text = "${_selectedDriver?.text}";
        }
      }

      itemsDropdownTankNos = data.msTanks.rows.isNotEmpty
          ? data.msTanks.rows
              .map((e) => DropdownItemsModel(value: e.tankNo, text: e.tankNo))
              .toList()
          : [];

      if (data.msTankTypes.rows.isNotEmpty) {
        msTankTypes = data.msTankTypes.rows;
        itemsDropdownTankTypes = msTankTypes
            .map((e) => DropdownItemsModel(value: e.tankType, text: e.tankType))
            .toList();
      }
    }
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
    final temp = widget.fromDataTankDriverDetails;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.action != "add") {
        fetchData(temp!);
      } else {
        getMasterData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors().backgroundColor(),
        appBar: MyAppBar(
          title:
              "แจ้งล้างแท้งก์ (${widget.action == "add" ? "เพิ่ม" : "แก้ไข"})",
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
                          "เลขที่งาน : ${data?.tankManagementNo ?? ""}",
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        if (widget.action == "add")
                          titleWithWidget(
                              "สถานะ",
                              "",
                              myTextField(
                                  controller: testJobStatus,
                                  label: "",
                                  clear: false,
                                  disable: true,
                                  onChanged: (value) {
                                    testJobStatus.text = value ?? "";
                                  })),
                        if (widget.action != "add")
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
                            "วันที่ปฏิบัติงาน",
                            "",
                            myTextField(
                                controller: tankManagementDate,
                                label: "",
                                clear: false,
                                disable: true,
                                onChanged: (value) {
                                  tankManagementDate.text = value ?? "";
                                })),
                        titleWithWidget(
                            "พนักงานขับรถ",
                            "",
                            myTextField(
                                controller: showDriver,
                                label: "",
                                clear: false,
                                disable: true,
                                onChanged: (value) {
                                  showDriver.text = value ?? "";
                                })),
                        // titleWithWidget(
                        //     "พนักงานขับรถ",
                        //     " *",
                        //     myDropdownMenu3(
                        //         items: itemsDropdownDrivers,
                        //         label: "",
                        //         enabled: true,
                        //         selectedItems: [],
                        //         initValue: _selectedDriver,
                        //         onSelected: (value) =>
                        //             _selectedDriver = value)),
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
                          "วันที่ต้องการนำแท็งก์เข้าล้าง",
                          " *",
                          Row(
                            children: [
                              IntrinsicWidth(
                                child: myDatePicker2(
                                    controller: workDate,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          workDate.text = value ?? "";
                                        }),
                                    context: context),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              IntrinsicWidth(
                                child: myTimePicker(
                                    controller: workTime,
                                    label: "",
                                    onChanged: (value) => setState(() {
                                          print("myTimePicker $value");
                                          workTime.text = value ?? "";
                                        }),
                                    context: context),
                              )
                            ],
                          ),
                        ),
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
}
