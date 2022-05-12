// To parse this JSON data, do
//
//     final mostActiveStocksModel = mostActiveStocksModelFromJson(jsonString);

import 'dart:convert';

MostActiveStocksModel mostActiveStocksModelFromJson(String str) =>
    MostActiveStocksModel.fromJson(json.decode(str));

String mostActiveStocksModelToJson(MostActiveStocksModel data) =>
    json.encode(data.toJson());

class MostActiveStocksModel {
  MostActiveStocksModel({
    this.bseMostActive,
  });

  List<BseMostActive> bseMostActive;

  factory MostActiveStocksModel.fromJson(Map<String, dynamic> json) =>
      MostActiveStocksModel(
        bseMostActive: List<BseMostActive>.from(
            json["bse_most_active"].map((x) => BseMostActive.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bse_most_active":
            List<dynamic>.from(bseMostActive.map((x) => x.toJson())),
      };
}

class BseMostActive {
  BseMostActive({
    this.chg,
    // this.change,
    this.companyName,
    this.high,
    this.low,
    this.price,
    this.valueRsCr,
    this.stockCode,
  });

  String chg;
  // String change;
  String companyName;
  String high;
  String low;
  String price;
  String valueRsCr;
  String stockCode;

  factory BseMostActive.fromJson(Map<String, dynamic> json) => BseMostActive(
        chg: json["% Chg"],
        // change: json["Change"],
        companyName: json["Company Name"],
        high: json["High"],
        low: json["Low"],
        price: json["Price"],
        valueRsCr: json["Value (Rs Cr)"],
        stockCode: json["stock_code"],
      );

  Map<String, dynamic> toJson() => {
        "% Chg": chg,
        // "Change": change,
        "Company Name": companyName,
        "High": high,
        "Low": low,
        "Price": price,
        "Value (Rs Cr)": valueRsCr,
        "stock_code": stockCode,
      };
}
