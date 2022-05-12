// To parse this JSON data, do
//
//     final dalalRoadModel = dalalRoadModelFromJson(jsonString);

import 'dart:convert';

List<DalalRoadModel> dalalRoadModelFromJson(String str) =>
    List<DalalRoadModel>.from(
        json.decode(str).map((x) => DalalRoadModel.fromJson(x)));

String dalalRoadModelToJson(List<DalalRoadModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DalalRoadModel {
  DalalRoadModel({
    this.data,
    this.identifier,
  });

  List<Datum> data;
  String identifier;

  factory DalalRoadModel.fromJson(Map<String, dynamic> json) => DalalRoadModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        identifier: json["identifier"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "identifier": identifier,
      };
}

List<Datum> dalalRoadModelDatabaseFromJson(String str) =>
    List<Datum>.from(json.decode(str).map((x) => Datum.fromJson(x)));

String dalalRoadModelDatabaseToJson(List<Datum> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Datum {
  Datum(
      {this.broker,
      this.brokerCode,
      this.company,
      this.reco,
      this.targetPrice,
      this.latestPrice,
      this.latestPricePercent,
      this.potentialPercent,
      this.recoPrice});

  String broker;
  String brokerCode;
  String company;
  Reco reco;
  String targetPrice;
  String latestPrice;
  String latestPricePercent;
  String potentialPercent;
  String recoPrice;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      broker: json["broker"],
      brokerCode: json["broker_code"],
      company: json["company"],
      reco: recoValues.map[json["reco"]],
      targetPrice: json["target_price"],
      latestPrice: json["latest_price"],
      latestPricePercent: json["latest_price%"],
      potentialPercent: json["potential%"],
      recoPrice: json["reco_price"]);

  Map<String, dynamic> toJson() => {
        "broker": broker,
        "broker_code": brokerCode,
        "company": company,
        "reco": recoValues.reverse[reco],
        "target_price": targetPrice,
        "latest_price": latestPrice,
        "latest_price%": latestPricePercent,
        "potential%": potentialPercent,
        "reco_price": recoPrice
      };
}

enum Reco { BUY, SELL, ACCUMULATE, NEUTRAL, REDUCE, ADD, HOLD }

final recoValues = EnumValues({
  "Accumulate": Reco.ACCUMULATE,
  "Add": Reco.ADD,
  "Buy": Reco.BUY,
  "Hold": Reco.HOLD,
  "Neutral": Reco.NEUTRAL,
  "Reduce": Reco.REDUCE,
  "Sell": Reco.SELL
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

// To parse this JSON data, do
//
//     final brokerInitial = brokerInitialFromJson(jsonString);

BrokerInitial brokerInitialFromJson(String str) =>
    BrokerInitial.fromJson(json.decode(str));

String brokerInitialToJson(BrokerInitial data) => json.encode(data.toJson());

class BrokerInitial {
  BrokerInitial({
    this.activeCalls,
    this.averageReturn,
    this.expiredClosed,
    this.holdNeutral,
    this.numberOfCalls,
    this.successRate,
    this.targetHits,
  });

  String activeCalls;
  String averageReturn;
  String expiredClosed;
  String holdNeutral;
  String numberOfCalls;
  String successRate;
  String targetHits;

  factory BrokerInitial.fromJson(Map<String, dynamic> json) => BrokerInitial(
        activeCalls: json["active_calls"],
        averageReturn: json["average_return"],
        expiredClosed: json["expired_closed"],
        holdNeutral: json["hold_neutral"],
        numberOfCalls: json["number_of_calls"],
        successRate: json["success_rate"],
        targetHits: json["target_hits"],
      );

  Map<String, dynamic> toJson() => {
        "active_calls": activeCalls,
        "average_return": averageReturn,
        "expired_closed": expiredClosed,
        "hold_neutral": holdNeutral,
        "number_of_calls": numberOfCalls,
        "success_rate": successRate,
        "target_hits": targetHits,
      };
}
// To parse this JSON data, do
//
//     final brokerRecomendation = brokerRecomendationFromJson(jsonString);

List<BrokerRecomendation> brokerRecomendationFromJson(String str) =>
    List<BrokerRecomendation>.from(
        json.decode(str).map((x) => BrokerRecomendation.fromJson(x)));

String brokerRecomendationToJson(List<BrokerRecomendation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrokerRecomendation {
  BrokerRecomendation(
      {this.company,
      this.reco,
      this.marketsmojoId,
      this.targetPrice,
      this.latestPrice,
      this.latestPricePrecent,
      this.potentialPercent,
      this.recoPrice});

  String company;
  Reco2 reco;
  String marketsmojoId;
  String targetPrice;
  String latestPrice;
  String latestPricePrecent;
  String potentialPercent;
  String recoPrice;

  factory BrokerRecomendation.fromJson(Map<String, dynamic> json) =>
      BrokerRecomendation(
          company: json["company"],
          marketsmojoId: json["marketsmojo_id"],
          reco: recoValues2.map[json["reco"]],
          targetPrice: json["target_price"],
          latestPrice: json["latest_price"],
          latestPricePrecent: json["latest_price%"],
          potentialPercent: json["potential%"],
          recoPrice: json["reco price"]);

  Map<String, dynamic> toJson() => {
        "company": company,
        "reco": recoValues2.reverse[reco],
        "target_price": targetPrice,
        "latest_price": latestPrice,
        "latest_price%": latestPricePrecent,
        "potential%": potentialPercent,
        "reco price": recoPrice
      };
}

enum Reco2 { BUY, REDUCE, ACCUMULATE, HOLD, SELL }

final recoValues2 = EnumValues({
  "Accumulate": Reco2.ACCUMULATE,
  "Buy": Reco2.BUY,
  "Hold": Reco2.HOLD,
  "Reduce": Reco2.REDUCE,
  "Sell": Reco2.SELL
});
