// To parse this JSON data, do
//
//     final etfCategoryModel = etfCategoryModelFromJson(jsonString);

import 'dart:convert';

List<EtfCategoryModel> etfCategoryModelFromJson(String str) =>
    List<EtfCategoryModel>.from(
        json.decode(str).map((x) => EtfCategoryModel.fromJson(x)));

String etfCategoryModelToJson(List<EtfCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EtfCategoryModel {
  EtfCategoryModel({
    this.highPrice,
    this.lastTradedPrice,
    this.lowPrice,
    this.netChange,
    this.percentChange,
    this.schemeId,
    this.schemeName,
    this.volume,
  });

  String highPrice;
  String lastTradedPrice;
  String lowPrice;
  String netChange;
  String percentChange;
  String schemeId;
  String schemeName;
  String volume;

  factory EtfCategoryModel.fromJson(Map<String, dynamic> json) =>
      EtfCategoryModel(
        highPrice: json["HighPrice"],
        lastTradedPrice: json["LastTradedPrice"],
        lowPrice: json["LowPrice"],
        netChange: json["NetChange"],
        percentChange: json["PercentChange"],
        schemeId: json["SchemeId"],
        schemeName: json["SchemeName"],
        volume: json["Volume"],
      );

  Map<String, dynamic> toJson() => {
        "HighPrice": highPrice,
        "LastTradedPrice": lastTradedPrice,
        "LowPrice": lowPrice,
        "NetChange": netChange,
        "PercentChange": percentChange,
        "SchemeId": schemeId,
        "SchemeName": schemeName,
        "Volume": volume,
      };
}

//new model for etf

List<EtfListModel> etfListModelFromJson(String str) => List<EtfListModel>.from(
    json.decode(str).map((x) => EtfListModel.fromJson(x)));

String etfListModelToJson(List<EtfListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EtfListModel {
  String backendParameter;
  String change;
  String changePer;
  String chartSymbol;
  String etfName;
  String high;
  String low;
  String open;
  String price;
  String symbol;

  EtfListModel(
      {this.backendParameter,
      this.change,
      this.changePer,
      this.chartSymbol,
      this.etfName,
      this.high,
      this.low,
      this.open,
      this.price,
      this.symbol});

  EtfListModel.fromJson(Map<String, dynamic> json) {
    backendParameter = json['backend_parameter'];
    change = json['change'];
    changePer = json['change_per'];
    chartSymbol = json['chart_symbol'];
    etfName = json['etf_name'];
    high = json['high'];
    low = json['low'];
    open = json['open'];
    price = json['price'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backend_parameter'] = this.backendParameter;
    data['change'] = this.change;
    data['change_per'] = this.changePer;
    data['chart_symbol'] = this.chartSymbol;
    data['etf_name'] = this.etfName;
    data['high'] = this.high;
    data['low'] = this.low;
    data['open'] = this.open;
    data['price'] = this.price;
    data['symbol'] = this.symbol;
    return data;
  }
}

EtfOverviewModel etfOverviewListModelFromJson(String str) =>
    EtfOverviewModel.fromJson(json.decode(str));
String etfOverviewListModelToJson(EtfOverviewModel data) =>
    json.encode(((x) => x.toJson()));

class EtfOverviewModel {
  String assetClass;
  String avgVol;
  String chartSymbol;
  String etfChange;
  String etfChangePer;
  String etfName;
  String high;
  String inceptionDate;
  String issuer;
  String low;
  String oneYearChg;
  String openValue;
  String prevClose;
  String price;
  String rating;
  String riskRating;
  String volume;
  String weekRange;

  EtfOverviewModel(
      {this.assetClass,
      this.avgVol,
      this.chartSymbol,
      this.etfChange,
      this.etfChangePer,
      this.etfName,
      this.high,
      this.inceptionDate,
      this.issuer,
      this.low,
      this.oneYearChg,
      this.openValue,
      this.prevClose,
      this.price,
      this.rating,
      this.riskRating,
      this.volume,
      this.weekRange});

  EtfOverviewModel.fromJson(Map<String, dynamic> json) {
    assetClass = json['asset_class'];
    avgVol = json['avg_vol'];
    chartSymbol = json['chart_symbol'];
    etfChange = json['etf_change'];
    etfChangePer = json['etf_change_per'];
    etfName = json['etf_name'];
    high = json['high'];
    inceptionDate = json['inception_date'];
    issuer = json['issuer'];
    low = json['low'];
    oneYearChg = json['one_year_chg'];
    openValue = json['open_value'];
    prevClose = json['prev_close'];
    price = json['price'];
    rating = json['rating'];
    riskRating = json['risk_rating'];
    volume = json['volume'];
    weekRange = json['week_range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asset_class'] = this.assetClass;
    data['avg_vol'] = this.avgVol;
    data['chart_symbol'] = this.chartSymbol;
    data['etf_change'] = this.etfChange;
    data['etf_change_per'] = this.etfChangePer;
    data['etf_name'] = this.etfName;
    data['high'] = this.high;
    data['inception_date'] = this.inceptionDate;
    data['issuer'] = this.issuer;
    data['low'] = this.low;
    data['one_year_chg'] = this.oneYearChg;
    data['open_value'] = this.openValue;
    data['prev_close'] = this.prevClose;
    data['price'] = this.price;
    data['rating'] = this.rating;
    data['risk_rating'] = this.riskRating;
    data['volume'] = this.volume;
    data['week_range'] = this.weekRange;
    return data;
  }
}
