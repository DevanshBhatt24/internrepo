// To parse this JSON data, do
//
//     final gobalOverview = gobalOverviewFromJson(jsonString);

import 'package:technical_ind/screens/commodity/business/commodity_overview_model.dart';

import 'dart:convert';

GobalOverview gobalOverviewFromJson(String str) =>
    GobalOverview.fromJson(json.decode(str));

String gobalOverviewToJson(GobalOverview data) => json.encode(data.toJson());

class GobalOverview {
  GobalOverview({
    this.components,
    this.historicalData,
    this.overview,
    this.technicalIndicator,
  });

  Component components;
  HistoricalData historicalData;
  Overview overview;
  CommodityOverviewModelTechnicalIndicator technicalIndicator;

  factory GobalOverview.fromJson(Map<String, dynamic> json) => GobalOverview(
        // components: List<Component>.from(
        //     json["components"].map((x) => Component.fromJson(x))),
        components: Component.fromJson(json["components"]),
        historicalData: HistoricalData.fromJson(json["historical_data"]),
        overview: Overview.fromJson(json["overview"]),
        technicalIndicator: CommodityOverviewModelTechnicalIndicator.fromJson(
            json["technical_indicator"]),
      );

  Map<String, dynamic> toJson() => {
        // "components": List<dynamic>.from(components.map((x) => x.toJson())),
        "components": components.toJson(),
        "historical_data": historicalData.toJson(),
        "overview": overview.toJson(),
        "technical_indicator": technicalIndicator.toJson(),
      };
}

class Component {
  Component({
    this.data,
  });

  List<Datum> data;

  factory Component.fromJson(Map<String, dynamic> json) => Component(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.name,
    this.chg,
    this.datumChg,
    this.price,
  });

  String name;
  String chg;
  String datumChg;
  String price;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["Name"],
        chg: json["chg"],
        datumChg: json["chg_%"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "chg": chg,
        "chg_%": datumChg,
        "price": price,
      };
}

class Daily {
  Daily({
    this.adjClose,
    this.close,
    this.date,
    this.high,
    this.low,
    this.open,
    this.volume,
  });

  String adjClose;
  String close;
  String date;
  String high;
  String low;
  String open;
  String volume;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        adjClose: json["adj_close"],
        close: json["close"],
        date: json["date"],
        high: json["high"],
        low: json["low"],
        open: json["open"],
        volume: json["volume"],
      );

  Map<String, dynamic> toJson() => {
        "adj_close": adjClose,
        "close": close,
        "date": date,
        "high": high,
        "low": low,
        "open": open,
        "volume": volume,
      };
}

class Overview {
  Overview({
    this.the52WkRange,
    this.averageVol3M,
    this.daySRange,
    this.open,
    this.prevClose,
    this.price,
    this.priceChange,
    this.priceChangePercentage,
    this.volume,
  });

  String the52WkRange;
  String averageVol3M;
  String daySRange;
  String open;
  String prevClose;
  String price;
  String priceChange;
  String priceChangePercentage;
  String volume;

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
        the52WkRange: json != null ? json["52_wk_range"] : '',
        averageVol3M: json != null ? json["average_vol_3m"] : '',
        daySRange: json != null ? json["day's_range"] : '',
        open: json != null ? json["open"] : '',
        prevClose: json != null ? json["prev_Close"] : '',
        price: json != null ? json["price"] : '',
        priceChange: json != null ? json["price_change"] : '',
        priceChangePercentage:
            json != null ? json["price_change_percentage"] : '',
        volume: json != null ? json["volume"] : '',
      );

  Map<String, dynamic> toJson() => {
        "52_wk_range": the52WkRange,
        "average_vol_3m": averageVol3M,
        "day's_range": daySRange,
        "open": open,
        "prev_Close": prevClose,
        "price": price,
        "price_change": priceChange,
        "price_change_percentage": priceChangePercentage,
        "volume": volume,
      };
}

// class GobalOverviewTechnicalIndicator {
//   GobalOverviewTechnicalIndicator({
//     this.the15Min,
//     this.the1Hour,
//     this.the1Min,
//     this.the30Min,
//     this.the5Hour,
//     this.the5Min,
//     this.daily,
//     this.monthly,
//     this.weekly,
//   });

//   The15Min the15Min;
//   The15Min the1Hour;
//   The15Min the1Min;
//   The15Min the30Min;
//   The15Min the5Hour;
//   The15Min the5Min;
//   The15Min daily;
//   The15Min monthly;
//   The15Min weekly;

//   factory GobalOverviewTechnicalIndicator.fromJson(Map<String, dynamic> json) =>
//       GobalOverviewTechnicalIndicator(
//         the15Min: The15Min.fromJson(json["15min"]),
//         the1Hour: The15Min.fromJson(json["1hour"]),
//         the1Min: The15Min.fromJson(json["1min"]),
//         the30Min: The15Min.fromJson(json["30min"]),
//         the5Hour: The15Min.fromJson(json["5hour"]),
//         the5Min: The15Min.fromJson(json["5min"]),
//         daily: The15Min.fromJson(json["daily"]),
//         monthly: The15Min.fromJson(json["monthly"]),
//         weekly: The15Min.fromJson(json["weekly"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "15min": the15Min.toJson(),
//         "1hour": the1Hour.toJson(),
//         "1min": the1Min.toJson(),
//         "30min": the30Min.toJson(),
//         "5hour": the5Hour.toJson(),
//         "5min": the5Min.toJson(),
//         "daily": daily.toJson(),
//         "monthly": monthly.toJson(),
//         "weekly": weekly.toJson(),
//       };
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
