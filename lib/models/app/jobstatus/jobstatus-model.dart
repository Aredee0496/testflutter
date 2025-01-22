// To parse this JSON data, do
//
//     final jobStatusModel = jobStatusModelFromJson(jsonString);

import 'dart:convert';

JobStatusModel jobStatusModelFromJson(String str) =>
    JobStatusModel.fromJson(json.decode(str));

String jobStatusModelToJson(JobStatusModel data) => json.encode(data.toJson());

class JobStatusModel {
  String jobStatusCode;
  String description;
  int seq;

  JobStatusModel({
    required this.jobStatusCode,
    required this.description,
    required this.seq,
  });

  factory JobStatusModel.fromJson(Map<String, dynamic> json) => JobStatusModel(
        jobStatusCode: json["JobStatusCode"],
        description: json["Description"],
        seq: json["Seq"],
      );

  Map<String, dynamic> toJson() => {
        "JobStatusCode": jobStatusCode,
        "Description": description,
        "Seq": seq,
      };
}
