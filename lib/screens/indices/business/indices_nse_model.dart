// To parse this JSON data, do
//
//     final indicesNseModel = indicesNseModelFromJson(jsonString);

import 'dart:convert';

List<IndicesNseModel> indicesNseModelFromJson(String str) =>
    List<IndicesNseModel>.from(
        json.decode(str).map((x) => IndicesNseModel.fromJson(x)));

String indicesNseModelToJson(List<IndicesNseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IndicesNseModel {
  IndicesNseModel({
    this.data,
    this.indicesId,
  });

  List<Datum> data;
  String indicesId;

  factory IndicesNseModel.fromJson(Map<String, dynamic> json) =>
      IndicesNseModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        indicesId: json["indices_id"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "indices_id": indicesId,
      };
}

class Datum {
  Datum({
    this.change,
    this.high,
    this.low,
    this.datumChange,
    this.currentValue,
    this.indexUrl,
    this.name,
    this.open,
  });

  String change;
  String high;
  String low;
  String datumChange;
  String currentValue;
  String indexUrl;
  String name;
  String open;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        change: json["Change %"],
        high: json["High"],
        low: json["Low"],
        datumChange: json["change"],
        currentValue: json["current_value"],
        indexUrl: json["index_url"],
        name: json["name"],
        open: json["open"],
      );

  Map<String, dynamic> toJson() => {
        "Change %": change,
        "High": high,
        "Low": low,
        "change": datumChange,
        "current_value": currentValue,
        "index_url": indexUrl,
        "name": name,
        "open": open,
      };
}
