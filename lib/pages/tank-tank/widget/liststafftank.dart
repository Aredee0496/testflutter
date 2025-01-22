import 'package:flutter/material.dart';
import 'package:starlightserviceapp/models/app/tank-tank/res-tank-tank-details-model.dart';
import 'package:starlightserviceapp/utils/button-style.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';

Widget listStaffTank(
  List<TrTankManagementDetailsRow> items,
) {
  final List<String> header = ["รหัสพนักงาน", "ชื่อ-นามสกุล"];
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(3),
        },
        children: [
          TableRow(
            children: header
                .map(
                  (col) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        col,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          if (items.isEmpty)
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'No data',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ...items.map(
            (item) => TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "${item.staffCode}",
                    style: TextStyle(fontSize: 16, color: MyColors().primary()),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text("${item.staffName}",
                          style: TextStyle(
                              fontSize: 16, color: MyColors().primary()))),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

Widget listStaffTankEdit(
  BuildContext context,
  List<TrTankManagementDetailsRow> items,
  List<MsStaffTanksRow> itemsAll,
) {
  final List<String> header = ["รหัสพนักงาน", "ชื่อ-นามสกุล", ""];
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(3),
        },
        children: [
          TableRow(
            children: header
                .map(
                  (col) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        col,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          if (items.isEmpty)
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'No data',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ...items.map(
            (item) => TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "${item.staffCode}",
                    style: TextStyle(fontSize: 16, color: MyColors().primary()),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text("${item.staffName}",
                          style: TextStyle(
                              fontSize: 16, color: MyColors().primary()))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

Widget dialogSelectStaff(
    BuildContext context, String title, List<MsStaffTanksRow> items) {
  final List<String> header = ["ชื่อ-นามสกุล", ""];
  return AlertDialog(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    title: Center(
      child: Text(
        title,
        style: TextStyle(color: MyColors().primary()),
      ),
    ),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: FlexColumnWidth(4),
            1: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              children: header
                  .map(
                    (col) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          col,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            if (items.isEmpty)
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'No data',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        '',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ...items.map(
              (item) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text("${item.staffName}",
                            style: TextStyle(
                                fontSize: 16, color: MyColors().primary()))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                        child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: MyColors().secondary(),
                      ),
                      onPressed: () => Navigator.pop(context, item.staffId),
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlinedButton(
            style: MyStyle().outlinedButton(
              Colors.red,
            ),
            onPressed: () => Navigator.pop(context, null),
            child: const Text('ยกเลิก',
                style: TextStyle(fontSize: 20, color: Colors.red)),
          ),
          // ElevatedButton(
          //   style: MyStyle().elevatedButton(),
          //   onPressed: () => Navigator.pop(context, _selected),
          //   child: Text('ยืนยัน',
          //       style: TextStyle(fontSize: 20, color: Colors.white)),
          // ),
        ],
      ),
    ],
  );
}
