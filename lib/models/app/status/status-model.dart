import 'package:flutter/material.dart';

class StatusModel {
  int id;
  String status;

  StatusModel({
    required this.id,
    required this.status,
  });
}

class ItemsStatus {
  all() {
    return [
      const DropdownMenuEntry(value: 1, label: "แจ้งนัดรถ"),
      const DropdownMenuEntry(value: 2, label: "เปิดงาน"),
      const DropdownMenuEntry(value: 3, label: "ปิดงาน"),
    ];
  }
}
