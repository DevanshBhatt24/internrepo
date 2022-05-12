// To parse this JSON data, do
//
//     final codeSearch = codeSearchFromJson(jsonString);

import 'dart:convert';

CodeSearch codeSearchFromJson(String str) =>
    CodeSearch.fromJson(json.decode(str));

String codeSearchToJson(CodeSearch data) => json.encode(data.toJson());

class CodeSearch {
  CodeSearch({
    this.code,
    this.createdAt,
    this.investingDividendsUrl,
    this.investingDividendsYeildUrl,
    this.investingEarningsUrl,
    this.investingHistoricalDataUrl,
    this.investingTechnicalIndicatorUrl,
    this.isin,
    this.marketsmojoId,
    this.moneycontrolCode,
    this.moneycontrolUrl,
    this.topstockresearchFutureOptionsUrl,
    this.topstockresearchRiskProfileUrl,
    this.topstockresearchSolvencyUrl,
    this.topstockresearchUrl,
    this.topstockresearchVolatilityUrl,
    this.trendlyneId,
    this.updatedAt,
    this.yahoofinanceCode,
  });

  String code;
  String createdAt;
  String investingDividendsUrl;
  String investingDividendsYeildUrl;
  String investingEarningsUrl;
  String investingHistoricalDataUrl;
  String investingTechnicalIndicatorUrl;
  String isin;
  String marketsmojoId;
  String moneycontrolCode;
  String moneycontrolUrl;
  String topstockresearchFutureOptionsUrl;
  String topstockresearchRiskProfileUrl;
  String topstockresearchSolvencyUrl;
  String topstockresearchUrl;
  String topstockresearchVolatilityUrl;
  String trendlyneId;
  String updatedAt;
  String yahoofinanceCode;

  factory CodeSearch.fromJson(Map<String, dynamic> json) => CodeSearch(
        code: json["code"],
        createdAt: json["created_at"],
        investingDividendsUrl: json["investing_dividends_url"],
        investingDividendsYeildUrl: json["investing_dividends_yeild_url"],
        investingEarningsUrl: json["investing_earnings_url"],
        investingHistoricalDataUrl: json["investing_historical_data_url"],
        investingTechnicalIndicatorUrl:
            json["investing_technical_indicator_url"],
        isin: json["isin"],
        marketsmojoId: json["marketsmojo_id"],
        moneycontrolCode: json["moneycontrol_code"],
        moneycontrolUrl: json["moneycontrol_url"],
        topstockresearchFutureOptionsUrl:
            json["topstockresearch_future_options_url"],
        topstockresearchRiskProfileUrl:
            json["topstockresearch_risk_profile_url"],
        topstockresearchSolvencyUrl: json["topstockresearch_solvency_url"],
        topstockresearchUrl: json["topstockresearch_url"],
        topstockresearchVolatilityUrl: json["topstockresearch_volatility_url"],
        trendlyneId: json["trendlyne_id"],
        updatedAt: json["updated_at"],
        yahoofinanceCode: json["yahoofinance_code"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "created_at": createdAt,
        "investing_dividends_url": investingDividendsUrl,
        "investing_dividends_yeild_url": investingDividendsYeildUrl,
        "investing_earnings_url": investingEarningsUrl,
        "investing_historical_data_url": investingHistoricalDataUrl,
        "investing_technical_indicator_url": investingTechnicalIndicatorUrl,
        "isin": isin,
        "marketsmojo_id": marketsmojoId,
        "moneycontrol_code": moneycontrolCode,
        "moneycontrol_url": moneycontrolUrl,
        "topstockresearch_future_options_url": topstockresearchFutureOptionsUrl,
        "topstockresearch_risk_profile_url": topstockresearchRiskProfileUrl,
        "topstockresearch_solvency_url": topstockresearchSolvencyUrl,
        "topstockresearch_url": topstockresearchUrl,
        "topstockresearch_volatility_url": topstockresearchVolatilityUrl,
        "trendlyne_id": trendlyneId,
        "updated_at": updatedAt,
        "yahoofinance_code": yahoofinanceCode,
      };
}
