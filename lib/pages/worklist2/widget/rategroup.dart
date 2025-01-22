import 'package:flutter/material.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-expenses-rategroup1-model.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';

Widget rateGroup(
    BuildContext context,
    String increaseAllowance,
    String deductAllowance,
    List<TrWorklistExpensesRateGroup1Row> items1,
    String increaseFuelCost,
    String deductFuelCost,
    List<TrWorklistExpensesRateGroup1Row> items2) {
  final List<String> header1 = ["รายการ ค่าเบี้ยเลี้ยง/อื่นๆ", "จำนวน", "รวม"];
  final List<String> header2 = ["รายการ ค่าน้ำมัน", "จำนวน", "รวม"];
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Rate Group: เบี้ยเลี้ยง/อื่นๆ
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Rate Group: เบี้ยเลี้ยง/อื่นๆ",
            style:
                TextStyle(fontSize: 18, decoration: TextDecoration.underline),
          ),
        ],
      ),
      RichText(
        text: TextSpan(
          text: '',
          style: TextStyle(
              fontSize: 18,
              fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
              color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: 'รายการบวกเพิ่มเติม (เบี้ยเลี้ยง) : ',
            ),
            TextSpan(
                text: increaseAllowance,
                style: TextStyle(color: MyColors().primary()))
          ],
        ),
      ),
      RichText(
        text: TextSpan(
          text: '',
          style: TextStyle(
              fontSize: 18,
              fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
              color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: 'รายการหักเพิ่มเติม (เบี้ยเลี้ยง) : ',
            ),
            TextSpan(
                text: deductAllowance,
                style: TextStyle(color: MyColors().primary()))
          ],
        ),
      ),
      Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        children: [
          TableRow(
            children: header1
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
          if (items1.isEmpty)
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
          ...items1.map(
            (item) => TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                          "${item.rate} (${item.price}/${item.rateUnit})",
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
      const SizedBox(
        height: 10,
      ),

      //Rate Group: ค่าน้ำมัน
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Rate Group: ค่าน้ำมัน",
            style:
                TextStyle(fontSize: 18, decoration: TextDecoration.underline),
          ),
        ],
      ),

      RichText(
        text: TextSpan(
          text: '',
          style: TextStyle(
              fontSize: 18,
              fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
              color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: 'รายการบวกเพิ่มเติม (น้ำมัน) : ',
            ),
            TextSpan(
                text: increaseFuelCost,
                style: TextStyle(color: MyColors().primary()))
          ],
        ),
      ),
      RichText(
        text: TextSpan(
          text: '',
          style: TextStyle(
              fontSize: 18,
              fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
              color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: 'รายการหักเพิ่มเติม (น้ำมัน) : ',
            ),
            TextSpan(
                text: deductFuelCost,
                style: TextStyle(color: MyColors().primary()))
          ],
        ),
      ),
      Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        children: [
          TableRow(
            children: header2
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
          if (items2.isEmpty)
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
          ...items2.map(
            (item) => TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                          "${item.rate} (${item.price}/${item.rateUnit})",
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
      const SizedBox(
        height: 10,
      )
    ],
  );
}
