// To parse this JSON data, do
//
//     final forexModel = forexModelFromJson(jsonString);

import 'dart:convert';

import 'package:technical_ind/screens/watchlist/forex.dart';

ForexModel forexModelFromJson(String str) =>
    ForexModel.fromJson(json.decode(str));

String forexModelToJson(ForexModel data) => json.encode(data.toJson());

class ForexModel {
  ForexModel({
    this.forexList,
  });

  List<ForexList> forexList;

  factory ForexModel.fromJson(Map<String, dynamic> json) => ForexModel(
        forexList: List<ForexList>.from(
            json["forex_list"].map((x) => ForexList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "forex_list": List<dynamic>.from(forexList.map((x) => x.toJson())),
      };
}

class ForexList {
  ForexList({
    this.ask,
    this.bid,
    this.change,
    this.changePercent,
    this.high,
    this.low,
    this.name,
    this.price,
  });

  String ask;
  String bid;
  String change;
  String changePercent;
  String high;
  String low;
  String name;
  String price;

  factory ForexList.fromJson(Map<String, dynamic> json) => ForexList(
        ask: json["Ask"],
        bid: json["Bid"],
        change: json["Change"],
        changePercent: json["Change Percent"],
        high: json["High"],
        low: json["Low"],
        name: json["Name"],
        price: json["Price"],
      );

  Map<String, dynamic> toJson() => {
        "Ask": ask,
        "Bid": bid,
        "Change": change,
        "Change Percent": changePercent,
        "High": high,
        "Low": low,
        "Name": name,
        "Price": price,
      };
}

ForexWatch watchlistForexFromJson(String str) =>
    ForexWatch.fromJson(json.decode(str));

class ForexWatch {
  ForexWatch({this.name, this.price, this.chng, this.chngPercent});

  String name, price, chng, chngPercent;

  factory ForexWatch.fromJson(Map<String, dynamic> json) => ForexWatch(
      name: json["name"],
      price: json["price"],
      chng: json["change"],
      chngPercent: json["change_percent"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "change": chng,
        "change_percent": chngPercent
      };
}
