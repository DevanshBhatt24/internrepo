// To parse this JSON data, do
//
//     final forexExplore = forexExploreFromJson(jsonString);

import 'dart:convert';

import 'package:technical_ind/screens/cryptocurrency/business/crypto_overview_model.dart';

ForexExplore forexExploreFromJson(String str) =>
    ForexExplore.fromJson(json.decode(str));

String forexExploreToJson(ForexExplore data) => json.encode(data.toJson());

class ForexExplore {
  ForexExplore({
    this.historicalData,
    this.overview,
    this.technicalIndicator,
  });

  HistoricalData historicalData;
  Overview overview;
  ForexExploreTechnicalIndicator technicalIndicator;

  factory ForexExplore.fromJson(Map<String, dynamic> json) => ForexExplore(
        historicalData: HistoricalData.fromJson(json["historical_data"]),
        overview: Overview.fromJson(json["overview"]),
        technicalIndicator: ForexExploreTechnicalIndicator.fromJson(
            json["technical_indicator"]),
      );

  Map<String, dynamic> toJson() => {
        "historical_data": historicalData.toJson(),
        "overview": overview.toJson(),
        "technical_indicator": technicalIndicator.toJson(),
      };
}

class Overview {
  Overview({
    this.the52WeekRange,
    this.ask,
    this.bid,
    this.change,
    this.changePercent,
    this.daysRange,
    this.name,
    this.open,
    this.previousClose,
    this.price,
  });

  String the52WeekRange;
  String ask;
  String bid;
  String change;
  String changePercent;
  String daysRange;
  String name;
  String open;
  String previousClose;
  String price;

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
        the52WeekRange: json["52_week_range"],
        ask: json["ask"],
        bid: json["bid"],
        change: json["change"],
        changePercent: json["change_percent"],
        daysRange: json["days_range"],
        name: json["name"],
        open: json["open"],
        previousClose: json["previous_close"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "52_week_range": the52WeekRange,
        "ask": ask,
        "bid": bid,
        "change": change,
        "change_percent": changePercent,
        "days_range": daysRange,
        "name": name,
        "open": open,
        "previous_close": previousClose,
        "price": price,
      };
}

class ForexExploreTechnicalIndicator {
  ForexExploreTechnicalIndicator({
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

  factory ForexExploreTechnicalIndicator.fromJson(Map<String, dynamic> json) =>
      ForexExploreTechnicalIndicator(
        the15Min: The15Min.fromJson(json["15min"]),
        the1Hour: The15Min.fromJson(json["1hour"]),
        the1Min: The15Min.fromJson(json["1min"]),
        the30Min: The15Min.fromJson(json["30min"]),
        the5Hour: The15Min.fromJson(json["5hour"]),
        the5Min: The15Min.fromJson(json["5min"]),
        daily: The15Min.fromJson(json["daily"]),
        monthly: The15Min.fromJson(json["monthly"]),
        weekly: The15Min.fromJson(json["weekly"]),
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
