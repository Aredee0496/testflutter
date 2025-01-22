class TrWorklistEvaluations {
  int count;
  List<TrWorklistEvaluationsRow> rows;

  TrWorklistEvaluations({
    required this.count,
    required this.rows,
  });

  factory TrWorklistEvaluations.fromJson(Map<String, dynamic> json) =>
      TrWorklistEvaluations(
        count: json["count"],
        rows: List<TrWorklistEvaluationsRow>.from(
            json["rows"].map((x) => TrWorklistEvaluationsRow.fromJson(x))),
      );
}

class TrWorklistEvaluationsRow {
  String evalId;
  String worklistId;
  String templateId;
  String templateName;
  String checkListId;
  String checklist;
  int running;
  String result;
  int option1;
  int option2;
  int option3;

  TrWorklistEvaluationsRow({
    required this.evalId,
    required this.worklistId,
    required this.templateId,
    required this.templateName,
    required this.checkListId,
    required this.checklist,
    required this.running,
    required this.result,
    required this.option1,
    required this.option2,
    required this.option3,
  });

  factory TrWorklistEvaluationsRow.fromJson(Map<String, dynamic> json) =>
      TrWorklistEvaluationsRow(
        evalId: json["EvalID"],
        worklistId: json["WorklistID"],
        templateId: json["TemplateID"],
        templateName: json["TemplateName"],
        checkListId: json["CheckListID"],
        checklist: json["Checklist"],
        running: json["Running"],
        result: json["Result"],
        option1: json["Option1"],
        option2: json["Option2"],
        option3: json["Option3"],
      );
}
