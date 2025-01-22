class MszDatas {
  int count;
  List<MszDatasRow> rows;

  MszDatas({
    required this.count,
    required this.rows,
  });

  factory MszDatas.fromJson(Map<String, dynamic> json) => MszDatas(
        count: json["count"],
        rows: List<MszDatasRow>.from(
            json["rows"].map((x) => MszDatasRow.fromJson(x))),
      );
}

class MszDatasRow {
  String? zDataId;
  String? shippingTypeId;
  String? shippingType;
  String? specProcessId;
  String? specProcess;
  String? description;
  int status;

  MszDatasRow({
    required this.zDataId,
    required this.shippingTypeId,
    required this.shippingType,
    required this.specProcessId,
    required this.specProcess,
    required this.description,
    required this.status,
  });

  factory MszDatasRow.fromJson(Map<String, dynamic> json) => MszDatasRow(
        zDataId: json["ZDataID"],
        shippingTypeId: json["ShippingTypeID"],
        shippingType: json["ShippingType"],
        specProcessId: json["SpecProcessID"],
        specProcess: json["SpecProcess"],
        description: json["Description"],
        status: json["Status"],
      );
}
