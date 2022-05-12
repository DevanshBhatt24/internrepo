// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(
    json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
  SearchModel({
    this.stockSearchIndex,
    this.mutualSearchIndex,
    this.cryptoSearchIndex,
    this.commoditySearchIndex,
    this.indicesSearchIndex,
    this.currencySearchIndex,
  });

  List<StockSearchIndex> stockSearchIndex;
  List<MutualSearchIndex> mutualSearchIndex;
  List<CryptoSearchIndex> cryptoSearchIndex;
  List<CommoditySearchIndex> commoditySearchIndex;
  List<IndicesSearchIndex> indicesSearchIndex;
  List<CurrencySearchIndex> currencySearchIndex;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        stockSearchIndex: json["stock_search_index"] == null
            ? null
            : List<StockSearchIndex>.from(json["stock_search_index"]
                .map((x) => StockSearchIndex.fromJson(x))),
        mutualSearchIndex: json["mutual_search_index"] == null
            ? null
            : List<MutualSearchIndex>.from(json["mutual_search_index"]
                .map((x) => MutualSearchIndex.fromJson(x))),
        cryptoSearchIndex: json["crypto_search_index"] == null
            ? null
            : List<CryptoSearchIndex>.from(json["crypto_search_index"]
                .map((x) => CryptoSearchIndex.fromJson(x))),
        commoditySearchIndex: json["commodity_search_index"] == null
            ? null
            : List<CommoditySearchIndex>.from(json["commodity_search_index"]
                .map((x) => CommoditySearchIndex.fromJson(x))),
        indicesSearchIndex: json["indices_search_index"] == null
            ? null
            : List<IndicesSearchIndex>.from(json["indices_search_index"]
                .map((x) => IndicesSearchIndex.fromJson(x))),
        currencySearchIndex: json["currency_search_index"] == null
            ? null
            : List<CurrencySearchIndex>.from(json["currency_search_index"]
                .map((x) => CurrencySearchIndex.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stock_search_index": stockSearchIndex == null
            ? null
            : List<dynamic>.from(stockSearchIndex.map((x) => x.toJson())),
        "mutual_search_index": mutualSearchIndex == null
            ? null
            : List<dynamic>.from(mutualSearchIndex.map((x) => x.toJson())),
        "crypto_search_index": cryptoSearchIndex == null
            ? null
            : List<dynamic>.from(cryptoSearchIndex.map((x) => x.toJson())),
        "commodity_search_index": commoditySearchIndex == null
            ? null
            : List<dynamic>.from(commoditySearchIndex.map((x) => x.toJson())),
        "indices_search_index": indicesSearchIndex == null
            ? null
            : List<dynamic>.from(indicesSearchIndex.map((x) => x.toJson())),
        "currency_search_index": currencySearchIndex == null
            ? null
            : List<dynamic>.from(currencySearchIndex.map((x) => x.toJson())),
      };
}

class CommoditySearchIndex {
  CommoditySearchIndex({
    this.categoricalCommodityName,
    this.commodityName,
    this.id,
  });

  String categoricalCommodityName;
  String commodityName;
  String id;

  factory CommoditySearchIndex.fromJson(Map<String, dynamic> json) =>
      CommoditySearchIndex(
        categoricalCommodityName: json["CATEGORICAL_COMMODITY_NAME"],
        commodityName: json["COMMODITY_NAME"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "CATEGORICAL_COMMODITY_NAME": categoricalCommodityName,
        "COMMODITY_NAME": commodityName,
        "_id": id,
      };
}

class CryptoSearchIndex {
  CryptoSearchIndex({
    this.fullName,
    this.symbolName,
    this.id,
  });

  String fullName;
  String symbolName;
  String id;

  factory CryptoSearchIndex.fromJson(Map<String, dynamic> json) =>
      CryptoSearchIndex(
        fullName: json["FULL_NAME"],
        symbolName: json["SYMBOL_NAME"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "FULL_NAME": fullName,
        "SYMBOL_NAME": symbolName,
        "_id": id,
      };
}

class CurrencySearchIndex {
  CurrencySearchIndex({
    this.currencyName,
    this.inAur,
    this.inCad,
    this.inChf,
    this.inCny,
    this.inEur,
    this.inGbp,
    this.inInr,
    this.inJpy,
    this.inNzd,
    this.inSek,
    this.id,
  });

  String currencyName;
  String inAur;
  String inCad;
  String inChf;
  String inCny;
  String inEur;
  String inGbp;
  String inInr;
  String inJpy;
  String inNzd;
  String inSek;
  String id;

  factory CurrencySearchIndex.fromJson(Map<String, dynamic> json) =>
      CurrencySearchIndex(
        currencyName: json["CURRENCY_NAME"],
        inAur: json["IN_AUR"],
        inCad: json["IN_CAD"],
        inChf: json["IN_CHF"],
        inCny: json["IN_CNY"],
        inEur: json["IN_EUR"],
        inGbp: json["IN_GBP"],
        inInr: json["IN_INR"],
        inJpy: json["IN_JPY"],
        inNzd: json["IN_NZD"],
        inSek: json["IN_SEK"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "CURRENCY_NAME": currencyName,
        "IN_AUR": inAur,
        "IN_CAD": inCad,
        "IN_CHF": inChf,
        "IN_CNY": inCny,
        "IN_EUR": inEur,
        "IN_GBP": inGbp,
        "IN_INR": inInr,
        "IN_JPY": inJpy,
        "IN_NZD": inNzd,
        "IN_SEK": inSek,
        "_id": id,
      };
}

class IndicesSearchIndex {
  IndicesSearchIndex({
    this.indiceName,
    this.id,
  });

  String indiceName;
  String id;

  factory IndicesSearchIndex.fromJson(Map<String, dynamic> json) =>
      IndicesSearchIndex(
        indiceName: json["INDICE_NAME"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "INDICE_NAME": indiceName,
        "_id": id,
      };
}

class MutualSearchIndex {
  MutualSearchIndex({
    this.fundName,
    this.url,
    this.id,
  });

  String fundName;
  String url;
  String id;

  factory MutualSearchIndex.fromJson(Map<String, dynamic> json) =>
      MutualSearchIndex(
        fundName: json["FUND_NAME"],
        url: json["URL"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "FUND_NAME": fundName,
        "URL": url,
        "_id": id,
      };
}

class StockSearchIndex {
  StockSearchIndex({
    this.isinKey,
    this.sector,
    this.stockName,
    this.id,
  });

  String isinKey;
  String sector;
  String stockName;
  String id;

  factory StockSearchIndex.fromJson(Map<String, dynamic> json) =>
      StockSearchIndex(
        isinKey: json["ISIN_KEY"],
        sector: json["SECTOR"],
        stockName: json["STOCK_NAME"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "ISIN_KEY": isinKey,
        "SECTOR": sector,
        "STOCK_NAME": stockName,
        "_id": id,
      };
}
