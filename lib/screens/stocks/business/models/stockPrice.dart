// To parse this JSON data, do
//
//     final stockPrice = stockPriceFromJson(jsonString);

import 'dart:convert';

StockPrice stockPriceFromJson(String str) =>
    StockPrice.fromJson(json.decode(str));

String stockPriceToJson(List<StockPrice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockPrice {
  StockPrice({
    this.bse,
    this.nse,
  });

  Bse bse;
  Bse nse;

  factory StockPrice.fromJson(Map<String, dynamic> json) => StockPrice(
        bse: json["bse"] == null ? null : Bse.fromJson(json["bse"]),
        nse: json["nse"] == null ? null : Bse.fromJson(json["nse"]),
      );

  Map<String, dynamic> toJson() => {
        "bse": bse.toJson(),
        "nse": nse.toJson(),
      };
}

class Bse {
  Bse({
    this.change,
    this.changePercent,
    this.price,
  });

  String change;
  String changePercent;
  String price;

  factory Bse.fromJson(Map<String, dynamic> json) => Bse(
        change: json["change"] == null ? null : json["change"],
        changePercent:
            json["change_percent"] == null ? null : json["change_percent"],
        price: json["price"] == null ? null : json["price"],
      );

  Map<String, dynamic> toJson() => {
        "change": change,
        "change_percent": changePercent,
        "price": price,
      };
}
