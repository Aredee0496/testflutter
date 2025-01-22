import 'package:flutter/material.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/models/app/plant/plant-model.dart';
import 'package:starlightserviceapp/services/app/plant-service.dart';
import 'package:starlightserviceapp/utils/button-style.dart';
import 'package:starlightserviceapp/utils/date-picker.dart';
import 'package:starlightserviceapp/utils/input-data-widget.dart';
import 'package:starlightserviceapp/widgets/appbar.dart';
import 'package:intl/intl.dart';

class AddJobMovingAdminWidget extends StatefulWidget {
  const AddJobMovingAdminWidget(
      {super.key, this.id, required this.title, required this.action});
  final String title;
  final String? id;
  final String action;
  @override
  State<AddJobMovingAdminWidget> createState() =>
      _AddJobMovingAdminWidgetState();
}

class _AddJobMovingAdminWidgetState extends State<AddJobMovingAdminWidget> {
  final GlobalKey<FormState> _keyFormJobMoving = GlobalKey<FormState>();

  TextEditingController dataDate = TextEditingController();
  TextEditingController dataBoxNo = TextEditingController();

  PlantService plantService = PlantService();
  List<PlantModel> itemsPlant = [];
  bool loadingPlant = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyFormJobMoving,
      child: Scaffold(
        appBar: MyAppBar(
          title: widget.title,
          listWidget: [
            IconButton(
              icon: const Icon(Icons.done),
              onPressed: () {
                // calendar action
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "เลขที่งาน ${widget.id}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                titleWithWidget(
                  "วันที่",
                  " *",
                  TextFormField(
                    onTap: () async {
                      final temp = await chooseDate(context, DateTime.now());
                      if (temp != null) {
                        dataDate.text =
                            DateFormat(FORMATE_DATE_DISPLAY).format(temp);
                      }
                    },
                    controller: dataDate,
                    readOnly: true,
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: "",
                        suffixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder()),
                  ),
                ),
                titleWithWidget(
                  "เบอร์ตู้",
                  " *",
                  TextFormField(
                    controller: dataBoxNo,
                    readOnly: false,
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: "",
                        border: OutlineInputBorder()),
                  ),
                ),
                titleWithWidget(
                    "Plant(Customer)",
                    " *",
                    FutureBuilder(
                      future: plantService.getAll(context),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PlantModel>> snapshot) {
                        if (snapshot.hasData) {
                          return autoCompletePlant(
                            true,
                            const Icon(
                              Icons.expand_more_sharp,
                            ),
                            snapshot.data ?? [],
                          );
                        } else if (snapshot.hasError) {
                          return autoCompletePlant(
                              false,
                              Tooltip(
                                  message: snapshot.error.toString(),
                                  child: const Icon(
                                    Icons.error_outline_sharp,
                                    color: Colors.red,
                                  )),
                              []);
                        } else {
                          return autoCompletePlant(
                              false, const CircularProgressIndicator(), []);
                        }
                      },
                    )),
                // ),
                titleWithWidget(
                  "ลากจาก",
                  " *",
                  TextFormField(
                    controller: dataBoxNo,
                    readOnly: false,
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: "",
                        border: OutlineInputBorder()),
                  ),
                ),
                titleWithWidget(
                  "ไปยัง",
                  " *",
                  TextFormField(
                    controller: dataBoxNo,
                    readOnly: false,
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: "",
                        border: OutlineInputBorder()),
                  ),
                ),
                titleWithWidget(
                  "สาเหตุการเคลื่อนย้าย",
                  " *",
                  TextFormField(
                    controller: dataBoxNo,
                    readOnly: false,
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: "",
                        border: OutlineInputBorder()),
                  ),
                ),
                titleWithWidget(
                  "หมายเหตุ",
                  " *",
                  TextFormField(
                    controller: dataBoxNo,
                    readOnly: false,
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: "",
                        border: OutlineInputBorder()),
                  ),
                ),
                titleWithWidget(
                  "ผู้รับ",
                  " *",
                  TextFormField(
                    controller: dataBoxNo,
                    readOnly: false,
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: "",
                        border: OutlineInputBorder()),
                  ),
                ),
                titleWithWidget(
                  "ทะเบียนรถเทรลเลอร์ ",
                  " *",
                  TextFormField(
                    controller: dataBoxNo,
                    readOnly: false,
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: "",
                        border: OutlineInputBorder()),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        style: MyStyle().outlinedButton(Colors.red),
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Icon(Icons.delete_outlined),
                            Text("ลบ"),
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget autoCompletePlant(
      bool enabled, Widget suffixIcon, List<PlantModel> items) {
    return Autocomplete<PlantModel>(
        fieldViewBuilder: (context, textEditingController, focusNode,
                onFieldSubmitted) =>
            TextField(
              focusNode: focusNode,
              controller: textEditingController,
              enabled: enabled,
              decoration: InputDecoration(
                  isDense: true,
                  hintText: "",
                  border: const OutlineInputBorder(),
                  suffixIcon: Center(
                      child:
                          SizedBox(height: 20, width: 20, child: suffixIcon)),
                  suffixIconConstraints:
                      const BoxConstraints(maxHeight: 50, maxWidth: 50)),
            ),
        displayStringForOption: (option) => option.plantName,
        optionsBuilder: (val) {
          if (val.text.isEmpty) {
            return items;
          }
          return items.where((item) {
            return item.plantName
                .trim()
                .toLowerCase()
                .contains(val.text..trim().toLowerCase());
          });
        });
  }
}
