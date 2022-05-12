// To parse this JSON data, do
//
//     final indicesForexModel = indicesForexModelFromJson(jsonString);

import 'dart:convert';

List<IndicesForexModel> indicesForexModelFromJson(String str) =>
    List<IndicesForexModel>.from(
        json.decode(str).map((x) => IndicesForexModel.fromJson(x)));

String indicesForexModelToJson(List<IndicesForexModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IndicesForexModel {
  IndicesForexModel({
    this.data,
    this.indicesId,
  });

  List<Datum> data;
  String indicesId;

  factory IndicesForexModel.fromJson(Map<String, dynamic> json) =>
      IndicesForexModel(
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
    this.chg,
    this.datumChg,
    this.fullName,
    this.high,
    this.low,
    this.name,
    this.price,
    this.symbol,
  });

  String chg;
  String datumChg;
  String fullName;
  String high;
  String low;
  String name;
  String price;
  String symbol;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        chg: json["chg"],
        datumChg: json["chg %"],
        fullName: json["full_name"],
        high: json["high"],
        low: json["low"],
        name: json["name"],
        price: json["price"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "chg": chg,
        "chg %": datumChg,
        "full_name": fullName,
        "high": high,
        "low": low,
        "name": name,
        "price": price,
        "symbol": symbol,
      };
}
