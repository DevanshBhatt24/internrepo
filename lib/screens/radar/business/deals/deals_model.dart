// To parse this JSON data, do
//
//     final dealsmodel = dealsmodelFromJson(jsonString);

import 'dart:convert';

Dealsmodel dealsmodelFromJson(String str) =>
    Dealsmodel.fromJson(json.decode(str));

String dealsmodelToJson(Dealsmodel data) => json.encode(data.toJson());

class Dealsmodel {
  Dealsmodel({
    this.blockdeals,
    this.bulkdeals,
    this.insiderdeals,
    this.largedeals,
  });

  List<Kdeal> blockdeals;
  List<Kdeal> bulkdeals;
  List<Insiderdeal> insiderdeals;
  List<Largedeal> largedeals;

  factory Dealsmodel.fromJson(Map<String, dynamic> json) => Dealsmodel(
        blockdeals:
            List<Kdeal>.from(json["blockdeals"].map((x) => Kdeal.fromJson(x))),
        bulkdeals:
            List<Kdeal>.from(json["bulkdeals"].map((x) => Kdeal.fromJson(x))),
        insiderdeals: List<Insiderdeal>.from(
            json["insiderdeals"].map((x) => Insiderdeal.fromJson(x))),
        largedeals: List<Largedeal>.from(
            json["largedeals"].map((x) => Largedeal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "blockdeals": List<dynamic>.from(blockdeals.map((x) => x.toJson())),
        "bulkdeals": List<dynamic>.from(bulkdeals.map((x) => x.toJson())),
        "insiderdeals": List<dynamic>.from(insiderdeals.map((x) => x.toJson())),
        "largedeals": List<dynamic>.from(largedeals.map((x) => x.toJson())),
      };
}

class Kdeal {
  Kdeal({
    this.client,
    this.closed,
    this.company,
    this.date,
    this.quantity,
    this.traded,
    this.transaction,
    this.stockCode,
  });

  String client;
  String closed;
  String company;
  String date;
  String quantity;
  String traded;
  String stockCode;
  String transaction;

  factory Kdeal.fromJson(Map<String, dynamic> json) => Kdeal(
        client: json["client"],
        closed: json["closed"],
        company: json["company"],
        date: json["date"],
        quantity: json["quantity"],
        traded: json["traded"],
        stockCode: json["Stock_code"],
        transaction: json["transaction"],
      );

  Map<String, dynamic> toJson() => {
        "client": client,
        "closed": closed,
        "company": company,
        "date": date,
        "quantity": quantity,
        "traded": traded,
        "transaction": transaction,
      };
}

class Insiderdeal {
  Insiderdeal({
    this.action,
    this.avgPrice,
    this.clientCategory,
    this.clientName,
    this.postTransactionHolding,
    this.quantity,
    this.reportedToExchange,
    this.stockName,
    this.stockCode,
    this.trade,
  });

  String action;
  String avgPrice;
  String clientCategory;
  String clientName;
  String postTransactionHolding;
  String quantity;
  String reportedToExchange;
  String stockName;
  String stockCode;
  String trade;

  factory Insiderdeal.fromJson(Map<String, dynamic> json) => Insiderdeal(
        action: json["action"],
        avgPrice: json["avg_price"],
        clientCategory: json["client_category"],
        clientName: json["client_name"],
        postTransactionHolding: json["post_transaction_holding"],
        quantity: json["quantity"],
        reportedToExchange: json["reported_to_exchange"],
        stockName: json["stock_name"],
        stockCode: json["stock_code"],
        trade: json["trade_%"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "avg_price": avgPrice,
        "client_category": clientCategory,
        "client_name": clientName,
        "post_transaction_holding": postTransactionHolding,
        "quantity": quantity,
        "reported_to_exchange": reportedToExchange,
        "stock_name": stockName,
        "trade_%": trade,
      };
}

class Largedeal {
  Largedeal(
      {this.companyName,
      this.exchange,
      this.price,
      this.quantity,
      this.sector,
      this.valueCr,
      this.stockCode});

  String companyName;
  String exchange;
  String price;
  String quantity;
  String sector;
  String valueCr;
  String stockCode;

  factory Largedeal.fromJson(Map<String, dynamic> json) => Largedeal(
        companyName: json["company_name"],
        exchange: json["exchange"],
        price: json["price"],
        quantity: json["quantity"],
        sector: json["sector"],
        valueCr: json["value_cr"],
        stockCode: json["Stock_code"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "exchange": exchange,
        "price": price,
        "quantity": quantity,
        "sector": sector,
        "value_cr": valueCr,
      };
}
