class MsLicenseNos {
  int count;
  List<MsLicenseNosRow> rows;

  MsLicenseNos({
    required this.count,
    required this.rows,
  });

  factory MsLicenseNos.fromJson(Map<String, dynamic> json) => MsLicenseNos(
        count: json["count"],
        rows: List<MsLicenseNosRow>.from(
            json["rows"].map((x) => MsLicenseNosRow.fromJson(x))),
      );
}

class MsLicenseNosRow {
  String? licenseNoId;
  String? driverId;
  String? driver;
  String? email;
  String? licenseNo;
  String? description;
  int status;

  MsLicenseNosRow({
    required this.licenseNoId,
    required this.driverId,
    required this.driver,
    required this.email,
    required this.licenseNo,
    required this.description,
    required this.status,
  });

  factory MsLicenseNosRow.fromJson(Map<String, dynamic> json) =>
      MsLicenseNosRow(
        licenseNoId: json["LicenseNoID"],
        driverId: json["DriverID"],
        driver: json["Driver"],
        email: json["Email"],
        licenseNo: json["LicenseNo"],
        description: json["Description"],
        status: json["Status"],
      );
}
