// To parse this JSON data, do
//
//     final indicesMcxModel = indicesMcxModelFromJson(jsonString);

import 'dart:convert';

List<IndicesMcxModel> indicesMcxModelFromJson(String str) =>
    List<IndicesMcxModel>.from(
        json.decode(str).map((x) => IndicesMcxModel.fromJson(x)));

String indicesMcxModelToJson(List<IndicesMcxModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IndicesMcxModel {
  IndicesMcxModel({
    this.data,
    this.indicesId,
  });

  List<Datum> data;
  String indicesId;

  factory IndicesMcxModel.fromJson(Map<String, dynamic> json) =>
      IndicesMcxModel(
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
    this.mcxbulldex,
    this.mcxmetldex,
  });

  Mcxldex mcxbulldex;
  Mcxldex mcxmetldex;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        mcxbulldex: json["MCXBULLDEX"] == null
            ? null
            : Mcxldex.fromJson(json["MCXBULLDEX"]),
        mcxmetldex: json["MCXMETLDEX"] == null
            ? null
            : Mcxldex.fromJson(json["MCXMETLDEX"]),
      );

  Map<String, dynamic> toJson() => {
        "MCXBULLDEX": mcxbulldex == null ? null : mcxbulldex.toJson(),
        "MCXMETLDEX": mcxmetldex == null ? null : mcxmetldex.toJson(),
      };
}

class Mcxldex {
  Mcxldex({
    this.spot,
    this.futures,
  });

  Futures spot;
  Futures futures;

  factory Mcxldex.fromJson(Map<String, dynamic> json) => Mcxldex(
        spot: json["SPOT"] == null ? null : Futures.fromJson(json["SPOT"]),
        futures:
            json["Future"] == null ? null : Futures.fromJson(json["Future"]),
      );

  Map<String, dynamic> toJson() => {
        "SPOT": spot == null ? null : spot.toJson(),
        "Future": futures == null ? null : futures.toJson(),
      };
}

class Futures {
  Futures({
    this.change,
    this.changePercent,
    this.date,
    this.highLow,
    this.open,
    this.previousClose,
    this.price,
  });

  String change;
  String changePercent;
  String date;
  String highLow;
  String open;
  String previousClose;
  String price;

  factory Futures.fromJson(Map<String, dynamic> json) => Futures(
        change: json["Change "],
        changePercent: json["Change %"],
        date: json["Date"],
        highLow: json["High / Low"],
        open: json["Open"],
        previousClose: json["Previous Close"],
        price: json["Price"],
      );

  Map<String, dynamic> toJson() => {
        "Change ": change,
        "Change %": changePercent,
        "Date": date,
        "High / Low": highLow,
        "Open": open,
        "Previous Close": previousClose,
        "Price": price,
      };
}
