// To parse this JSON data, do
//
//     final indianOverviewModel = indianOverviewModelFromJson(jsonString);

import 'dart:convert';

import 'package:technical_ind/screens/commodity/business/commodity_overview_model.dart';

IndianOverviewModel indianOverviewModelFromJson(String str) =>
    IndianOverviewModel.fromJson(json.decode(str));

String indianOverviewModelToJson(IndianOverviewModel data) =>
    json.encode(data.toJson());

class IndianOverviewModel {
  IndianOverviewModel({
    this.components,
    this.historicalData,
    this.overview,
    this.stockEffect,
    this.technicalIndicator,
  });

  List<Component> components;
  HistoricalData historicalData;
  Overview overview;
  StockEffects stockEffect;
  CommodityOverviewModelTechnicalIndicator technicalIndicator;

  factory IndianOverviewModel.fromJson(Map<String, dynamic> json) =>
      IndianOverviewModel(
        components: List<Component>.from(
            json["components"].map((x) => Component.fromJson(x))),
        historicalData: HistoricalData.fromJson(json["historical data"]),
        overview: Overview.fromJson(json["overview"]),
        stockEffect: StockEffects.fromJson(json["stock_effect"]),
        technicalIndicator: CommodityOverviewModelTechnicalIndicator.fromJson(
            json["technical_indicator"]),
      );

  Map<String, dynamic> toJson() => {
        "components": List<dynamic>.from(components.map((x) => x.toJson())),
        "historical data": historicalData.toJson(),
        "overview": overview.toJson(),
        "stock_effect": stockEffect.toJson(),
        "technical_indicator": technicalIndicator.toJson(),
      };
}

class Component {
  Component(
      {this.chg, this.chgPercent, this.name, this.price, this.stock_code});

  String chg;
  String chgPercent;
  String name;
  String price;
  String stock_code;

  factory Component.fromJson(Map<String, dynamic> json) => Component(
      chg: json["chg"],
      chgPercent: json["chg_percent"],
      name: json["name"],
      price: json["price"],
      stock_code: json["stock_code"]);

  Map<String, dynamic> toJson() => {
        "chg": chg,
        "chg_percent": chgPercent,
        "name": name,
        "price": price,
        "stock_code": stock_code
      };
}

// class HistoricalData {
//   HistoricalData({
//     this.daily,
//     this.monthly,
//     this.weekly,
//   });

//   List<Daily> daily;
//   List<Daily> monthly;
//   List<Daily> weekly;

//   factory HistoricalData.fromJson(Map<String, dynamic> json) => HistoricalData(
//         daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
//         monthly:
//             List<Daily>.from(json["monthly"].map((x) => Daily.fromJson(x))),
//         weekly: List<Daily>.from(json["weekly"].map((x) => Daily.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
//         "monthly": List<dynamic>.from(monthly.map((x) => x.toJson())),
//         "weekly": List<dynamic>.from(weekly.map((x) => x.toJson())),
//       };
// }

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
    this.the52WeekHigh,
    this.the52WeekLow,
    this.the52WeekRange,
    this.chgChgPercent,
    this.dayHigh,
    this.dayLow,
    this.daysRange,
    this.name,
    this.open,
    this.previousClose,
    this.price,
    this.returns,
  });

  String the52WeekHigh;
  String the52WeekLow;
  String the52WeekRange;
  String chgChgPercent;
  String dayHigh;
  String dayLow;
  String daysRange;
  String name;
  String open;
  String previousClose;
  String price;
  Returns returns;

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
        the52WeekHigh: json["52_week_high"],
        the52WeekLow: json["52_week_low"],
        the52WeekRange: json["52_week_range"],
        chgChgPercent: json["chg_chg_percent"],
        dayHigh: json["day_high"],
        dayLow: json["day_low"],
        daysRange: json["days_range"],
        name: json["name"],
        open: json["open"],
        previousClose: json["previous_close"],
        price: json["price"],
        returns: Returns.fromJson(json["returns"]),
      );

  Map<String, dynamic> toJson() => {
        "52_week_high": the52WeekHigh,
        "52_week_low": the52WeekLow,
        "52_week_range": the52WeekRange,
        "chg_chg_percent": chgChgPercent,
        "day_high": dayHigh,
        "day_low": dayLow,
        "days_range": daysRange,
        "name": name,
        "open": open,
        "previous_close": previousClose,
        "price": price,
        "returns": returns.toJson(),
      };
}

class Returns {
  Returns({
    this.the1Month,
    this.the1Week,
    this.the1Year,
    this.the2Year,
    this.the3Month,
    this.the3Year,
    this.the5Year,
    this.the6Month,
    this.ytd,
  });

  String the1Month;
  String the1Week;
  String the1Year;
  String the2Year;
  String the3Month;
  String the3Year;
  String the5Year;
  String the6Month;
  String ytd;

  factory Returns.fromJson(Map<String, dynamic> json) => Returns(
        the1Month: json["1_month"],
        the1Week: json["1_week"],
        the1Year: json["1_year"],
        the2Year: json["2_year"],
        the3Month: json["3_month"],
        the3Year: json["3_year"],
        the5Year: json["5_year"],
        the6Month: json["6_month"],
        ytd: json["ytd"],
      );

  Map<String, dynamic> toJson() => {
        "1_month": the1Month,
        "1_week": the1Week,
        "1_year": the1Year,
        "2_year": the2Year,
        "3_month": the3Month,
        "3_year": the3Year,
        "5_year": the5Year,
        "6_month": the6Month,
        "ytd": ytd,
      };
}

class StockEffects {
  StockEffects({
    this.down,
    this.up,
  });

  List<Down> down;
  List<Down> up;

  factory StockEffects.fromJson(Map<String, dynamic> json) => StockEffects(
        down: List<Down>.from(json["down"].map((x) => Down.fromJson(x))),
        up: List<Down>.from(json["up"].map((x) => Down.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "down": List<dynamic>.from(down.map((x) => x.toJson())),
        "up": List<dynamic>.from(up.map((x) => x.toJson())),
      };
}

class Down {
  Down({
    this.cmp,
    this.contributionPercent,
    this.name,
  });

  String cmp;
  String contributionPercent;
  String name;

  factory Down.fromJson(Map<String, dynamic> json) => Down(
        cmp: json["cmp"],
        contributionPercent: json["contribution_percent"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "cmp": cmp,
        "contribution_percent": contributionPercent,
        "name": name,
      };
}

// class IndianOverviewModelTechnicalIndicator {
//     IndianOverviewModelTechnicalIndicator({
//         this.the15Min,
//         this.the1Hour,
//         this.the1Min,
//         this.the30Min,
//         this.the5Hour,
//         this.the5Min,
//         this.daily,
//         this.monthly,
//         this.weekly,
//     });

//     The15Min the15Min;
//     The15Min the1Hour;
//     The15Min the1Min;
//     The15Min the30Min;
//     The15Min the5Hour;
//     The15Min the5Min;
//     The15Min daily;
//     The15Min monthly;
//     The15Min weekly;

//     factory IndianOverviewModelTechnicalIndicator.fromJson(Map<String, dynamic> json) => IndianOverviewModelTechnicalIndicator(
//         the15Min: The15Min.fromJson(json["15min"]),
//         the1Hour: The15Min.fromJson(json["1hour"]),
//         the1Min: The15Min.fromJson(json["1min"]),
//         the30Min: The15Min.fromJson(json["30min"]),
//         the5Hour: The15Min.fromJson(json["5hour"]),
//         the5Min: The15Min.fromJson(json["5min"]),
//         daily: The15Min.fromJson(json["daily"]),
//         monthly: The15Min.fromJson(json["monthly"]),
//         weekly: The15Min.fromJson(json["weekly"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "15min": the15Min.toJson(),
//         "1hour": the1Hour.toJson(),
//         "1min": the1Min.toJson(),
//         "30min": the30Min.toJson(),
//         "5hour": the5Hour.toJson(),
//         "5min": the5Min.toJson(),
//         "daily": daily.toJson(),
//         "monthly": monthly.toJson(),
//         "weekly": weekly.toJson(),
//     };
// }

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
