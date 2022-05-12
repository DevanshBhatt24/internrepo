import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:technical_ind/screens/commodity/business/commodity_overview_model.dart';
import 'package:technical_ind/screens/cryptocurrency/business/crypto_overview_model.dart'
    as historicalmodel;
import 'package:technical_ind/screens/stocks/business/models/peers.dart';
import 'package:technical_ind/screens/stocks/business/models/shockers.dart';
import 'package:technical_ind/screens/stocks/business/models/stockResponse.dart';
import 'models/StockDetailsModel.dart';
import 'models/allStockResponse.dart';
import 'models/buyerssellers.dart';
import 'models/gainerLoserModel.dart';
import 'models/mostActive.dart';
import 'models/stockPrice.dart';
import 'models/weekhighlow.dart';

bool isBeforeFourPM() {
  var fPM = TimeOfDay(hour: 15, minute: 30);
  var nAM = TimeOfDay(hour: 9, minute: 15);
  var fourPM = fPM.hour.toDouble() + fPM.minute.toDouble() / (60.0);
  var nineAM = nAM.hour.toDouble() + nAM.minute.toDouble() / (60.0);
  var abc = TimeOfDay.now();
  var now = abc.hour.toDouble() + abc.minute.toDouble() / (60.0);
  var today = DateTime.now();
  if (today.weekday >= 1 &&
      today.weekday <= 5 &&
      now >= nineAM &&
      now <= fourPM) {
    return true;
  } else
    return false;
}

class StockServices {
  static Future<Volatility> getVolatility(String isin) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=volatility_data&filter_name=identifier&filter_value=$isin';
    print(url);
    var response = await http.get(Uri.parse(url));
    final volatilityResponse = stockVolatilityFromJson(response.body);
    return volatilityResponse;
  }

  static Future<List<AllStockResponse>> allStocks(
      String sectorValue, bool isBse) async {
    String url = isBse
        ? 'https://api.bottomstreet.com/stocks/all_list?exchange=bse&sector=$sectorValue'
        : 'https://api.bottomstreet.com/stocks/all_list?exchange=nse&sector=$sectorValue';

    print(url);

    var response = await http.get(Uri.parse(url));
    var jsonBody = json.decode(response.body);
    final allStockResponse = List<AllStockResponse>.from(
        jsonBody.map((x) => AllStockResponse.fromJson(x)));
    // final allStockResponse = allStockResponseFromJson(response.body);
    return allStockResponse;
  }

  static Future<StockPrice> stockPrice(String isin) async {
    String url = 'https://api.bottomstreet.com/stock/prices?isin=$isin';
    print(url);
    var response = await http.get(Uri.parse(url));
    final stockPrice = stockPriceFromJson(response.body);
    return stockPrice;
  }

  static Future<FutureAndOptions> stockFutureandOptionsDetails(
      String isin) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=futures_and_options_data&filter_name=identifier&filter_value=$isin';
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      final stockPrice = stockFutureandOptionFromJson(response.body);
      return stockPrice;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<Shareholding> stockShareholdingDetails(String isin) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=stocks_shareholding_data&filter_name=identifier&filter_value=$isin';
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      var jsonBody = json.decode(response.body);
      // print(jsonBody["shareholding_data"]);
      final shareholding = Shareholding.fromJson(jsonBody["shareholding_data"]);

      return shareholding;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<Scrutiny> stockScrutinyDetails(String isin) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=stocks_scrutiny_data&filter_name=identifier&filter_value=$isin';
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      var jsonBody = json.decode(response.body);
      print(jsonBody);
      final scrutiny = Scrutiny.fromJson(jsonBody["scrutiny_data"]);

      return scrutiny;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<Esg> stockEsgDetails(String isin) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=stocks_esg_data&filter_name=identifier&filter_value=$isin';
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      var jsonBody = json.decode(response.body);
      print(jsonBody);
      final esg = Esg.fromJson(jsonBody["esg_data"]);

      return esg;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<QuickSummary> stockSummaryDetails(String isin) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=stock_quick_summary_data&filter_name=identifier&filter_value=$isin';
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      var jsonBody = json.decode(response.body);
      print(jsonBody);
      final summary = QuickSummary.fromJson(jsonBody["quick_summary_data"]);

      return summary;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<About> stockAboutDetails(String isin) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=stocks_about_data&filter_name=identifier&filter_value=$isin';
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      var jsonBody = json.decode(response.body);
      print(jsonBody);
      final scrutiny = About.fromJson(jsonBody["about_data"]);

      return scrutiny;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<Swot> stockSwotDetails(String isin) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=stocks_swot_data&filter_name=identifier&filter_value=$isin';
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      var jsonBody = json.decode(response.body);
      // print(jsonBody);
      final swot = Swot.fromJson(jsonBody["swot_data"]);

      return swot;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<CrucialChecklist> stockCrucialChecklistDetails(
      String isin) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=stocks_crucial_checklist_data&filter_name=identifier&filter_value=$isin';
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      var jsonBody = json.decode(response.body);
      // print(jsonBody);
      final crucialchecklist =
          CrucialChecklist.fromJson(jsonBody["crucial_checklist_data"]);

      return crucialchecklist;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<Deals> stockDealstDetails(String isin) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=stocks_deals_data&filter_name=identifier&filter_value=$isin';
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      var jsonBody = json.decode(response.body);
      // print(jsonBody);
      final crucialchecklist = Deals.fromJson(jsonBody["deals_data"]);

      return crucialchecklist;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<Broadcast> stockBroadcastDetails(String isin) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=stocks_broadcast_data&filter_name=identifier&filter_value=$isin';
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      var jsonBody = json.decode(response.body);
      // print(jsonBody);
      final broadcast = Broadcast.fromJson(jsonBody["broadcast_data"]);

      return broadcast;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<ReturnsClass> stockReturnsDetails(String isin) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=stocks_returns_data&filter_name=identifier&filter_value=$isin';
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      var jsonBody = json.decode(response.body);
      print(jsonBody);
      final returns = ReturnsClass.fromJson(jsonBody["returns_data"]);

      return returns;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<dynamic> stockFinancialDetails(String isin) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=stocks_financials_data&filter_name=identifier&filter_value=$isin';
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      var jsonBody = json.decode(response.body);
      // print(jsonBody);
      return jsonBody;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<Quotes> stockQuotesDetails(String isin) async {
    try {
      String url = "https://api.bottomstreet.com/stocks/overview?isin=$isin";
      print(url);
      var response = await http.get(Uri.parse(url));

      final stockQuotes = stockQuotesfromJson(response.body);
      return stockQuotes;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<historicalmodel.HistoricalData> stockHistoricalDataDetails(
      String isin) async {
    try {
      String url =
          "https://api.bottomstreet.com/api/data?page=historical_data&filter_name=identifier&filter_value=$isin";
      var response = await http.get(Uri.parse(url));

      final stockhistoricalData =
          historicalmodel.stockHistoricalDetailFromJson(response.body);

      return stockhistoricalData;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<CommodityOverviewModelTechnicalIndicator> stockTechnicalDetail(
      String isin) async {
    try {
      String url = "https://api.bottomstreet.com/stocks/technical?isin=$isin";
      var response = await http.get(Uri.parse(url));

      final stockhistoricalData = stockTechnicalFromJson(response.body);

      return stockhistoricalData;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<Stock> watchStockDetail(var isin) async {
    try {
      String url = 'https://api.bottomstreet.com/stock/prices?isin=$isin';
      var response = await http.get(Uri.parse(url));
      // print(json.decode(response.body));
      final stock = watchlistStockFronJson(response.body);
      return stock;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<StockDetail> stockDetail(String isin) async {
    try {
      String url = 'https://api.bottomstreet.com/stocks/detail?isin=$isin';
      // String url =
      //     'https://api.bottomstreet.com/api/data?page=stocks_demo&filter_name=isin&filter_value=INE002A010189';
      print(url);
      var response = await http.get(Uri.parse(url));
      final stockDetail = stockDetailFromJson(response.body);
      return stockDetail;
    } catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s,
          reason: "error converting object from stocksdetail api",
          printDetails: true);
      return null;
      // FirebaseCrashlytics.instance.crash();
    }
  }

  static Future<Valuation> stockValuationDetail(String isin) async {
    try {
      String url =
          'https://api.bottomstreet.com/api/data?page=stocks_valuation_data&filter_name=identifier&filter_value=$isin';

      print(url);
      var response = await http.get(Uri.parse(url));
      final valuation =
          Valuation.fromJson(json.decode(response.body)["valuation_data"]);
      return valuation;
    } catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s,
          reason: "error converting object from stocksdetail api",
          printDetails: true);
      return null;
      // FirebaseCrashlytics.instance.crash();
    }
  }

  static Future<Quality> stockQualityDetail(String isin) async {
    try {
      String url =
          'https://api.bottomstreet.com/api/data?page=stocks_quality_data&filter_name=identifier&filter_value=$isin';

      print(url);
      var response = await http.get(Uri.parse(url));
      final quality =
          Quality.fromJson(json.decode(response.body)["quality_data"]);
      return quality;
    } catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s,
          reason: "error converting object from stocksdetail api",
          printDetails: true);
      return null;
      // FirebaseCrashlytics.instance.crash();
    }
  }

  static Future<Delivery> deliveryDetail(String isin) async {
    var deliveryDetail;
    String url =
        'https://api.bottomstreet.com/api/data?page=delivery_data&filter_name=identifier&filter_value=$isin';
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      var jsonString = response.body;
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      // print(jsonMap);
      deliveryDetail = Delivery.fromJson(jsonMap['delivery_data']);
      print(deliveryDetail);
      return deliveryDetail;
    } catch (e) {
      print(e);
      return deliveryDetail;
    }
  }

  static Future<List<BseMostActive>> mostActiveBse(String code) async {
    String url =
        'https://api.bottomstreet.com/stocks/mostactive?exchange=bse&index_type=$code';
    print(url);
    List<BseMostActive> list = [];
    var response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body);
    list = List<BseMostActive>.from(
        jsonData.map((x) => BseMostActive.fromJson(x)));
    return list;
  }

  static Future<List<BseMostActive>> mostActiveNse(String code) async {
    String url =
        'https://api.bottomstreet.com/stocks/mostactive?exchange=nse&index_type=$code';
    print(url);
    var response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body);
    List<BseMostActive> list = [];
    list = List<BseMostActive>.from(
        jsonData.map((x) => BseMostActive.fromJson(x)));
    return list;
  }

  static Future<List<Gainer>> gainers(String code) async {
    // var a = code.lastIndexOf('-');
    // code = code.substring(0, a) + '_' + code.substring(a + 1);
    String url =
        'https://api.bottomstreet.com/stocks/gainers_losers?category=bse-gainer&index_name=${code}';
    print(url);
    var response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body);
    List<Gainer> list = [];

    list = List<Gainer>.from(jsonData.map((x) => Gainer.fromJson(x)));
    return list;
  }

  static Future<List<Gainer>> losers(String code, String type) async {
    String url =
        'https://api.bottomstreet.com/stocks/gainers_losers?category=$type-loser&index_name=${code}';
    // print(url);
    var response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body);
    List<Gainer> list = [];
    list = List<Gainer>.from(jsonData.map((x) => Gainer.fromJson(x)));
    return list;
  }

  static Future<List<BuyerSeller>> buyerSellers(
      String page, String filter) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=$page&filter_name=identifier&filter_value=$filter';
    print(url);
    var response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body);
    List<BuyerSeller> bs = [];
    if (page == "stock_buyers")
      bs = List<BuyerSeller>.from(jsonData.map((x) => BuyerSeller.fromJson(x)));
    else
      bs = List<BuyerSeller>.from(jsonData.map((x) => BuyerSeller.fromJson(x)));

    return bs;
  }

  static Future<List<PriceShocker>> shockers(
      String type, String filter, bool a) async {
    String url =
        'https://api.bottomstreet.com/stocks/${filter}s?exchange=$type';
    print(url);
    var response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body);
    List<PriceShocker> bs = [];
    // if (page == "stock_priceshocker")
    //   bs = List<PriceShocker>.from(jsonData["price_shockers"]
    //       .map((x) => PriceShocker.fromJson(x, true)));
    // else
    //   bs = List<PriceShocker>.from(jsonData["volume_shockers"]
    //       .map((x) => PriceShocker.fromJson(x, false)));
    // if (jsonData["success"] == false) {
    //   return null;
    // }

    bs = List<PriceShocker>.from(
        jsonData.map((x) => PriceShocker.fromJson(x, a)));
    if (bs.isEmpty) {
      return null;
    }
    return bs;
  }

  static Future<List<HighLow>> weekHighLowBSE(String type) async {
    String url =
        'https://api.bottomstreet.com/stocks/weekhighlow?category=$type';
    print(url);
    var response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body);

    // final weekHighLow = weekHighLowFromJson(response.body);
    List<HighLow> bs = [];

    bs = List<HighLow>.from(jsonData.map((x) => HighLow.fromJson(x)));

    if (bs.isEmpty) {
      return null;
    }
    return bs;
  }

  static Future<List<HighLow>> weekHighLowNSE(String type) async {
    String url =
        'https://api.bottomstreet.com/stocks/weekhighlow?category=$type';
    print(url);
    var response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body);

    // final weekHighLow = weekHighLowFromJson(response.body);
    List<HighLow> bs = [];

    bs = List<HighLow>.from(jsonData.map((x) => HighLow.fromJson(x)));

    if (bs.isEmpty) {
      return null;
    }
    return bs;
  }

  static Future<List<Peers>> getPeers(String isin) async {
    String url = "https://api.bottomstreet.com/stocks/peers?isin=$isin";
    var response = await http.get(Uri.parse(url));
    var jsonBody = json.decode(response.body);
    // print(jsonBody);
    final peers = List<Peers>.from(jsonBody.map((x) => Peers.fromJson(x)));
    // print(peers);
    return peers;
  }

  static Future<List<BuyerSeller>> getBuyers(String type) async {
    String url =
        "https://api.bottomstreet.com/stocks/buyers_sellers?category=buyers&exchange=$type";
    var response = await http.get(Uri.parse(url));
    var jsonBody = json.decode(response.body);
    // print(jsonBody);
    final buyers =
        List<BuyerSeller>.from(jsonBody.map((x) => BuyerSeller.fromJson(x)));
    // print(peers);
    return buyers;
  }

  static Future<List<BuyerSeller>> getSellers(String type) async {
    String url =
        "https://api.bottomstreet.com/stocks/buyers_sellers?category=sellers&exchange=$type";
    var response = await http.get(Uri.parse(url));
    var jsonBody = json.decode(response.body);
    // print(jsonBody);
    final sellers =
        List<BuyerSeller>.from(jsonBody.map((x) => BuyerSeller.fromJson(x)));
    // print(peers);
    return sellers;
  }
}

class StockServices2{
  static Future<StockModel2> getTopGainers() async {
    String url =
        "https://api.bottomstreet.com/stocks/topGainers";
    var response = await http.get(Uri.parse(url));
    var jsonBody = json.decode(response.body);
    // print(jsonBody);
    final result =
StockModel2.fromJson(jsonBody);    // print(peers);
    return result;
  }

  static Future<StockModel2> getTopLosers() async {
    String url =
        "https://api.bottomstreet.com/stocks/topLosers";
    var response = await http.get(Uri.parse(url));
    var jsonBody = json.decode(response.body);
    // print(jsonBody);
    final result =
StockModel2.fromJson(jsonBody);    // print(peers);
    return result;
  }

  static Future<StockModel2> getMostActive() async {
    String url =
        "https://api.bottomstreet.com/stocks/mostActive";
    var response = await http.get(Uri.parse(url));
    var jsonBody = json.decode(response.body);
    // print(jsonBody);
    final result =
StockModel2.fromJson(jsonBody);    // print(peers);
    return result;
  }

  static Future<StockModel2> get52WeekLow() async {
    String url =
        "https://api.bottomstreet.com/stocks/weeklow";
    var response = await http.get(Uri.parse(url));
    var jsonBody = json.decode(response.body);
    // print(jsonBody);
    final result =
StockModel2.fromJson(jsonBody);    // print(peers);
    return result;
  }

  static Future<StockModel2> get52WeekHigh() async {
    String url =
        "https://api.bottomstreet.com/stocks/weekhigh";
    var response = await http.get(Uri.parse(url));
    var jsonBody = json.decode(response.body);
    // print(jsonBody);
    final result =
       StockModel2.fromJson(jsonBody);
    // print(peers);
    return result;
  }

  static Future<StockModel2> getTrending() async {
    String url =
        "https://api.bottomstreet.com/stocks/trending";
    var response = await http.get(Uri.parse(url));
    var jsonBody = json.decode(response.body);
    // print(jsonBody);
    final result =
StockModel2.fromJson(jsonBody);    // print(peers);
    return result;
  }


}
