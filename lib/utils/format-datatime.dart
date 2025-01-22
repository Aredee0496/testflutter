import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starlightserviceapp/config/env.dart';

class MyFormatDateTime {
  formatDate(String date) {
    if (date != "") {
      DateTime tempDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(tempDate);
    } else {
      return "";
    }
  }

  formatDateDisplay(String date) {
    if (date != "") {
      DateTime tempDate = DateTime.parse(date);
      return DateFormat(FORMATE_DATE_DISPLAY).format(tempDate);
    } else {
      return "";
    }
  }

  formatDateTimeDisplay(String date) {
    if (date != "") {
      print("date in formatDateTimeDisplay: $date");
      DateTime tempDate = DateTime.parse(date);
      return DateFormat(FORMATE_DATETIME_DISPLAY).format(tempDate);
    } else {
      return "";
    }
  }

  convertDateToStringDisplay(DateTime? date) {
    if (date != null) {
      return DateFormat(FORMATE_DATE_DISPLAY).format(date);
    } else {
      return "";
    }
  }

  convertStringToDate(String date) {
    if (date != "") {
      DateFormat dateFormat = DateFormat(FORMATE_DATE_DISPLAY);
      return dateFormat.parse(date);
    } else {
      return "";
    }
  }

  convertStringToDate2(String date) {
    if (date != "") {
      DateFormat dateFormat = DateFormat(FORMATE_DATE_ORIGINAL);
      return dateFormat.format(dateFormat.parse(date));
    } else {
      return "";
    }
  }

  formatDateTimeToOrignal(DateTime? date) {
    if (date != "" && date != null) {
      return DateFormat(FORMATE_DATE_ORIGINAL).format(date);
    } else {
      return "";
    }
  }

  setupEndDate(String date) {
    DateFormat dateFormat = DateFormat(FORMATE_DATE_DISPLAY);
    DateTime temp = dateFormat.parse(date);
    DateTime tempAdd = temp.add(Duration(days: 30));
    return dateFormat.format(tempAdd);
  }

  formatDateToApi(String date) {
    if (date != "") {
      try {
        List<String> parts = date.split('/');
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int year = int.parse(parts[2]);

        DateTime tempDate = DateTime(year, month, day);

        return DateFormat(FORMATE_DATE_ORIGINAL).format(tempDate);
      } catch (e) {
        return e;
      }
    } else {
      return "";
    }
  }

  convertTimeToStringDisplay(TimeOfDay? time) {
    if (time != null) {
      final String hour = time.hour.toString().padLeft(2, '0');
      final String minute = time.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } else {
      return "";
    }
  }

  convertStringToTime(String? time) {
    if (time != null && time != "") {
      try {
        DateTime dateTime = DateFormat(FORMATE_DATETIME_ORIGINAL).parse(time);
        String formattedTime =
            DateFormat(FORMATE_TIME_DISPLAY).format(dateTime);
        return formattedTime;
      } catch (e) {
        print("$e");
        return "";
      }
    } else {
      return "";
    }
  }

  convertStringToTime2(String? time) {
    if (time != null && time != "") {
      try {
        DateTime dateTime = DateFormat(FORMATE_DATETIME_ORIGINAL).parse(time);
        String formattedTime =
            DateFormat(FORMATE_TIME_DISPLAY).format(dateTime);
        return formattedTime;
      } catch (e) {
        print("$e");
        return "";
      }
    } else {
      return "";
    }
  }

  convertStringToTime3(String? time) {
    if (time != null && time != "") {
      try {
        DateTime dateTime = DateFormat(FORMATE_TIME_DISPLAY).parse(time);

        return dateTime;
      } catch (e) {
        print("$e");
        return "";
      }
    } else {
      return "";
    }
  }

  convertDateOriginalToDate(String? datetime) {
    if (datetime != null && datetime != "") {
      try {
        DateTime dateTime =
            DateFormat(FORMATE_DATETIME_ORIGINAL).parse(datetime);
        String formattedTime =
            DateFormat(FORMATE_DATE_DISPLAY).format(dateTime);
        print(formattedTime);
        return formattedTime;
      } catch (e) {
        print("$e");
        return "";
      }
    } else {
      return "";
    }
  }

  convertToCustomFormat(String isoString) {
    try {
      print("${isoString}");
      if (isoString == "") {
        return "";
      }
      DateTime dateTime = DateTime.parse(isoString);

      // กำหนดรูปแบบ "yyyy-MM-dd HH:mm"
      String formattedDate =
          DateFormat(FORMATE_DATETIME_ORIGINAL).format(dateTime);

      return formattedDate;
    } catch (e) {
      print("$e");
      return "";
    }
  }

  compareDate(String a, String b) {
    // if (a == "" || b == "") {
    //   return false;
    // } else {
    //   DateTime dateA = DateTime.parse(a);
    //   DateTime dateB = DateTime.parse(b);
    //   if (dateB.isAfter(dateA)) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // }
    return true;
  }
}
