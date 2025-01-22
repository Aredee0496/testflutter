import 'package:flutter/material.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-evaluations-model.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';

Widget assessment(List<TrWorklistEvaluationsRow> items, String descriptions) {
  final List<String> header = ["หัวข้อประเมิน", "ผลประเมิน"];
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FlexColumnWidth(2),
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
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      '',
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
                    item.checklist,
                    style: TextStyle(fontSize: 16, color: MyColors().primary()),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                          item.result == "Y"
                              ? "ปกติ"
                              : item.result == "N"
                                  ? "ไม่ปกติ"
                                  : "ไม่ตรวจ",
                          style: TextStyle(
                              fontSize: 16, color: MyColors().primary()))),
                ),
              ],
            ),
          ),
        ],
      ),
      Text(
        "การแก้ไขกรณีไม่ปกติ/บันทึกเพิ่มเติม",
        style: TextStyle(fontSize: 18),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(descriptions,
            style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 18)),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}
