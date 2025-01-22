import 'package:flutter/material.dart';

Future<DateTime?> chooseDate(BuildContext context, DateTime dateTime) async {
  DateTime? temp = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
      initialDate: dateTime);
  return temp;
}

Future<DateTime?> chooseDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime startDate,
  required DateTime endDate,
}) async {
  DateTime? temp = await showDatePicker(
    context: context,
    firstDate: startDate,
    lastDate: endDate,
    initialDate: initialDate,
  );

  return temp;
}

Future<TimeOfDay?> chooseTime(BuildContext context, TimeOfDay dateTime) async {
  TimeOfDay? temp = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true,
            ),
            child: child!,
          ),
      initialTime: dateTime);
  return temp;
}

Future<TimeOfDay?> chooseTimePicker({
  required BuildContext context,
  required TimeOfDay time,
}) async {
  TimeOfDay? temp = await chooseTime(context, time);

  return temp;
}
