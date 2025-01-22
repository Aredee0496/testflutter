class TrWorklists {
  int count;
  List<TrWorklistsRow> rows;

  TrWorklists({
    required this.count,
    required this.rows,
  });

  factory TrWorklists.fromJson(Map<String, dynamic> json) => TrWorklists(
        count: json["count"],
        rows: List<TrWorklistsRow>.from(
            json["rows"].map((x) => TrWorklistsRow.fromJson(x))),
      );
}

class TrWorklistsRow {
  String? worklistId;
  String? worklistDocumentNo;
  String? plant;
  String? workdate;
  String? jobStatus;
  String? jobStatusDescription;
  String? licenseNoId;
  String? licenseNo;
  String? containerNo;
  String? containerNo2;
  String? licenseNo2Id;
  String? licenseNo2;
  String? zDataId;
  dynamic zDataDescription;
  dynamic quantity;
  String? quantityId;
  String? quantityUomUnit;
  dynamic containerNoTypeCode;
  String? containerNoType;
  String? checkInDate;
  String? checkOutDate;
  String? shipmentStartDate;
  String? shipmentEndDate;
  String? containerInDate;
  String? containerOutDate;
  String? mileErrorCode;
  String? mileError;
  dynamic mile1;
  dynamic mile2;
  dynamic distanctKm;
  String? remarkDriver;
  String? remarkAdmin;
  String? remarkEditDocument;
  String? driverName;
  String? workType;
  String? routeCode;
  String? route;
  String? customerCode;
  String? customerName;
  String? productCode;
  String? product;
  String? booking;
  String? booking2;
  dynamic addMoneyRateGroup1;
  dynamic delMoneyRateGroup1;
  dynamic addMoneyRateGroup2;
  dynamic delMoneyRateGroup2;

  TrWorklistsRow({
    required this.worklistId,
    required this.worklistDocumentNo,
    required this.plant,
    required this.workdate,
    required this.jobStatus,
    required this.jobStatusDescription,
    required this.licenseNoId,
    required this.licenseNo,
    required this.containerNo,
    required this.containerNo2,
    required this.licenseNo2Id,
    required this.licenseNo2,
    required this.zDataId,
    required this.zDataDescription,
    required this.quantity,
    required this.quantityId,
    required this.quantityUomUnit,
    required this.containerNoTypeCode,
    required this.containerNoType,
    required this.checkInDate,
    required this.checkOutDate,
    required this.shipmentStartDate,
    required this.shipmentEndDate,
    required this.containerInDate,
    required this.containerOutDate,
    required this.mileErrorCode,
    required this.mileError,
    required this.mile1,
    required this.mile2,
    required this.distanctKm,
    required this.remarkDriver,
    required this.remarkAdmin,
    required this.remarkEditDocument,
    required this.driverName,
    required this.workType,
    required this.routeCode,
    required this.route,
    required this.customerCode,
    required this.customerName,
    required this.productCode,
    required this.product,
    required this.booking,
    required this.booking2,
    required this.addMoneyRateGroup1,
    required this.delMoneyRateGroup1,
    required this.addMoneyRateGroup2,
    required this.delMoneyRateGroup2,
  });

  factory TrWorklistsRow.fromJson(Map<String, dynamic> json) => TrWorklistsRow(
        worklistId: json["WorklistID"],
        worklistDocumentNo: json["WorklistDocumentNo"],
        plant: json["Plant"],
        workdate: json["Workdate"],
        jobStatus: json["JobStatus"],
        jobStatusDescription: json["JobStatusDescription"],
        licenseNoId: json["LicenseNoID"],
        licenseNo: json["LicenseNo"],
        containerNo: json["ContainerNo"],
        containerNo2: json["ContainerNo2"],
        licenseNo2Id: json["LicenseNo2ID"],
        licenseNo2: json["LicenseNo2"],
        zDataId: json["ZDataID"],
        zDataDescription: json["ZDataDescription"],
        quantity: json["Quantity"],
        quantityId: json["QuantityID"],
        quantityUomUnit: json["QuantityUOMUnit"],
        containerNoTypeCode: json["ContainerNoTypeCode"],
        containerNoType: json["ContainerNoType"],
        checkInDate: json["CheckInDate"],
        checkOutDate: json["CheckOutDate"],
        shipmentStartDate: json["ShipmentStartDate"],
        shipmentEndDate: json["ShipmentEndDate"],
        containerInDate: json["ContainerInDate"],
        containerOutDate: json["ContainerOutDate"],
        mileErrorCode: json["MileErrorCode"],
        mileError: json["MileError"],
        mile1: json["Mile1"],
        mile2: json["Mile2"],
        distanctKm: json["DistanctKM"],
        remarkDriver: json["RemarkDriver"],
        remarkAdmin: json["RemarkAdmin"],
        remarkEditDocument: json["RemarkEditDocument"],
        driverName: json["DriverName"],
        workType: json["WorkType"],
        routeCode: json["RouteCode"],
        route: json["Route"],
        customerCode: json["CustomerCode"],
        customerName: json["CustomerName"],
        productCode: json["ProductCode"],
        product: json["Product"],
        booking: json["Booking"],
        booking2: json["Booking2"],
        addMoneyRateGroup1: json["AddMoneyRateGroup1"],
        delMoneyRateGroup1: json["DelMoneyRateGroup1"],
        addMoneyRateGroup2: json["AddMoneyRateGroup2"],
        delMoneyRateGroup2: json["DelMoneyRateGroup2"],
      );
}
