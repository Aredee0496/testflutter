class TrWorklistExpensesRateGroup {
  int count;
  List<TrWorklistExpensesRateGroup1Row> rows;

  TrWorklistExpensesRateGroup({
    required this.count,
    required this.rows,
  });

  factory TrWorklistExpensesRateGroup.fromJson(Map<String, dynamic> json) =>
      TrWorklistExpensesRateGroup(
        count: json["count"],
        rows: List<TrWorklistExpensesRateGroup1Row>.from(json["rows"]
            .map((x) => TrWorklistExpensesRateGroup1Row.fromJson(x))),
      );
}

class TrWorklistExpensesRateGroup1Row {
  String expenId;
  String worklistId;
  int rateGroup;
  int seq;
  String rateId;
  String rate;
  int price;
  String rateUnit;
  int rateAmount;
  int rateSum;

  TrWorklistExpensesRateGroup1Row({
    required this.expenId,
    required this.worklistId,
    required this.rateGroup,
    required this.seq,
    required this.rateId,
    required this.rate,
    required this.price,
    required this.rateUnit,
    required this.rateAmount,
    required this.rateSum,
  });

  factory TrWorklistExpensesRateGroup1Row.fromJson(Map<String, dynamic> json) =>
      TrWorklistExpensesRateGroup1Row(
        expenId: json["ExpenID"],
        worklistId: json["WorklistID"],
        rateGroup: json["RateGroup"],
        seq: json["Seq"],
        rateId: json["RateID"],
        rate: json["Rate"],
        price: json["Price"],
        rateUnit: json["RateUnit"],
        rateAmount: json["RateAmount"],
        rateSum: json["RateSum"],
      );
}
