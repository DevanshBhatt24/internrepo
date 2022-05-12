// To parse this JSON data, do
//
//     final etfSummaryModel = etfSummaryModelFromJson(jsonString);

import 'dart:convert';

EtfSummaryModel etfSummaryModelFromJson(String str) =>
    EtfSummaryModel.fromJson(json.decode(str));

String etfSummaryModelToJson(EtfSummaryModel data) =>
    json.encode(data.toJson());

class EtfSummaryModel {
  EtfSummaryModel({
    this.historicalGraph,
    this.mutualFund,
  });

  HistoricalGraph historicalGraph;
  MutualFund mutualFund;

  factory EtfSummaryModel.fromJson(Map<String, dynamic> json) =>
      EtfSummaryModel(
        historicalGraph: HistoricalGraph.fromJson(json["historical graph"]),
        mutualFund: MutualFund.fromJson(json["mutual fund"]),
      );

  Map<String, dynamic> toJson() => {
        "historical graph": historicalGraph.toJson(),
        "mutual fund": mutualFund.toJson(),
      };
}

class HistoricalGraph {
  HistoricalGraph({
    this.data,
    this.meta,
    this.status,
  });

  List<Datum> data;
  Meta meta;
  String status;

  factory HistoricalGraph.fromJson(Map<String, dynamic> json) =>
      HistoricalGraph(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
        "status": status,
      };
}

class Datum {
  Datum({
    this.date,
    this.nav,
  });

  String date;
  String nav;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"],
        nav: json["nav"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "nav": nav,
      };
}

class Meta {
  Meta({
    this.fundHouse,
    this.schemeCategory,
    this.schemeCode,
    this.schemeName,
    this.schemeType,
  });

  String fundHouse;
  String schemeCategory;
  int schemeCode;
  String schemeName;
  String schemeType;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        fundHouse: json["fund_house"],
        schemeCategory: json["scheme_category"],
        schemeCode: json["scheme_code"],
        schemeName: json["scheme_name"],
        schemeType: json["scheme_type"],
      );

  Map<String, dynamic> toJson() => {
        "fund_house": fundHouse,
        "scheme_category": schemeCategory,
        "scheme_code": schemeCode,
        "scheme_name": schemeName,
        "scheme_type": schemeType,
      };
}

class MutualFund {
  MutualFund({
    this.fundPeer,
    this.fundSummary,
  });

  List<FundPeer> fundPeer;
  FundSummary fundSummary;

  factory MutualFund.fromJson(Map<String, dynamic> json) => MutualFund(
        fundPeer: List<FundPeer>.from(
            json["fund_peer"].map((x) => FundPeer.fromJson(x))),
        fundSummary: FundSummary.fromJson(json["fund_summary"]),
      );

  Map<String, dynamic> toJson() => {
        "fund_peer": List<dynamic>.from(fundPeer.map((x) => x.toJson())),
        "fund_summary": fundSummary.toJson(),
      };
}

class FundPeer {
  FundPeer({
    this.the1YearReturn,
    this.the3YearsReturn,
    this.fundName,
  });

  String the1YearReturn;
  String the3YearsReturn;
  String fundName;

  factory FundPeer.fromJson(Map<String, dynamic> json) => FundPeer(
        the1YearReturn: json["1 Year Return"],
        the3YearsReturn: json["3 Years Return"],
        fundName: json["Fund Name"],
      );

  Map<String, dynamic> toJson() => {
        "1 Year Return": the1YearReturn,
        "3 Years Return": the3YearsReturn,
        "Fund Name": fundName,
      };
}

class FundSummary {
  FundSummary({
    this.annualizedReturnForTheLast3Years,
    this.suggestedInvestmentHorizon,
    this.annualReturnValue,
    this.debt,
    this.equity,
    this.fundUrl,
    this.others,
    this.riskInfo,
  });

  String annualizedReturnForTheLast3Years;
  String suggestedInvestmentHorizon;
  String annualReturnValue;
  String debt;
  String equity;
  String fundUrl;
  String others;
  String riskInfo;

  factory FundSummary.fromJson(Map<String, dynamic> json) => FundSummary(
        annualizedReturnForTheLast3Years:
            json["Annualized return for the last 3 years"],
        suggestedInvestmentHorizon: json["Suggested Investment Horizon"],
        annualReturnValue: json["annual_return_value"],
        debt: json["debt"],
        equity: json["equity"],
        fundUrl: json["fund_url"],
        others: json["others"],
        riskInfo: json["risk_info"],
      );

  Map<String, dynamic> toJson() => {
        "Annualized return for the last 3 years":
            annualizedReturnForTheLast3Years,
        "Suggested Investment Horizon": suggestedInvestmentHorizon,
        "annual_return_value": annualReturnValue,
        "debt": debt,
        "equity": equity,
        "fund_url": fundUrl,
        "others": others,
        "risk_info": riskInfo,
      };
}
