class MsJobStatuss {
  int count;
  List<MsJobStatussRow> rows;

  MsJobStatuss({
    required this.count,
    required this.rows,
  });

  factory MsJobStatuss.fromJson(Map<String, dynamic> json) => MsJobStatuss(
        count: json["count"],
        rows: List<MsJobStatussRow>.from(
            json["rows"].map((x) => MsJobStatussRow.fromJson(x))),
      );
}

class MsJobStatussRow {
  String? jobStatusCode;
  String description;
  int? seq;
  int status;

  MsJobStatussRow({
    this.jobStatusCode,
    required this.description,
    this.seq,
    required this.status,
  });

  factory MsJobStatussRow.fromJson(Map<String, dynamic> json) =>
      MsJobStatussRow(
        jobStatusCode: json["JobStatusCode"],
        description: json["Description"],
        seq: json["Seq"],
        status: json["Status"],
      );
}
