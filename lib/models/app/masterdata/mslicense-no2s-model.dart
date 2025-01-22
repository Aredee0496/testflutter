class MsLicenseNo2s {
  int count;
  List<MsLicenseNo2sRow> rows;

  MsLicenseNo2s({
    required this.count,
    required this.rows,
  });

  factory MsLicenseNo2s.fromJson(Map<String, dynamic> json) => MsLicenseNo2s(
        count: json["count"],
        rows: List<MsLicenseNo2sRow>.from(
            json["rows"].map((x) => MsLicenseNo2sRow.fromJson(x))),
      );
}

class MsLicenseNo2sRow {
  String? licenseNo2Id;
  String? licenseNo2;
  String? description;
  int status;

  MsLicenseNo2sRow({
    required this.licenseNo2Id,
    required this.licenseNo2,
    required this.description,
    required this.status,
  });

  factory MsLicenseNo2sRow.fromJson(Map<String, dynamic> json) =>
      MsLicenseNo2sRow(
        licenseNo2Id: json["LicenseNo2ID"],
        licenseNo2: json["LicenseNo2"],
        description: json["Description"],
        status: json["Status"],
      );
}
