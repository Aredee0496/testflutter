class TrWorklistShipments {
  int count;
  List<TrWorklistShipmentsRow> rows;

  TrWorklistShipments({
    required this.count,
    required this.rows,
  });

  factory TrWorklistShipments.fromJson(Map<String, dynamic> json) =>
      TrWorklistShipments(
        count: json["count"],
        rows: List<TrWorklistShipmentsRow>.from(
            json["rows"].map((x) => TrWorklistShipmentsRow.fromJson(x))),
      );
}

class TrWorklistShipmentsRow {
  String? worklistId;
  String? shipmentNo;
  String? deliveryOrderNo;

  TrWorklistShipmentsRow(
      {required this.worklistId,
      required this.shipmentNo,
      required this.deliveryOrderNo});

  factory TrWorklistShipmentsRow.fromJson(Map<String, dynamic> json) =>
      TrWorklistShipmentsRow(
          worklistId: json["WorklistID"],
          shipmentNo: json["ShipmentNo"],
          deliveryOrderNo: json["DeliveryOrderNo"]);
}
