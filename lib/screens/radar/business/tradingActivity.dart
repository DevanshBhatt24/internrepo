// To parse this JSON data, do
//
//     final tradingActivityModel = tradingActivityModelFromJson(jsonString);

import 'dart:convert';

List<TradingActivityModel> tradingActivityModelFromJson(String str) =>
    List<TradingActivityModel>.from(
        json.decode(str).map((x) => TradingActivityModel.fromJson(x)));

String tradingActivityModelToJson(List<TradingActivityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//temporary code for filtered trading data(for particular list widgets)
List<FilteredDii> tradingAcitiviyModelFilteredFromJson(List item) =>
    List<FilteredDii>.from(item.map((x) => FilteredDii.fromJson(x)));

class TradingActivityModel {
  TradingActivityModel({
    this.data,
    this.identifier,
  });

  Data data;
  String identifier;

  factory TradingActivityModel.fromJson(Map<String, dynamic> json) =>
      TradingActivityModel(
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
    this.cash,
    this.derivative,
    this.sebi,
  });

  Cash cash;
  Derivative derivative;
  Sebi sebi;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cash: Cash.fromJson(json["cash"]),
        derivative: Derivative.fromJson(json["derivative"]),
        sebi: Sebi.fromJson(json["sebi"]),
      );

  Map<String, dynamic> toJson() => {
        "cash": cash.toJson(),
        "derivative": derivative.toJson(),
        "sebi": sebi.toJson(),
      };
}

class Cash {
  Cash({
    this.dii,
    this.fii,
  });

  List<Dii> dii;
  List<Dii> fii;

  factory Cash.fromJson(Map<String, dynamic> json) => Cash(
        dii: List<Dii>.from(json["dii"].map((x) => Dii.fromJson(x))),
        fii: List<Dii>.from(json["fii"].map((x) => Dii.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dii": List<dynamic>.from(dii.map((x) => x.toJson())),
        "fii": List<dynamic>.from(fii.map((x) => x.toJson())),
      };
}

String getMonth(int month) {
  List<String> months = [
    "January ${DateTime.now().year}",
    "February ${DateTime.now().year}",
    "March ${DateTime.now().year}",
    "April ${DateTime.now().year}",
    "May ${DateTime.now().year}",
    "June ${DateTime.now().year}",
    "July ${DateTime.now().year}",
    "August ${DateTime.now().year}",
    "September ${DateTime.now().year}",
    "October ${DateTime.now().year}",
    "November ${DateTime.now().year}",
    "December ${DateTime.now().year}",
  ];
  return months[month - 1];
}

class Dii {
  Dii({
    this.grossPurchase,
    this.grossSales,
    this.month,
    this.netPurchasePerSales,
  });

  String grossPurchase;
  String grossSales;
  String month;
  String netPurchasePerSales;

  factory Dii.fromJson(Map<String, dynamic> json) => Dii(
        grossPurchase: json["gross_purchase"],
        grossSales: json["gross_sales"],
        month: json["month"] == null
            ? getMonth(DateTime.now().month)
            : json["month"],
        netPurchasePerSales: json["net_purchase_per_sales"],
      );

  Map<String, dynamic> toJson() => {
        "gross_purchase": grossPurchase,
        "gross_sales": grossSales,
        "month": month,
        "net_purchase_per_sales": netPurchasePerSales,
      };
}

class FilteredDii {
  FilteredDii({
    this.grossPurchase,
    this.grossSales,
    this.date,
    this.netPurchasePerSales,
  });

  String grossPurchase;
  String grossSales;
  String date;
  String netPurchasePerSales;

  factory FilteredDii.fromJson(Map<String, dynamic> json) => FilteredDii(
        grossPurchase: json["gross_purchase"],
        grossSales: json["gross_sales"],
        date: json["date"],
        netPurchasePerSales: json["net_purchase_per_sales"],
      );

  Map<String, dynamic> toJson() => {
        "gross_purchase": grossPurchase,
        "gross_sales": grossSales,
        "date": date,
        "net_purchase_per_sales": netPurchasePerSales,
      };
}

class Derivative {
  Derivative({
    this.indexFut,
    this.indexOpt,
    this.stockFut,
    this.stockOpt,
  });

  List<Dii> indexFut;
  List<Dii> indexOpt;
  List<Dii> stockFut;
  List<Dii> stockOpt;

  factory Derivative.fromJson(Map<String, dynamic> json) => Derivative(
        indexFut: List<Dii>.from(json["index_fut"].map((x) => Dii.fromJson(x))),
        indexOpt: List<Dii>.from(json["index_opt"].map((x) => Dii.fromJson(x))),
        stockFut: List<Dii>.from(json["stock_fut"].map((x) => Dii.fromJson(x))),
        stockOpt: List<Dii>.from(json["stock_opt"].map((x) => Dii.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "index_fut": List<dynamic>.from(indexFut.map((x) => x.toJson())),
        "index_opt": List<dynamic>.from(indexOpt.map((x) => x.toJson())),
        "stock_fut": List<dynamic>.from(stockFut.map((x) => x.toJson())),
        "stock_opt": List<dynamic>.from(stockOpt.map((x) => x.toJson())),
      };
}

class Sebi {
  Sebi({
    this.fiiDebt,
    this.fiiEquity,
    this.mfDebt,
    this.mfEquity,
  });

  List<Dii> fiiDebt;
  List<Dii> fiiEquity;
  List<Dii> mfDebt;
  List<Dii> mfEquity;

  factory Sebi.fromJson(Map<String, dynamic> json) => Sebi(
        fiiDebt: List<Dii>.from(json["fii_debt"].map((x) => Dii.fromJson(x))),
        fiiEquity:
            List<Dii>.from(json["fii_equity"].map((x) => Dii.fromJson(x))),
        mfDebt: List<Dii>.from(json["mf_debt"].map((x) => Dii.fromJson(x))),
        mfEquity: List<Dii>.from(json["mf_equity"].map((x) => Dii.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fii_debt": List<dynamic>.from(fiiDebt.map((x) => x.toJson())),
        "fii_equity": List<dynamic>.from(fiiEquity.map((x) => x.toJson())),
        "mf_debt": List<dynamic>.from(mfDebt.map((x) => x.toJson())),
        "mf_equity": List<dynamic>.from(mfEquity.map((x) => x.toJson())),
      };
}
