import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starlightserviceapp/utils/date-picker.dart';
import 'package:starlightserviceapp/utils/format-datatime.dart';
import 'package:starlightserviceapp/utils/input-data-widget.dart';

TextField myDatePicker({
  Key? key,
  required TextEditingController controller,
  required String label,
  required ValueChanged<String?> onChanged,
  required BuildContext context,
  DateTime? initialDate,
  DateTime? startDate,
  DateTime? endDate,
}) {
  DateTime currentDate = DateTime.now();

  DateTime tempInitialDate = initialDate ?? currentDate;
  DateTime tempStartDate = startDate ?? DateTime(currentDate.year - 10);
  DateTime tempEndDate = endDate ?? DateTime(currentDate.year + 10);
  return TextField(
    key: key, // ใช้ key ที่ได้รับ
    controller: controller,
    readOnly: true,
    style: const TextStyle(
      fontSize: 18,
    ),
    decoration: inputDecorationIcon(
        Icon(
          Icons.calendar_month_outlined,
        ),
        label),
    onTap: () async {
      final temp = await chooseDatePicker(
        context: context,
        startDate: tempStartDate,
        endDate: tempEndDate,
        initialDate: tempInitialDate,
      );
      if (temp != null) {
        onChanged(MyFormatDateTime().convertDateToStringDisplay(temp));
      }
    },
  );
}

TextField myDatePicker2({
  Key? key,
  required TextEditingController controller,
  required String label,
  required ValueChanged<String?> onChanged,
  required BuildContext context,
  DateTime? initialDate,
  DateTime? startDate,
  DateTime? endDate,
}) {
  DateTime currentDate = DateTime.now();

  DateTime tempInitialDate = initialDate ?? currentDate;
  DateTime tempStartDate = startDate ?? DateTime(currentDate.year - 10);
  DateTime tempEndDate = endDate ?? DateTime(currentDate.year + 10);
  TextEditingController tempController = TextEditingController();

  tempController.text =
      MyFormatDateTime().convertDateOriginalToDate(controller.text);

  return TextField(
    key: key, // ใช้ key ที่ได้รับ
    controller: tempController,
    readOnly: true,
    style: const TextStyle(
      fontSize: 18,
    ),
    decoration: inputDecorationIcon(
        const Icon(
          Icons.calendar_month_outlined,
        ),
        label),
    onTap: () async {
      final temp = await chooseDatePicker(
        context: context,
        startDate: tempStartDate,
        endDate: tempEndDate,
        initialDate: tempInitialDate,
      );
      if (temp != null) {
        String? tempTime =
            MyFormatDateTime().convertStringToTime2(controller.text);
        if (tempTime == null || tempTime == "") {
          tempTime =
              MyFormatDateTime().convertTimeToStringDisplay(TimeOfDay.now());
        }
        final date = MyFormatDateTime().formatDateTimeToOrignal(temp);

        final tempString = "$date $tempTime";
        onChanged(tempString);
      }
    },
  );
}
