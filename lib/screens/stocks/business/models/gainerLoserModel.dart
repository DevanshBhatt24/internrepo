// To parse this JSON data, do
//
//     final gainersLosersModel = gainersLosersModelFromJson(jsonString);

import 'dart:convert';

GainersLosersModel gainersLosersModelFromJson(String str) =>
    GainersLosersModel.fromJson(json.decode(str));

String gainersLosersModelToJson(GainersLosersModel data) =>
    json.encode(data.toJson());

class GainersLosersModel {
  GainersLosersModel({
    this.gainer,
  });

  List<Gainer> gainer;

  factory GainersLosersModel.fromJson(Map<String, dynamic> json) =>
      GainersLosersModel(
        gainer:
            List<Gainer>.from(json["gainer"].map((x) => Gainer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "gainer": List<dynamic>.from(gainer.map((x) => x.toJson())),
      };
}

class Gainer {
  Gainer({
    this.chg,
    // this.change,
    this.companyName,
    this.high,
    this.low,
    this.prevClose,
    this.price,
    this.stockCode,
  });

  String chg;
  // String change;
  String companyName;
  String high;
  String low;
  String prevClose;
  String price;
  String stockCode;

  factory Gainer.fromJson(Map<String, dynamic> json) => Gainer(
        chg: json["% Chg"],
        // change: json["Change"],
        companyName: json["Company Name"],
        high: json["High"],
        low: json["Low"],
        prevClose: json["Prev Close"],
        price: json["Price"],
        stockCode: json["stock_code"],
      );

  Map<String, dynamic> toJson() => {
        "% Chg": chg,
        // "Change": change,
        "Company Name": companyName,
        "High": high,
        "Low": low,
        "Prev Close": prevClose,
        "Price": price,
        "stock_code": stockCode,
      };
}
