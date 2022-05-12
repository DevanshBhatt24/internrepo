// To parse this JSON data, do
//
//     final weekHighLow = weekHighLowFromJson(jsonString);

import 'dart:convert';

WeekHighLow weekHighLowFromJson(String str) =>
    WeekHighLow.fromJson(json.decode(str));

String weekHighLowToJson(WeekHighLow data) => json.encode(data.toJson());

class WeekHighLow {
  WeekHighLow({
    this.highLow,
  });

  List<HighLow> highLow;

  factory WeekHighLow.fromJson(var json) => WeekHighLow(
        highLow: List<HighLow>.from(json.map((x) => HighLow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "high_low": List<dynamic>.from(highLow.map((x) => x.toJson())),
      };
}

class HighLow {
  HighLow({
    this.chg,
    // this.change,
    this.companyName,
    this.high,
    this.low,
    this.price,
    this.stockCode,
  });

  String chg;
  // String change;
  String companyName;
  String high;
  String low;
  String price;
  String stockCode;

  factory HighLow.fromJson(Map<String, dynamic> json) => HighLow(
        chg: json["% Chg"],
        // change: json["Change"],
        companyName: json["Company Name"],
        high: json["High"],
        low: json["Low"],
        price: json["Price"],
        stockCode: json["stock_code"],
      );

  Map<String, dynamic> toJson() => {
        "% Chg": chg,
        // "Change": change,
        "Company Name": companyName,
        "High": high,
        "Low": low,
        "Price": price,
        "stock_code": stockCode,
      };
}
