// To parse this JSON data, do
//
//     final feedbackModel = feedbackModelFromJson(jsonString);

import 'dart:convert';

List<FeedbackModel> feedbackModelFromJson(String str) =>
    List<FeedbackModel>.from(
        json.decode(str).map((x) => FeedbackModel.fromJson(x)));

String feedbackModelToJson(List<FeedbackModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedbackModel {
  FeedbackModel({
    this.message,
    this.error,
  });

  String message;
  bool error;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        message: json["Message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "error": error,
      };
}
