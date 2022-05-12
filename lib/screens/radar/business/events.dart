// To parse this JSON data, do
//
//     final eventsModel = eventsModelFromJson(jsonString);

import 'dart:convert';

List<EventsModel> eventsModelFromJson(String str) => List<EventsModel>.from(
    json.decode(str).map((x) => EventsModel.fromJson(x)));

String eventsModelToJson(List<EventsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventsModel {
  EventsModel({this.date, this.stock, this.type, this.tredlineId});

  DateTime date;
  String stock;
  String type;
  String tredlineId;

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
        date: DateTime.parse(json["date"]),
        stock: json["stock"],
        type: json["type"],
        tredlineId: json["trendlyne_id"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "stock": stock,
        "type": type,
      };
}
