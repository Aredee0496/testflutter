class MsTemplateChecklists {
  int count;
  List<MsTemplateChecklistsRow> rows;

  MsTemplateChecklists({
    required this.count,
    required this.rows,
  });

  factory MsTemplateChecklists.fromJson(Map<String, dynamic> json) =>
      MsTemplateChecklists(
        count: json["count"],
        rows: List<MsTemplateChecklistsRow>.from(
            json["rows"].map((x) => MsTemplateChecklistsRow.fromJson(x))),
      );
}

class MsTemplateChecklistsRow {
  String? templateChecklistId;
  String? templateId;
  String? templateName;
  String? checkListId;
  String? checklist;
  int running;
  int status;

  MsTemplateChecklistsRow({
    required this.templateChecklistId,
    required this.templateId,
    required this.templateName,
    required this.checkListId,
    required this.checklist,
    required this.running,
    required this.status,
  });

  factory MsTemplateChecklistsRow.fromJson(Map<String, dynamic> json) =>
      MsTemplateChecklistsRow(
        templateChecklistId: json["TemplateChecklistID"],
        templateId: json["TemplateID"],
        templateName: json["TemplateName"],
        checkListId: json["CheckListID"],
        checklist: json["Checklist"],
        running: json["Running"],
        status: json["Status"],
      );
}
