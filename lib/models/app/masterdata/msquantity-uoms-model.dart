class MSQuantityUOMs {
  int count;
  List<MSQuantityUOMsRow> rows;

  MSQuantityUOMs({
    required this.count,
    required this.rows,
  });

  factory MSQuantityUOMs.fromJson(Map<String, dynamic> json) => MSQuantityUOMs(
        count: json["count"],
        rows: List<MSQuantityUOMsRow>.from(
            json["rows"].map((x) => MSQuantityUOMsRow.fromJson(x))),
      );
}

class MSQuantityUOMsRow {
  String? quantityID;
  String? unit;
  String? description;
  int status;

  MSQuantityUOMsRow({
    required this.quantityID,
    required this.unit,
    required this.description,
    required this.status,
  });

  factory MSQuantityUOMsRow.fromJson(Map<String, dynamic> json) =>
      MSQuantityUOMsRow(
        quantityID: json["QuantityID"],
        unit: json["Unit"],
        description: json["Description"],
        status: json["Status"],
      );
}
