// To parse this JSON data, do
//
//     final indicesGlobalModel = indicesGlobalModelFromJson(jsonString);

import 'dart:convert';

List<IndicesGlobalModel> indicesGlobalModelFromJson(String str) =>
    List<IndicesGlobalModel>.from(
        json.decode(str).map((x) => IndicesGlobalModel.fromJson(x)));

String indicesGlobalModelToJson(List<IndicesGlobalModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IndicesGlobalModel {
  IndicesGlobalModel({
    this.data,
    this.identifier,
  });

  List<Datum> data;
  String identifier;

  factory IndicesGlobalModel.fromJson(Map<String, dynamic> json) =>
      IndicesGlobalModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        identifier: json["identifier"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "identifier": identifier,
      };
}

class Datum {
  Datum({
    this.chg,
    this.datumChg,
    this.high,
    this.last,
    this.low,
    this.name,
  });

  String chg;
  String datumChg;
  String high;
  String last;
  String low;
  String name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        chg: json["Chg"],
        datumChg: json["Chg_%"],
        high: json["High"],
        last: json["Last"],
        low: json["Low"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Chg": chg,
        "Chg_%": datumChg,
        "High": high,
        "Last": last,
        "Low": low,
        "Name": name,
      };
}

GlobalIndiceWatchModel watchlistGlobalIndiceFromJson(String str) =>
    GlobalIndiceWatchModel.fromJson(json.decode(str));

class GlobalIndiceWatchModel {
  GlobalIndiceWatchModel({this.name, this.chng, this.chngPercent, this.price});
  String name, chng, chngPercent, price;

  factory GlobalIndiceWatchModel.fromJson(Map<String, dynamic> json) =>
      GlobalIndiceWatchModel(
          name: json["indices_name"] == null
              ? json["name"]
              : json["indices_name"],
          chng:
              json["price_change"] == null ? json["chg"] : json["price_change"],
          chngPercent: json["price_change_percentage"] != null
              ? json["price_change_percentage"]
              : json["chg_percent"],
          price: json["price"]);

  Map<String, dynamic> toJson() => {
        "indices_name": name,
        "price": price,
        "price_change": chng,
        "price_change_percentage": chngPercent
      };
}
