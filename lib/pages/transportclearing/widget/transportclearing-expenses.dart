import 'package:flutter/material.dart';
import 'package:starlightserviceapp/models/app/transportclearing/res-transportclearing-getbyid-model.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';

Widget expensesTransportClearing(
    BuildContext context, List<TrWorklistExpensesRow> items) {
  final List<String> header = ["Rate Group", "รายการ", "จำนวน", "รวม"];
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Rate Group: เบี้ยเลี้ยง/อื่นๆ

      Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(4),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1),
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
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
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
                      child: Text(item.rateGroupDescription ?? "",
                          style: TextStyle(
                              fontSize: 16, color: MyColors().primary()))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                          "${item.rate}(${item.price}/${item.rateUnit})",
                          style: TextStyle(
                              fontSize: 16, color: MyColors().primary()))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text("${item.rateAmount}",
                          style: TextStyle(
                              fontSize: 16, color: MyColors().primary()))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text("${item.rateSum}",
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
