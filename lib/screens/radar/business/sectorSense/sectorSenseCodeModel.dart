// To parse this JSON data, do
//
//     final sectorSenseCodeModel = sectorSenseCodeModelFromJson(jsonString);

import 'dart:convert';

List<SectorSenseCodeModel> sectorSenseCodeModelFromJson(String str) =>
    List<SectorSenseCodeModel>.from(
        json.decode(str).map((x) => SectorSenseCodeModel.fromJson(x)));

String sectorSenseCodeModelToJson(List<SectorSenseCodeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SectorSenseCodeModel {
  SectorSenseCodeModel({
    this.trendText,
    this.growthcard,
    this.tabularData,
  });

  String trendText;
  List<Growthcard> growthcard;
  List<TabularDatum> tabularData;

  factory SectorSenseCodeModel.fromJson(Map<String, dynamic> json) =>
      SectorSenseCodeModel(
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
  TabularDatum(
      {this.ebitGrowthYoY,
      this.lastResultUpdated,
      this.marketCapitalizationCr,
      this.netProfitQtrCr,
      this.netProfitQtrGrowthYoY,
      this.operatingProfitGrowthQtrYoY,
      this.operatingProfitMarginGrowthYoY,
      this.operatingRevenuesQtrCr,
      this.revenueGrowthQtrYoY,
      this.stock,
      this.stockCode});

  String ebitGrowthYoY;
  String lastResultUpdated;
  String marketCapitalizationCr;
  String netProfitQtrCr;
  String netProfitQtrGrowthYoY;
  String operatingProfitGrowthQtrYoY;
  String operatingProfitMarginGrowthYoY;
  String operatingRevenuesQtrCr;
  String revenueGrowthQtrYoY;
  String stock;
  String stockCode;

  factory TabularDatum.fromJson(Map<String, dynamic> json) => TabularDatum(
        ebitGrowthYoY: json["EBIT Growth YoY %"],
        lastResultUpdated: json["Last Result Updated"],
        marketCapitalizationCr: json["Market Capitalization (Cr)"],
        netProfitQtrCr: json["Net Profit Qtr (Cr)"],
        netProfitQtrGrowthYoY: json["Net Profit Qtr Growth YoY %"],
        operatingProfitGrowthQtrYoY: json["Operating Profit Growth Qtr YoY %"],
        operatingProfitMarginGrowthYoY:
            json["Operating Profit Margin Growth YoY %"],
        operatingRevenuesQtrCr: json["Operating Revenues Qtr (Cr)"],
        revenueGrowthQtrYoY: json["Revenue Growth Qtr YoY %"],
        stock: json["Stock"],
        stockCode: json["Stock_code"],
      );

  Map<String, dynamic> toJson() => {
        "EBIT Growth YoY %": ebitGrowthYoY,
        "Last Result Updated": lastResultUpdated,
        "Market Capitalization (Cr)": marketCapitalizationCr,
        "Net Profit Qtr (Cr)": netProfitQtrCr,
        "Net Profit Qtr Growth YoY %": netProfitQtrGrowthYoY,
        "Operating Profit Growth Qtr YoY %": operatingProfitGrowthQtrYoY,
        "Operating Profit Margin Growth YoY %": operatingProfitMarginGrowthYoY,
        "Operating Revenues Qtr (Cr)": operatingRevenuesQtrCr,
        "Revenue Growth Qtr YoY %": revenueGrowthQtrYoY,
        "Stock": stock,
      };
}
