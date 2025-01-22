import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starlightserviceapp/utils/date-picker.dart';
import 'package:starlightserviceapp/utils/format-datatime.dart';
import 'package:starlightserviceapp/utils/input-data-widget.dart';

TextField myTimePicker({
  Key? key,
  required TextEditingController controller,
  required String label,
  required ValueChanged<String?> onChanged,
  required BuildContext context,
  DateTime? initialDate,
}) {
  DateTime currentDate = DateTime.now();

  TextEditingController tempController = TextEditingController();

  tempController.text = MyFormatDateTime().convertStringToTime(controller.text);
  if (tempController.text != "") {
    initialDate = MyFormatDateTime().convertStringToTime3(tempController.text);
  }

  TimeOfDay tempInitialDate =
      TimeOfDay.fromDateTime(initialDate ?? currentDate);

  return TextField(
    key: key, // ใช้ key ที่ได้รับ
    controller: tempController,

    readOnly: true,
    style: const TextStyle(fontSize: 20, height: double.minPositive),

    decoration:
        inputDecorationIcon(const Icon(Icons.access_time_outlined), label),
    onTap: () async {
      final temp =
          await chooseTimePicker(context: context, time: tempInitialDate);
      if (temp != null) {
        print("timetemp => $temp");
        String? tempDate =
            MyFormatDateTime().convertStringToDate2(controller.text);
        if (tempDate == null || tempDate == "") {
          tempDate = MyFormatDateTime().formatDateTimeToOrignal(currentDate);
        }

        String tempTime = MyFormatDateTime().convertTimeToStringDisplay(temp);

        final tempString = "$tempDate $tempTime";
        print("time => $tempString");
        onChanged(tempString);
      }
    },
  );
}
