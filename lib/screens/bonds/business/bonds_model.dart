// To parse this JSON data, do
//
//     final bondsModel = bondsModelFromJson(jsonString);

import 'dart:convert';

List<BondsModel> bondsModelFromJson(String str) =>
    List<BondsModel>.from(json.decode(str).map((x) => BondsModel.fromJson(x)));

String bondsModelToJson(List<BondsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BondsModel {
  BondsModel({
    this.data,
    this.identifier,
  });

  Data data;
  String identifier;

  factory BondsModel.fromJson(Map<String, dynamic> json) => BondsModel(
        data: Data.fromJson(json["data"]),
        identifier: json["identifier"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "identifier": identifier,
      };
}

class Data {
  Data({
    this.bse,
    this.global,
    this.nse,
  });

  List<Bse> bse;
  List<Global> global;
  List<Bse> nse;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bse: List<Bse>.from(json["bse"].map((x) => Bse.fromJson(x))),
        global:
            List<Global>.from(json["global"].map((x) => Global.fromJson(x))),
        nse: List<Bse>.from(json["nse"].map((x) => Bse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bse": List<dynamic>.from(bse.map((x) => x.toJson())),
        "global": List<dynamic>.from(global.map((x) => x.toJson())),
        "nse": List<dynamic>.from(nse.map((x) => x.toJson())),
      };
}

class Bse {
  Bse({
    this.bseId,
    this.chgPercent,
    this.companyName,
    this.faceValue,
    this.high,
    this.low,
    this.open,
    this.price,
    this.volume,
    this.series,
  });

  String bseId;
  String chgPercent;
  String companyName;
  String faceValue;
  String high;
  String low;
  String open;
  String price;
  String volume;
  String series;

  factory Bse.fromJson(Map<String, dynamic> json) => Bse(
        bseId: json["bse_id"] == null ? null : json["bse_id"],
        chgPercent: json["chg_percent"],
        companyName: json["company_name"],
        faceValue: json["face_value"],
        high: json["high"],
        low: json["low"],
        open: json["open"],
        price: json["price"],
        volume: json["volume"],
        series: json["series"] == null ? null : json["series"],
      );

  Map<String, dynamic> toJson() => {
        "bse_id": bseId == null ? null : bseId,
        "chg_percent": chgPercent,
        "company_name": companyName,
        "face_value": faceValue,
        "high": high,
        "low": low,
        "open": open,
        "price": price,
        "volume": volume,
        "series": series == null ? null : series,
      };
}

class Global {
  Global({
    this.chg,
    this.chgPercent,
    this.coupon,
    this.fullName,
    this.high,
    this.imgUrl,
    this.low,
    this.maturityDate,
    this.shortName,
    this.globalYield,
  });

  String chg;
  String chgPercent;
  String coupon;
  String fullName;
  String high;
  String imgUrl;
  String low;
  String maturityDate;
  String shortName;
  String globalYield;

  factory Global.fromJson(Map<String, dynamic> json) => Global(
        chg: json["chg"],
        chgPercent: json["chg_percent"],
        coupon: json["coupon"],
        fullName: json["full_name"],
        high: json["high"],
        imgUrl: json["img_url"],
        low: json["low"],
        maturityDate: json["maturity_date"],
        shortName: json["short_name"],
        globalYield: json["yield"],
      );

  Map<String, dynamic> toJson() => {
        "chg": chg,
        "chg_percent": chgPercent,
        "coupon": coupon,
        "full_name": fullName,
        "high": high,
        "img_url": imgUrl,
        "low": low,
        "maturity_date": maturityDate,
        "short_name": shortName,
        "yield": globalYield,
      };
}
