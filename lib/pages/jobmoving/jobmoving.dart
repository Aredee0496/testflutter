import 'package:flutter/material.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/models/app/dropdown-items-model.dart';
import 'package:starlightserviceapp/models/app/jobmoving/jobmoving-model.dart';
import 'package:starlightserviceapp/models/app/jobstatus/jobstatus-model.dart';
import 'package:starlightserviceapp/models/app/masterdata/masterdata-model.dart';
import 'package:starlightserviceapp/pages/jobmoving/widget/add-jobmoving.dart';
import 'package:starlightserviceapp/services/app/jobmoving-service.dart';
import 'package:starlightserviceapp/services/app/jobstatsus-service.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/utils/format-datatime.dart';
import 'package:starlightserviceapp/widgets/appbar.dart';
import 'package:intl/intl.dart';
import 'package:starlightserviceapp/widgets/input/mydatepicker.dart';
import 'package:starlightserviceapp/widgets/input/mydropdown.dart';
import 'package:starlightserviceapp/widgets/input/mytextfield.dart';

class JobMovingPage extends StatefulWidget {
  const JobMovingPage({super.key});

  @override
  State<JobMovingPage> createState() => _JobMovingPageState();
}

class _JobMovingPageState extends State<JobMovingPage> {
  TextEditingController dateStart = TextEditingController();
  TextEditingController dateEnd = TextEditingController();
  TextEditingController textSearch = TextEditingController();
  TextEditingController dropdownStatus = TextEditingController();
  TextEditingController status = TextEditingController();
  JobMovingService jobMovingService = JobMovingService();
  JobStatusService jobStatusService = JobStatusService();

  String statusValue = "";

  bool loadingJobStatus = false;

  DropdownItemsModel? _selectedJobStatusModel;

  List<DropdownItemsModel> itemsStatus = [];
  List<JobMovingModel> items = [];
  List<JobMovingModel> itemsShow = [];

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
  }

  Future<void> getStatus() async {
    try {
      DialogHelper.showLoadingWithText(context, "loading jobstatus...");
      itemsStatus = [];
      MasterDataModel masterData =
          await jobMovingService.getMasterData(context);
      List<JobStatusModel> data =
          masterData.msJobStatus.isNotEmpty ? masterData.msJobStatus : [];

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
        "JobStatus": _selectedJobStatusModel!.value,
        "WorkdateStart": MyFormatDateTime().formatDateToApi(dateStart.text),
        "WorkdateEnd": MyFormatDateTime().formatDateToApi(dateEnd.text),
      };
      print("Payload => $payload");
      List<JobMovingModel> data =
          await jobMovingService.search(context, payload);
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

  onSelectedJobStatus(DropdownItemsModel value) {
    print(value.value);
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
              item.documentNo!.toLowerCase().contains(val.toLowerCase()))
          .toList();
    });
  }

  toPageDetail(
      BuildContext context, String action, Map<String, dynamic>? data) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddJobMovingWidget(
                title: args["titlePage"] ?? "",
                id: '${data?["id"] ?? 0}',
                action: action,
              )),
    ).then((_) => setState(() {
          fetchData();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors().backgroundColor(),
        appBar: MyAppBar(
          title: "Job moving :ใบสั่งลาก/เคลื่อย้าย",
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
                          child: myDropdownMenu2(
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

  Widget buildPosts(List<JobMovingModel> data) {
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
              "id": temp.jobId,
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'เลขที่งาน: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily:
                                  DefaultTextStyle.of(context).style.fontFamily,
                              color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: temp.documentNo,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22))
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'สถานะ: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily:
                                  DefaultTextStyle.of(context).style.fontFamily,
                              color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: temp.jobStatusDescription ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: temp.jobStatus == "1"
                                        ? Colors.blue
                                        : temp.jobStatus == "2"
                                            ? Colors.green
                                            : temp.jobStatus == "3"
                                                ? Colors.red
                                                : temp.jobStatus == "9"
                                                    ? Color.fromARGB(
                                                        255, 0, 78, 117)
                                                    : Colors.grey))
                          ],
                        ),
                      ),
                      Text(
                        "วันที่: ${MyFormatDateTime().formatDate(temp.dateWork ?? "")}",
                        style: const TextStyle(fontSize: 17),
                      ),
                      Text("เบอร์ตู้: ${temp.containerNo}",
                          style: const TextStyle(fontSize: 17)),
                      Text("ลากจาก :  ${temp.locationStart}",
                          style: const TextStyle(fontSize: 17)),
                      Text("ไปยัง :  ${temp.locationEnd}",
                          style: const TextStyle(fontSize: 17)),
                      Text("ผู้รับงาน : ${temp.driver}",
                          style: const TextStyle(fontSize: 17)),
                      Text("สาเหตุการเคลื่อนย้าย : ${temp.reason},",
                          style: const TextStyle(fontSize: 17)),
                      Text("หมายเหตุ : ${temp.remark}",
                          style: const TextStyle(fontSize: 17)),
                    ],
                  ),
                ),
                Expanded(
                    child: IconButton(
                        onPressed: () {
                          toPageDetail(context, "Edit", {
                            "id": temp.jobId,
                          });
                        },
                        icon: const Icon(Icons.chevron_right_sharp)))
              ],
            ),
          ),
        );
      },
    );
  }
}
