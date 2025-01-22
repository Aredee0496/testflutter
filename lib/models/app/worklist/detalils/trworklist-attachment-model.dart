class TrWorklistAttachment {
  int count;
  List<TrWorklistAttachmentRow> rows;

  TrWorklistAttachment({
    required this.count,
    required this.rows,
  });

  factory TrWorklistAttachment.fromJson(Map<String, dynamic> json) =>
      TrWorklistAttachment(
        count: json["count"],
        rows: List<TrWorklistAttachmentRow>.from(
            json["rows"].map((x) => TrWorklistAttachmentRow.fromJson(x))),
      );
}

class TrWorklistAttachmentRow {
  String? attatmentID;
  String? worklistID;
  String? fileID;
  String? attatchmentName;
  String? attatchmentFullPath;
  int attatchmentTypeCode;
  String? attatchmentType;
  String? createdBy;
  String? createdAt;

  TrWorklistAttachmentRow({
    required this.attatmentID,
    required this.worklistID,
    required this.fileID,
    required this.attatchmentName,
    required this.attatchmentFullPath,
    required this.attatchmentTypeCode,
    required this.attatchmentType,
    required this.createdBy,
    required this.createdAt,
  });

  factory TrWorklistAttachmentRow.fromJson(Map<String, dynamic> json) =>
      TrWorklistAttachmentRow(
        attatmentID: json["AttatmentID"],
        worklistID: json["WorklistID"],
        fileID: json["FileID"],
        attatchmentName: json["AttatchmentName"],
        attatchmentFullPath: json["AttatchmentFullPath"],
        attatchmentTypeCode: json["AttatchmentTypeCode"],
        attatchmentType: json["AttatchmentType"],
        createdBy: json["CreatedBy"],
        createdAt: json["CreatedAt"],
      );
}
