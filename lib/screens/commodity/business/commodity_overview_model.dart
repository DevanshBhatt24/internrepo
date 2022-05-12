// To parse this JSON data, do
//
//     final commodityOverviewModel = commodityOverviewModelFromJson(jsonString);

import 'dart:convert';

CommodityOverviewModel commodityOverviewModelFromJson(String str) =>
    CommodityOverviewModel.fromJson(json.decode(str));

String commodityOverviewModelToJson(CommodityOverviewModel data) =>
    json.encode(data.toJson());

class CommodityOverviewModel {
  CommodityOverviewModel({
    this.historicalData,
    this.overview,
    this.technicalIndicator,
  });

  HistoricalData historicalData;
  Overview overview;
  CommodityOverviewModelTechnicalIndicator technicalIndicator;

  factory CommodityOverviewModel.fromJson(Map<String, dynamic> json) =>
      CommodityOverviewModel(
        historicalData: HistoricalData.fromJson(json["historical_data"]),
        overview: Overview.fromJson(json["overview"]),
        technicalIndicator: CommodityOverviewModelTechnicalIndicator.fromJson(
            json["technical_indicator"]),
      );

  Map<String, dynamic> toJson() => {
        "historical_data": historicalData.toJson(),
        "overview": overview.toJson(),
        "technical_indicator": technicalIndicator.toJson(),
      };
}

class HistoricalData {
  HistoricalData({
    this.daily,
    this.monthly,
    this.weekly,
  });

  List<Daily> daily;
  List<Daily> monthly;
  List<Daily> weekly;

  factory HistoricalData.fromJson(Map<String, dynamic> json) => HistoricalData(
        daily: json != null
            ? List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x)))
            : [],
        monthly: json != null
            ? List<Daily>.from(json["monthly"].map((x) => Daily.fromJson(x)))
            : [],
        weekly: json != null
            ? List<Daily>.from(json["weekly"].map((x) => Daily.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
        "monthly": List<dynamic>.from(monthly.map((x) => x.toJson())),
        "weekly": List<dynamic>.from(weekly.map((x) => x.toJson())),
      };
}

class Daily {
  Daily({
    this.chgPercent,
    this.date,
    this.high,
    this.low,
    this.open,
    this.price,
    this.volume,
  });

  String chgPercent;
  String date;
  String high;
  String low;
  String open;
  String price;
  String volume;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        chgPercent: json["chg_percent"],
        date: json["date"],
        high: json["high"],
        low: json["low"],
        open: json["open"],
        price: json["price"],
        volume: json["volume"],
      );

  Map<String, dynamic> toJson() => {
        "chg_percent": chgPercent,
        "date": date,
        "high": high,
        "low": low,
        "open": open,
        "price": price,
        "volume": volume,
      };
}

class Overview {
  Overview({
    this.dates,
    this.values,
  });

  List<String> dates;
  List<Value> values;

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
        dates: List<String>.from(json["dates"].map((x) => x)),
        values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dates": List<dynamic>.from(dates.map((x) => x)),
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
      };
}

class Value {
  Value({
    this.bidPrice,
    this.averagePrice,
    this.bidQuantity,
    this.changeInOi,
    this.chgChgpercent,
    this.high,
    this.low,
    this.marketLot,
    this.offerPrice,
    this.offerQuantity,
    this.open,
    this.openInterest,
    this.price,
    this.volume,
  });

  String bidPrice;
  String averagePrice;
  String bidQuantity;
  String changeInOi;
  String chgChgpercent;
  String high;
  String low;
  String marketLot;
  String offerPrice;
  String offerQuantity;
  String open;
  String openInterest;
  String price;
  String volume;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        bidPrice: json["Bid_price"],
        averagePrice: json["average_price"],
        bidQuantity: json["bid_quantity"],
        changeInOi: json["change_in_oi"],
        chgChgpercent: json["chg_chgpercent"],
        high: json["high"],
        low: json["low"],
        marketLot: json["market_lot"],
        offerPrice: json["offer_price"],
        offerQuantity: json["offer_quantity"],
        open: json["open"],
        openInterest: json["open_interest"],
        price: json["price"],
        volume: json["volume"],
      );

  Map<String, dynamic> toJson() => {
        "Bid_price": bidPrice,
        "average_price": averagePrice,
        "bid_quantity": bidQuantity,
        "change_in_oi": changeInOi,
        "chg_chgpercent": chgChgpercent,
        "high": high,
        "low": low,
        "market_lot": marketLot,
        "offer_price": offerPrice,
        "offer_quantity": offerQuantity,
        "open": open,
        "open_interest": openInterest,
        "price": price,
        "volume": volume,
      };
}

class CommodityOverviewModelTechnicalIndicator {
  CommodityOverviewModelTechnicalIndicator({
    this.the15Min,
    this.the1Hour,
    this.the1Min,
    this.the30Min,
    this.the5Hour,
    this.the5Min,
    this.daily,
    this.monthly,
    this.weekly,
  });

  The15Min the15Min;
  The15Min the1Hour;
  The15Min the1Min;
  The15Min the30Min;
  The15Min the5Hour;
  The15Min the5Min;
  The15Min daily;
  The15Min monthly;
  The15Min weekly;

  factory CommodityOverviewModelTechnicalIndicator.fromJson(
          Map<String, dynamic> json) =>
      CommodityOverviewModelTechnicalIndicator(
        the15Min: json != null ? The15Min.fromJson(json["15min"]) : null,
        the1Hour: json != null ? The15Min.fromJson(json["1hour"]) : null,
        the1Min: json != null ? The15Min.fromJson(json["1min"]) : null,
        the30Min: json != null ? The15Min.fromJson(json["30min"]) : null,
        the5Hour: json != null ? The15Min.fromJson(json["5hour"]) : null,
        the5Min: json != null ? The15Min.fromJson(json["5min"]) : null,
        daily: json != null ? The15Min.fromJson(json["daily"]) : null,
        monthly: json != null ? The15Min.fromJson(json["monthly"]) : null,
        weekly: json != null ? The15Min.fromJson(json["weekly"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "15min": the15Min.toJson(),
        "1hour": the1Hour.toJson(),
        "1min": the1Min.toJson(),
        "30min": the30Min.toJson(),
        "5hour": the5Hour.toJson(),
        "5min": the5Min.toJson(),
        "daily": daily.toJson(),
        "monthly": monthly.toJson(),
        "weekly": weekly.toJson(),
      };
}

class The15Min {
  The15Min({
    this.movingAverages,
    this.pivotPoints,
    this.summary,
    this.technicalIndicator,
  });

  MovingAverages movingAverages;
  PivotPoints pivotPoints;
  Summary summary;
  The15MinTechnicalIndicator technicalIndicator;

  factory The15Min.fromJson(Map<String, dynamic> json) => The15Min(
        movingAverages: MovingAverages.fromJson(json["moving_averages"]),
        pivotPoints: PivotPoints.fromJson(json["pivot_points"]),
        summary: Summary.fromJson(json["summary"]),
        technicalIndicator:
            The15MinTechnicalIndicator.fromJson(json["technical_indicator"]),
      );

  Map<String, dynamic> toJson() => {
        "moving_averages": movingAverages.toJson(),
        "pivot_points": pivotPoints.toJson(),
        "summary": summary.toJson(),
        "technical_indicator": technicalIndicator.toJson(),
      };
}

class MovingAverages {
  MovingAverages({
    this.buy,
    this.sell,
    this.tableData,
    this.text,
  });

  String buy;
  String sell;
  TableData tableData;
  String text;

  factory MovingAverages.fromJson(Map<String, dynamic> json) => MovingAverages(
        buy: json["buy"],
        sell: json["sell"],
        tableData: TableData.fromJson(json["table_data"]),
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "buy": buy,
        "sell": sell,
        "table_data": tableData.toJson(),
        "text": text,
      };
}

class TableData {
  TableData({
    this.exponential,
    this.simple,
  });

  List<Exponential> exponential;
  List<Exponential> simple;

  factory TableData.fromJson(Map<String, dynamic> json) => TableData(
        exponential: List<Exponential>.from(
            json["exponential"].map((x) => Exponential.fromJson(x))),
        simple: List<Exponential>.from(
            json["simple"].map((x) => Exponential.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exponential": List<dynamic>.from(exponential.map((x) => x.toJson())),
        "simple": List<dynamic>.from(simple.map((x) => x.toJson())),
      };
}

class Exponential {
  Exponential({
    this.title,
    this.type,
    this.value,
  });

  String title;
  String type;
  String value;

  factory Exponential.fromJson(Map<String, dynamic> json) => Exponential(
        title: json["title"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "type": type,
        "value": value,
      };
}

class PivotPoints {
  PivotPoints({
    this.camarilla,
    this.classic,
    this.demark,
    this.fibonacci,
    this.woodie,
  });

  Camarilla camarilla;
  Camarilla classic;
  Camarilla demark;
  Camarilla fibonacci;
  Camarilla woodie;

  factory PivotPoints.fromJson(Map<String, dynamic> json) => PivotPoints(
        camarilla: Camarilla.fromJson(json["camarilla"]),
        classic: Camarilla.fromJson(json["classic"]),
        demark: Camarilla.fromJson(json["demark"]),
        fibonacci: Camarilla.fromJson(json["fibonacci"]),
        woodie: Camarilla.fromJson(json["woodie"]),
      );

  Map<String, dynamic> toJson() => {
        "camarilla": camarilla.toJson(),
        "classic": classic.toJson(),
        "demark": demark.toJson(),
        "fibonacci": fibonacci.toJson(),
        "woodie": woodie.toJson(),
      };
}

class Camarilla {
  Camarilla({
    this.pivotPoints,
    this.r1,
    this.r2,
    this.r3,
    this.s1,
    this.s2,
    this.s3,
  });

  String pivotPoints;
  String r1;
  String r2;
  String r3;
  String s1;
  String s2;
  String s3;

  factory Camarilla.fromJson(Map<String, dynamic> json) => Camarilla(
        pivotPoints: json["pivot_points"],
        r1: json["r1"],
        r2: json["r2"],
        r3: json["r3"],
        s1: json["s1"],
        s2: json["s2"],
        s3: json["s3"],
      );

  Map<String, dynamic> toJson() => {
        "pivot_points": pivotPoints,
        "r1": r1,
        "r2": r2,
        "r3": r3,
        "s1": s1,
        "s2": s2,
        "s3": s3,
      };
}

class Summary {
  Summary({
    this.summaryText,
  });

  String summaryText;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        summaryText: json["summary_text"],
      );

  Map<String, dynamic> toJson() => {
        "summary_text": summaryText,
      };
}

class The15MinTechnicalIndicator {
  The15MinTechnicalIndicator({
    this.buy,
    this.neutral,
    this.sell,
    this.tableData,
    this.text,
  });

  String buy;
  String neutral;
  String sell;
  List<TableDatum> tableData;
  String text;

  factory The15MinTechnicalIndicator.fromJson(Map<String, dynamic> json) =>
      The15MinTechnicalIndicator(
        buy: json["buy"],
        neutral: json["neutral"],
        sell: json["sell"],
        tableData: List<TableDatum>.from(
            json["table_data"].map((x) => TableDatum.fromJson(x))),
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "buy": buy,
        "neutral": neutral,
        "sell": sell,
        "table_data": List<dynamic>.from(tableData.map((x) => x.toJson())),
        "text": text,
      };
}

class TableDatum {
  TableDatum({
    this.action,
    this.name,
    this.value,
  });

  String action;
  String name;
  String value;

  factory TableDatum.fromJson(Map<String, dynamic> json) => TableDatum(
        action: json["action"],
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "name": name,
        "value": value,
      };
}
