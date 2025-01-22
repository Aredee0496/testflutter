import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/pages/jobmoving/widget/add-jobmoving-admin.dart';
import 'package:starlightserviceapp/services/app/workcertificate-service.dart';
import 'package:starlightserviceapp/utils/date-picker.dart';
import 'package:starlightserviceapp/widgets/appbar.dart';
import 'package:intl/intl.dart';

class JobMovingAdminPage extends StatefulWidget {
  const JobMovingAdminPage({super.key, this.menuid});
  final int? menuid;

  @override
  State<JobMovingAdminPage> createState() => _JobMovingAdminPageState();
}

class _JobMovingAdminPageState extends State<JobMovingAdminPage> {
  List<DropdownMenuItem> listStatus = [];
  DateTime? dateTime;
  TextEditingController dateStart = TextEditingController();
  TextEditingController dateEnd = TextEditingController();
  TextEditingController textSearch = TextEditingController();
  TextEditingController dropdownStatus = TextEditingController();
  Future<List<Post>> postsFuture = getPosts();
  @override
  void initState() {
    listStatus = [
      const DropdownMenuItem(
        value: 1,
        child: Text("เปิดงาน"),
      ),
      const DropdownMenuItem(
        value: 0,
        child: Text("ปิดงาน"),
      )
    ];

    dateTime = DateTime.now();
    super.initState();
  }

  toPageDetail(
      BuildContext context, String action, Map<String, dynamic>? data) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddJobMovingAdminWidget(
                title: args["titlePage"] ?? "",
                id: '${data?["id"] ?? 0}',
                action: action,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: MyAppBar(
        title: args["titlePage"] ?? "",
        listWidget: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // refresh action
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.swap_vert,
            ),
            onPressed: () {
              // calendar action
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // calendar action
              toPageDetail(context, "Add", {});
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onTap: () async {
                      final temp = await chooseDate(context, DateTime.now());
                      if (temp != null) {
                        print(temp);
                        dateStart.text =
                            DateFormat(FORMATE_DATE_DISPLAY).format(temp);
                      }
                    },
                    readOnly: true,
                    controller: dateStart,
                    decoration: const InputDecoration(
                        hintText: "วันที่เริ่ม",
                        isDense: true,
                        suffixIcon: Icon(
                          Icons.calendar_month,
                          size: 25,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero))),
                  ),
                ),
                Expanded(
                  child: TextField(
                    onTap: () async {
                      final temp = await chooseDate(context, DateTime.now());
                      if (temp != null) {
                        print(temp);
                        dateEnd.text =
                            DateFormat(FORMATE_DATE_DISPLAY).format(temp);
                      }
                    },
                    controller: dateEnd,
                    readOnly: true,
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: "วันที่สิ้นสุด",
                        suffixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero))),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: textSearch,
                      decoration: InputDecoration(
                          hintText: "ค้นหาเลขที่งาน",
                          isDense: true,
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.zero)),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              textSearch.clear();
                            },
                          ))),
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        hintText: "ค้นหาประเภทงาน",
                        isDense: true,
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero)),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            textSearch.clear();
                          },
                        )),
                    items: listStatus,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        dropdownStatus.text = "$value";
                      });
                    },
                  ),
                ),
              ],
            ),
            FutureBuilder<List<Post>>(
              future: postsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final posts = snapshot.data!;
                  return buildPosts(posts);
                } else {
                  return const Text("No data available");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPosts(List<Post> posts) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        // final post = posts[index];
        return GestureDetector(
          onTap: () {
            toPageDetail(context, "Edit", {
              "id": index,
            });
          },
          child: Container(
            color: Colors.grey.shade300,
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
                      Text(
                        "เลขที่งาน: 5275$index",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("วันที่: 29/02/2024"),
                      const Text("Plant Customer: 8102 HY"),
                      Text("เบอร์ตู้: S$index"),
                      const Text("ไปยัง : ลานจอด STL"),
                      const Text("ผู้จ่ายงาน : STL Saharut Pataradoon"),
                      const Text("ผู้รับงาน : STL Veerawat Suwannarat"),
                      const Text("สาเหตุการเคลื่อนย้าย : ตู้เต็ม,"),
                      const Text("หมายเหตุ : TCNU4235842"),
                    ],
                  ),
                ),
                Expanded(
                    child: IconButton(
                        onPressed: () {
                          toPageDetail(context, "Edit", {
                            "id": index,
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
