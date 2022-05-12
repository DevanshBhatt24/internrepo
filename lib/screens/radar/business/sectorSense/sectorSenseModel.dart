// To parse this JSON data, do
//
//     final sectorSenseModel = sectorSenseModelFromJson(jsonString);

import 'dart:convert';

List<SectorSenseModel> sectorSenseModelFromJson(String str) =>
    List<SectorSenseModel>.from(
        json.decode(str).map((x) => SectorSenseModel.fromJson(x)));

String sectorSenseModelToJson(List<SectorSenseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SectorSenseModel {
  SectorSenseModel({
    this.comId,
    this.data,
  });

  String comId;
  List<Datum> data;

  factory SectorSenseModel.fromJson(Map<String, dynamic> json) =>
      SectorSenseModel(
        comId: json["com_id"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "com_id": comId,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.trendText,
    this.growthcard,
    this.tabularData,
  });

  String trendText;
  List<Growthcard> growthcard;
  List<TabularDatum> tabularData;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        trendText: json["Trend_text"] == null ? null : json["Trend_text"],
        growthcard: json["growthcard"] == null
            ? null
            : List<Growthcard>.from(
                json["growthcard"].map((x) => Growthcard.fromJson(x))),
        tabularData: json["tabular_data"] == null
            ? null
            : List<TabularDatum>.from(
                json["tabular_data"].map((x) => TabularDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Trend_text": trendText == null ? null : trendText,
        "growthcard": growthcard == null
            ? null
            : List<dynamic>.from(growthcard.map((x) => x.toJson())),
        "tabular_data": tabularData == null
            ? null
            : List<dynamic>.from(tabularData.map((x) => x.toJson())),
      };
}

class Growthcard {
  Growthcard({
    this.positiveProfitGrowth,
    this.negativeProfitGrowth,
    this.neutralProfitGrowth,
    this.totalRevenueGrowth,
    this.totalEbidtGrowth,
    this.totalOperProfitGrowth,
  });

  String positiveProfitGrowth;
  String negativeProfitGrowth;
  String neutralProfitGrowth;
  String totalRevenueGrowth;
  String totalEbidtGrowth;
  String totalOperProfitGrowth;

  factory Growthcard.fromJson(Map<String, dynamic> json) => Growthcard(
        positiveProfitGrowth: json[" POSITIVE PROFIT GROWTH"] == null
            ? null
            : json[" POSITIVE PROFIT GROWTH"],
        negativeProfitGrowth: json[" NEGATIVE PROFIT GROWTH"] == null
            ? null
            : json[" NEGATIVE PROFIT GROWTH"],
        neutralProfitGrowth: json[" NEUTRAL PROFIT GROWTH"] == null
            ? null
            : json[" NEUTRAL PROFIT GROWTH"],
        totalRevenueGrowth: json[" TOTAL REVENUE GROWTH"] == null
            ? null
            : json[" TOTAL REVENUE GROWTH"],
        totalEbidtGrowth: json[" TOTAL EBIDT GROWTH"] == null
            ? null
            : json[" TOTAL EBIDT GROWTH"],
        totalOperProfitGrowth: json[" TOTAL OPER PROFIT GROWTH"] == null
            ? null
            : json[" TOTAL OPER PROFIT GROWTH"],
      );

  Map<String, dynamic> toJson() => {
        " POSITIVE PROFIT GROWTH":
            positiveProfitGrowth == null ? null : positiveProfitGrowth,
        " NEGATIVE PROFIT GROWTH":
            negativeProfitGrowth == null ? null : negativeProfitGrowth,
        " NEUTRAL PROFIT GROWTH":
            neutralProfitGrowth == null ? null : neutralProfitGrowth,
        " TOTAL REVENUE GROWTH":
            totalRevenueGrowth == null ? null : totalRevenueGrowth,
        " TOTAL EBIDT GROWTH":
            totalEbidtGrowth == null ? null : totalEbidtGrowth,
        " TOTAL OPER PROFIT GROWTH":
            totalOperProfitGrowth == null ? null : totalOperProfitGrowth,
      };
}

class TabularDatum {
  TabularDatum({
    this.ebitGrowthYoY,
    this.industry,
    this.netProfitGrowthYoY,
    this.operProfitGrowthYoY,
    this.operProfitMarginGrowthYoY,
    this.revenueGrowthYoY,
    this.code,
  });

  String ebitGrowthYoY;
  String industry;
  String netProfitGrowthYoY;
  String operProfitGrowthYoY;
  String operProfitMarginGrowthYoY;
  String revenueGrowthYoY;
  String code;

  factory TabularDatum.fromJson(Map<String, dynamic> json) => TabularDatum(
        ebitGrowthYoY: json["EBIT Growth YoY %"],
        industry: json["Industry"],
        netProfitGrowthYoY: json["Net Profit Growth YoY %"],
        operProfitGrowthYoY: json["Oper Profit Growth YoY %"],
        operProfitMarginGrowthYoY: json["Oper Profit Margin Growth YoY %"],
        revenueGrowthYoY: json["Revenue Growth YoY %"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "EBIT Growth YoY %": ebitGrowthYoY,
        "Industry": industry,
        "Net Profit Growth YoY %": netProfitGrowthYoY,
        "Oper Profit Growth YoY %": operProfitGrowthYoY,
        "Oper Profit Margin Growth YoY %": operProfitMarginGrowthYoY,
        "Revenue Growth YoY %": revenueGrowthYoY,
        "code": code,
      };
}
