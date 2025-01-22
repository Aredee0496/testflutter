import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/models/app/dropdown-items-model.dart';
import 'package:starlightserviceapp/models/app/jobstatus/jobstatus-model.dart';
import 'package:starlightserviceapp/models/app/tank-tank/res-tank-tank-search-model.dart';
import 'package:starlightserviceapp/pages/tank-tank/tank-tank-details.dart';
import 'package:starlightserviceapp/services/app/jobstatsus-service.dart';
import 'package:starlightserviceapp/services/app/tank-tank-service.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/utils/format-datatime.dart';
import 'package:starlightserviceapp/widgets/appbar.dart';
import 'package:starlightserviceapp/widgets/input/mydatepicker.dart';
import 'package:starlightserviceapp/widgets/input/mydropdown.dart';
import 'package:starlightserviceapp/widgets/input/mytextfield.dart';

class TankTankPage extends StatefulWidget {
  const TankTankPage({super.key});

  @override
  State<TankTankPage> createState() => _TankTankPageState();
}

class _TankTankPageState extends State<TankTankPage> {
  TextEditingController dateStart = TextEditingController();
  TextEditingController dateEnd = TextEditingController();
  TextEditingController textSearch = TextEditingController();
  TextEditingController dropdownStatus = TextEditingController();
  TextEditingController status = TextEditingController();
  JobStatusService jobStatusService = JobStatusService();

  TankTankService tankService = TankTankService();

  String statusValue = "";

  bool loadingJobStatus = false;

  DropdownItemsModel? _selectedJobStatusModel;

  List<DropdownItemsModel> itemsStatus = [];
  List<TrTankManagementsTankRow> items = [];
  List<TrTankManagementsTankRow> itemsShow = [];

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    DateTime startDate = now.add(const Duration(days: -15));
    DateTime endDate = now.add(const Duration(days: 15));

    dateStart.text = DateFormat(FORMATE_DATE_DISPLAY).format(startDate);
    dateEnd.text = DateFormat(FORMATE_DATE_DISPLAY).format(endDate);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getStatus();
    });

    // fetchData();
  }

  Future<void> getStatus() async {
    try {
      DialogHelper.showLoadingWithText(context, "loading jobstatus...");
      itemsStatus = [];
      List<JobStatusModel> data = await tankService.getJobStatus(context);

      for (var i = 0; i < data.length; i++) {
        JobStatusModel item = data[i];
        setState(() {
          if (item.jobStatusCode == "2") {
            onSelectedJobStatus(DropdownItemsModel(
                value: item.jobStatusCode, text: item.description));
          }
          itemsStatus.add(DropdownItemsModel(
              value: item.jobStatusCode, text: item.description));
        });
      }
      DialogHelper.hideLoading(context);
      if (_selectedJobStatusModel != null) {
        fetchData();
      }
    } catch (e) {
      _selectedJobStatusModel = null;
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, e.toString());
    }
  }

  fetchData() async {
    try {
      // DialogHelper.showLoading(context);
      DialogHelper.showLoadingWithText(context, "loading data...");
      final payload = {
        "WorkStatusCode": _selectedJobStatusModel?.value,
        "WorkDateStart": MyFormatDateTime().formatDateToApi(dateStart.text),
        "WorkDateEnd": MyFormatDateTime().formatDateToApi(dateEnd.text),
      };
      print("Payload => $payload");
      List<TrTankManagementsTankRow> data =
          await tankService.search(context, payload);
      setState(() {
        items = data;
        itemsShow = data;
      });
      DialogHelper.hideLoading(context);
    } catch (e) {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, e.toString());
    }
  }

  toPageDetail(
      BuildContext context, String jobStatus, Map<String, dynamic>? data) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TankTankDetailsPage(
                id: '${data?["id"] ?? 0}',
                jobStatus: jobStatus,
              )),
    ).then((_) => setState(() {
          fetchData();
        }));
  }

  onSelectedJobStatus(DropdownItemsModel? value) {
    // print(value.value);
    setState(() {
      _selectedJobStatusModel = value;
      fetchData();
    });
  }

  onSelectedStartDate(value) {
    setState(() {
      dateStart.text = value ?? "";
      dateEnd.text = MyFormatDateTime().setupEndDate(dateStart.text);
      fetchData();
    });
  }

  onSelectedEndDate(value) {
    setState(() {
      dateEnd.text = value ?? "";
      fetchData();
    });
  }

  onSearch(String val) {
    setState(() {
      itemsShow = items
          .where((item) =>
              item.tankManagementNo!.toLowerCase().contains(val.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors().backgroundColor(),
        appBar: MyAppBar(
          title: "ปฏิบัติงานล้างแท็งก์",
          listWidget: [
            IconButton(
              icon: const Icon(Icons.refresh_outlined),
              onPressed: () {
                setState(() {
                  fetchData();
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                          child: myTextField(
                              controller: textSearch,
                              label: "ค้นหาเลขที่งาน",
                              onChanged: (value) {
                                onSearch(value ?? "");
                              })),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                          child: myDropdownMenuWithClear(
                              items: itemsStatus,
                              label: "",
                              enabled: true,
                              selectedItems: [],
                              initValue: _selectedJobStatusModel,
                              onSelected: (value) =>
                                  onSelectedJobStatus(value)))
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text("วันที่ปฏิบัติงาน(Start)"),
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                            myDatePicker(
                                controller: dateStart,
                                label: "วันที่เริ่มต้น",
                                initialDate: MyFormatDateTime()
                                    .convertStringToDate(dateStart.text),
                                onChanged: (value) {
                                  if (value != null) {
                                    onSelectedStartDate(value);
                                  }
                                },
                                context: context),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text("วันที่ปฏิบัติงาน(End)"),
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                            myDatePicker(
                                controller: dateEnd,
                                label: "วันที่สิ้นสุด",
                                startDate: MyFormatDateTime()
                                    .convertStringToDate(dateStart.text),
                                initialDate: MyFormatDateTime()
                                    .convertStringToDate(dateEnd.text),
                                onChanged: (value) {
                                  if (value != null) {
                                    onSelectedEndDate(value);
                                  }
                                },
                                context: context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RefreshIndicator(
                  onRefresh: () => fetchData(),
                  child: itemsShow.length > 0
                      ? buildPosts(itemsShow)
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            "ไม่มีข้อมูล",
                            style: TextStyle(fontSize: 24),
                          ),
                        )),
            ],
          ),
        ));
  }

  Widget buildPosts(List<TrTankManagementsTankRow> data) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        // final post = posts[index];
        final temp = data[index];
        return GestureDetector(
          onTap: () {
            toPageDetail(context, "Edit", {
              "id": temp.tankManagementId,
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "เลขที่งาน : ",
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          "${temp.tankManagementNo}",
                          style: TextStyle(
                              color: MyColors().primary(),
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                              text: '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: DefaultTextStyle.of(context)
                                      .style
                                      .fontFamily,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: temp.workStatus ?? "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: temp.workStatusCode == "1"
                                            ? Colors.blue
                                            : temp.workStatusCode == "2"
                                                ? Colors.green
                                                : temp.workStatusCode == "3"
                                                    ? Colors.red
                                                    : temp.workStatusCode == "9"
                                                        ? Color.fromARGB(
                                                            255, 0, 78, 117)
                                                        : Colors.grey))
                              ],
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "วันที่ปฏิบัติงาน : ${MyFormatDateTime().formatDate(temp.workDate ?? "")} ${MyFormatDateTime().convertStringToTime(temp.workTime ?? "")}",
                            style: const TextStyle(fontSize: 17),
                          ),
                          Text("พนักงานขับรถ : ${temp.driverName}",
                              style: const TextStyle(fontSize: 17)),
                          Text("รหัสแท็งก์ :  ${temp.tankNo}",
                              style: const TextStyle(fontSize: 17)),
                          Text("ประเภทแท็งก์ :  ${temp.tankType}",
                              style: const TextStyle(fontSize: 17)),
                          Text("ประเภทการล้าง : ${temp.cleanType}",
                              style: const TextStyle(fontSize: 17)),
                        ],
                      ),
                    ),
                    Expanded(
                        child: IconButton(
                            onPressed: () {
                              toPageDetail(context, temp.workStatusCode ?? "", {
                                "id": temp.tankManagementId,
                              });
                            },
                            icon: const Icon(Icons.chevron_right_sharp)))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
