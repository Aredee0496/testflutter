class TrsapShipmentOutbounds {
  int count;
  List<TrsapShipmentOutboundsRow> rows;

  TrsapShipmentOutbounds({
    required this.count,
    required this.rows,
  });

  factory TrsapShipmentOutbounds.fromJson(Map<String, dynamic> json) =>
      TrsapShipmentOutbounds(
        count: json["count"],
        rows: List<TrsapShipmentOutboundsRow>.from(
            json["rows"].map((x) => TrsapShipmentOutboundsRow.fromJson(x))),
      );
}

class TrsapShipmentOutboundsRow {
  String shipmentDoOutboundId;
  String plantCode;
  String shipmentNo;
  String deliveryOrderNo;
  dynamic shipmentCostNumber;
  dynamic shipmentCostStatus;
  dynamic textProductDescription;
  dynamic loNumber;
  String origShipmentNum;
  dynamic shipmentTypeCode;
  dynamic shipmentTypeDescription;

  TrsapShipmentOutboundsRow({
    required this.shipmentDoOutboundId,
    required this.plantCode,
    required this.shipmentNo,
    required this.deliveryOrderNo,
    required this.shipmentCostNumber,
    required this.shipmentCostStatus,
    required this.textProductDescription,
    required this.loNumber,
    required this.origShipmentNum,
    required this.shipmentTypeCode,
    required this.shipmentTypeDescription,
  });

  factory TrsapShipmentOutboundsRow.fromJson(Map<String, dynamic> json) =>
      TrsapShipmentOutboundsRow(
        shipmentDoOutboundId: json["Shipment_DO_OutboundID"],
        plantCode: json["PlantCode"],
        shipmentNo: json["ShipmentNo"],
        deliveryOrderNo: json["DeliveryOrderNo"],
        shipmentCostNumber: json["ShipmentCostNumber"],
        shipmentCostStatus: json["ShipmentCostStatus"],
        textProductDescription: json["TextProductDescription"],
        loNumber: json["LONumber"],
        origShipmentNum: json["OrigShipmentNum"],
        shipmentTypeCode: json["ShipmentTypeCode"],
        shipmentTypeDescription: json["ShipmentTypeDescription"],
      );
}
