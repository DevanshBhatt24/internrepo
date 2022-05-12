// To parse this JSON data, do
//
//     final commodityModel = commodityModelFromJson(jsonString);

import 'dart:convert';

CommodityModel commodityModelFromJson(String str) =>
    CommodityModel.fromJson(json.decode(str));

// List<CommodityModel> commodityModelFromJson(String str) =>
//     List<CommodityModel>.from(
//         json.decode(str).map((x) => CommodityModel.fromJson(x)));

String commodityModelToJson(List<CommodityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommodityModel {
  CommodityModel({this.mcx, this.comex, this.ncdex});

  List<Mcx> mcx;
  List<Comex> comex;
  List<Ncdex> ncdex;

  factory CommodityModel.fromJson(Map<String, dynamic> json) => CommodityModel(
        mcx: List<Mcx>.from(json["MCX"].map((x) => Mcx.fromJson(x))),
        comex: List<Comex>.from(json["COMEX"].map((x) => Comex.fromJson(x))),
        ncdex: List<Ncdex>.from(json["NCDEX"].map((x) => Ncdex.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "MCX": mcx,
        "COMEX": comex,
        "NCDEX": ncdex,
      };
}

class Data {
  Data({
    this.mcx,
    this.ncdex,
  });

  List<Mcx> mcx;
  List<Ncdex> ncdex;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        mcx: List<Mcx>.from(json["MCX"].map((x) => Mcx.fromJson(x))),
        ncdex: List<Ncdex>.from(json["NCDEX"].map((x) => Ncdex.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "MCX": List<dynamic>.from(mcx.map((x) => x.toJson())),
        "NCDEX": List<dynamic>.from(ncdex.map((x) => x.toJson())),
      };
}

class Mcx {
  Mcx({
    this.change,
    this.chgPercentage,
    this.high,
    this.close,
    this.individualUrl,
    this.low,
    this.name,
    this.open,
    this.price,
  });

  String change;
  String chgPercentage;
  String high;
  String open;
  String low;
  String price;
  String name;
  String individualUrl;
  String close;

  factory Mcx.fromJson(Map<String, dynamic> json) => Mcx(
      change: json["chg"],
      chgPercentage: json["chg%"],
      high: json["high"],
      close: json["close"],
      low: json["low"],
      individualUrl: json["individual_url"],
      name: json["name"],
      price: json["price"],
      open: json["open"]);

  Map<String, dynamic> toJson() => {
        "chg": change,
        "chg%": chgPercentage,
        "high": high,
        "price": price,
        "low": low,
        "individual_url": individualUrl,
        "name": name,
        "close": close,
        "open": open
      };
}

class Ncdex {
  Ncdex({
    this.chg,
    this.chgPercentage,
    this.high,
    this.close,
    this.individualUrl,
    this.low,
    this.name,
    this.open,
    this.price,
  });

  String chg;
  String chgPercentage;
  String high;
  String open;
  String low;
  String price;
  String name;
  String individualUrl;
  String close;

  factory Ncdex.fromJson(Map<String, dynamic> json) => Ncdex(
      chg: json["chg"],
      chgPercentage: json["chg%"],
      high: json["high"],
      close: json["close"],
      low: json["low"],
      individualUrl: json["individual_url"],
      name: json["name"],
      price: json["price"],
      open: json["open"]);

  Map<String, dynamic> toJson() => {
        "chg": chg,
        "chg%": chgPercentage,
        "high": high,
        "price": price,
        "low": low,
        "individual_url": individualUrl,
        "name": name,
        "close": close,
        "open": open
      };
}

class Comex {
  Comex({
    this.chg,
    this.chgPercentage,
    this.high,
    this.close,
    this.individualUrl,
    this.low,
    this.name,
    this.open,
    this.price,
  });

  String chg;
  String chgPercentage;
  String high;
  String open;
  String low;
  String price;
  String name;
  String individualUrl;
  String close;

  factory Comex.fromJson(Map<String, dynamic> json) => Comex(
      chg: json["chg"],
      chgPercentage: json["chg%"],
      high: json["high"],
      close: json["close"],
      low: json["low"],
      individualUrl: json["individual_url"],
      name: json["name"],
      price: json["price"],
      open: json["open"]);

  Map<String, dynamic> toJson() => {
        "chg": chg,
        "chg%": chgPercentage,
        "high": high,
        "price": price,
        "low": low,
        "individual_url": individualUrl,
        "name": name,
        "close": close,
        "open": open
      };
}
