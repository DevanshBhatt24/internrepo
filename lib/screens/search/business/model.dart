import 'dart:convert';

List<StockSearch> stockSearchFromJson(String str) => List<StockSearch>.from(
    json.decode(str).map((x) => StockSearch.fromJson(x)));

String stockSearchToJson(List<StockSearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockSearch {
  StockSearch({
    this.name,
    this.shortCode,
    this.sector,
    this.isin,
    this.stockCode,
  });

  String name;
  String sector;
  String isin;
  String stockCode;
  String shortCode;

  factory StockSearch.fromJson(Map<String, dynamic> json) => StockSearch(
        name: json["company_name"],
        sector: json["sector"],
        shortCode: json["short_code"],
        isin: json["isin"],
        stockCode: json["bse_code"].toString(),
        // name:
        //     json["company_name"] != null ? json["company_name"] : json["name"],
        // sector: json["sector"],
        // shortCode: json["short_code"],
        // isin: json["isin"],
        // stockCode: json["stock_code"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": name,
        "sector": sector,
        "short_code": shortCode,
        "isin": isin,
        "bse_code": stockCode,
      };
}

// class StockSearch {
//   StockSearch({
//     this.name,
//     this.sector,
//     this.isin,
//     this.stockCode,
//   });

//   String name;
//   String sector;
//   String isin;
//   String stockCode;

//   factory StockSearch.fromJson(Map<String, dynamic> json) => StockSearch(
//         name: json["name"],
//         sector: json["sector"],
//         isin: json["isin"],
//         stockCode: json["stock_code"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "sector": sector,
//         "isin": isin,
//         "stock_code": stockCode,
//       };
// }
//------------------------------------------------------------------------------

List<IndicesSearch> indicesSearchFromJson(String str) =>
    List<IndicesSearch>.from(
        json.decode(str).map((x) => IndicesSearch.fromJson(x)));

String indicesSearchToJson(List<IndicesSearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IndicesSearch {
  IndicesSearch({
    this.indiceName,
  });

  String indiceName;

  factory IndicesSearch.fromJson(Map<String, dynamic> json) => IndicesSearch(
        indiceName: json["INDICE_NAME"],
      );

  Map<String, dynamic> toJson() => {
        "INDICE_NAME": indiceName,
      };
}

//-----------------------------------------------------------------------------

List<FundEtfSearch> fundEtfSearchFromJson(String str) =>
    List<FundEtfSearch>.from(
        json.decode(str).map((x) => FundEtfSearch.fromJson(x)));

String fundEtfSearchToJson(List<FundEtfSearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FundEtfSearch {
  FundEtfSearch({
    this.fundName,
    this.url,
    this.field3,
  });

  String fundName;
  String url;
  int field3;

  factory FundEtfSearch.fromJson(Map<String, dynamic> json) => FundEtfSearch(
        fundName: json["FUND_NAME"],
        url: json["URL"],
        field3: json["FIELD3"],
      );

  Map<String, dynamic> toJson() => {
        "FUND_NAME": fundName,
        "URL": url,
        "FIELD3": field3,
      };
}

//------------------------------------------------------------------------------

List<EtfSearch> etfSearchFromJson(String str) =>
    List<EtfSearch>.from(json.decode(str).map((x) => EtfSearch.fromJson(x)));

String etfSearchToJson(List<FundEtfSearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EtfSearch {
  EtfSearch({
    this.fundName,
    this.id,
  });

  String fundName;
  String id;

  factory EtfSearch.fromJson(Map<String, dynamic> json) => EtfSearch(
        fundName: json["etf_name"],
        id: json["backend_parameter"],
      );

  Map<String, dynamic> toJson() => {
        "etf_name": fundName,
        "id": id,
      };
}

//------------------------------------------------------------------------------

List<ForexSearch> forexSearchFromJson(String str) => List<ForexSearch>.from(
    json.decode(str).map((x) => ForexSearch.fromJson(x)));

String forexSearchToJson(List<ForexSearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ForexSearch {
  ForexSearch({
    this.currencyName,
  });

  String currencyName;

  factory ForexSearch.fromJson(Map<String, dynamic> json) => ForexSearch(
        currencyName: json["CURRENCY_NAME"],
      );

  Map<String, dynamic> toJson() => {
        "CURRENCY_NAME": currencyName,
      };
}

//------------------------------------------------------------------------------

List<CryptoSearch> cryptoSearchFromJson(String str) => List<CryptoSearch>.from(
    json.decode(str).map((x) => CryptoSearch.fromJson(x)));

String cryptoSearchToJson(List<CryptoSearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CryptoSearch {
  CryptoSearch({
    this.fullName,
    this.symbol,
    this.ticker,
  });

  String fullName;
  String symbol;
  String ticker;

  factory CryptoSearch.fromJson(Map<String, dynamic> json) => CryptoSearch(
        fullName: json["FULL_NAME"],
        symbol: json["SYMBOL"],
        ticker: json["TICKER"],
      );

  Map<String, dynamic> toJson() => {
        "FULL_NAME": fullName,
        "SYMBOL": symbol,
        "TICKER": ticker,
      };
}

//------------------------------------------------------------------------------

List<CommoditySearch> commoditySearchFromJson(String str) =>
    List<CommoditySearch>.from(
        json.decode(str).map((x) => CommoditySearch.fromJson(x)));

String commoditySearchToJson(List<CommoditySearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommoditySearch {
  CommoditySearch({
    this.commodityName,
    this.categoricalCommodityName,
  });

  String commodityName;
  String categoricalCommodityName;

  factory CommoditySearch.fromJson(Map<String, dynamic> json) =>
      CommoditySearch(
        commodityName: json["COMMODITY_NAME"],
        categoricalCommodityName: json["CATEGORICAL_COMMODITY_NAME"],
      );

  Map<String, dynamic> toJson() => {
        "COMMODITY_NAME": commodityName,
        "CATEGORICAL_COMMODITY_NAME": categoricalCommodityName,
      };
}

//------------------------------------------------------------------------------

//Ticker symbol

List<TickerSymbolSearch> tickerSymbolSearchFromJson(String str) =>
    List<TickerSymbolSearch>.from(
        json.decode(str).map((x) => TickerSymbolSearch.fromJson(x)));

String tickerSymbolSearchToJson(List<TickerSymbolSearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TickerSymbolSearch {
  TickerSymbolSearch({
    this.tickerSymbol,
    this.name,
  });

  dynamic tickerSymbol;
  String name;

  factory TickerSymbolSearch.fromJson(Map<String, dynamic> json) =>
      TickerSymbolSearch(
        tickerSymbol: json["TICKER_SYMBOL"],
        name: json["NAME"],
      );

  Map<String, dynamic> toJson() => {
        "TICKER_SYMBOL": tickerSymbol,
        "NAME": name,
      };
}
