// To parse this JSON data, do
//
//     final allStockResponse = allStockResponseFromJson(jsonString);

import 'dart:convert';

// AllStockResponse allStockResponseFromJson(String str) =>
//     AllStockResponse.fromJson(json.decode(str));

// String allStockResponseToJson(AllStockResponse data) =>
//     json.encode(data.toJson());

// class AllStockResponse {
//   AllStockResponse({
//     this.createdAt,
//     this.sector,
//     this.stocks,
//     this.updatedAt,
//   });

//   String createdAt;
//   String sector;
//   List<Stock> stocks;
//   String updatedAt;

//   factory AllStockResponse.fromJson(Map<String, dynamic> json) =>
//       AllStockResponse(
//         createdAt: json["created_at"],
//         sector: json["sector"],
//         stocks: List<Stock>.from(json["stocks"].map((x) => Stock.fromJson(x))),
//         updatedAt: json["updated_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "created_at": createdAt,
//         "sector": sector,
//         "stocks": List<dynamic>.from(stocks.map((x) => x.toJson())),
//         "updated_at": updatedAt,
//       };
// }

Stock watchlistStockFronJson(String str) => Stock.fromJson(json.decode(str));

// List<Stock> stockResponseFromJson(String str) =>
// List<Stock>.from((json.x) => json.decode(x));

class Stock {
  Stock(
      {this.change,
      this.changePercentage,
      this.isin,
      this.lastPrice,
      this.marketCap,
      this.moneycontrolLink,
      this.name,
      this.stockCode = ''});

  String change;
  String changePercentage;
  String isin;
  String lastPrice;
  String marketCap;
  String moneycontrolLink;
  String name;
  String stockCode;

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        change: json["change"] == null ? json["nse"]["change"] : json["change"],
        changePercentage: json["change_percentage"] == null
            ? json["nse"]["change_percent"]
            : json["change_percentage"],
        isin: json["isin"],
        lastPrice: json["last_price"] != null
            ? json["last_price"]
            : json["nse"]["price"],
        marketCap:
            json["market_cap"] != null ? json["market_cap"].toString() : "",
        moneycontrolLink:
            json["moneycontrol_link"] != null ? json["moneycontrol_link"] : '',
        name: json["name"] == null ? json["stock_name"] : json["name"],
        stockCode: json["stock_code"] == null ? null : json["stock_code"],
      );

  Map<String, dynamic> toJson() => {
        "change": change,
        "change_percentage": changePercentage,
        "isin": isin,
        "last_price": lastPrice,
        "market_cap": marketCap,
        "moneycontrol_link": moneycontrolLink,
        "name": name,
        "stock_code": stockCode
      };
}
