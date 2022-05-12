import 'package:technical_ind/screens/cryptocurrency/business/crypto_overview_model.dart'
    as forex;
import 'package:technical_ind/screens/forex/business/forexmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'forexExplore.dart';

class ForexServices {
  static Future<ForexModel> forexlist(String code) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=forex_currency_list&filter_name=currerncy_id&filter_value=$code';
    print(url);
    var response = await http.get(Uri.parse(url));
    final forexModel = forexModelFromJson(response.body);
    return forexModel;
  }

  static Future<ForexExplore> forexExplore(String code) async {
    // print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' + code);
    String overviewUrl =
        'https://api.bottomstreet.com/forex/overview?forex_name=$code';
    // print(url);
    var response = await http.get(Uri.parse(overviewUrl));
    var jsonBody = json.decode(response.body);
    Overview overview = Overview.fromJson(jsonBody);
    String technicalIndicatorUrl =
        'https://api.bottomstreet.com/forex/technical?forex_name=$code';
    // print(url);
    response = await http.get(Uri.parse(technicalIndicatorUrl));
    jsonBody = json.decode(response.body);
    // print(jsonBody);
    ForexExploreTechnicalIndicator technicalIndicator =
        ForexExploreTechnicalIndicator.fromJson(jsonBody);

    String historicalDataUrl =
        'https://api.bottomstreet.com/api/data?page=historical_data&filter_name=identifier&filter_value=$code';
    // print(url);
    response = await http.get(Uri.parse(historicalDataUrl));
    jsonBody = json.decode(response.body);
    forex.HistoricalData historicalData =
        forex.HistoricalData.fromJson(jsonBody["historical_data"]);

    final forexExplore = ForexExplore(
        historicalData: historicalData,
        overview: overview,
        technicalIndicator: technicalIndicator);

    return forexExplore;
  }

  static Future<Overview> getForexOverview(String code) async {
    String overviewUrl =
        'https://api.bottomstreet.com/forex/overview?forex_name=$code';
    var response = await http.get(Uri.parse(overviewUrl));
    var jsonBody = json.decode(response.body);
    Overview overview = Overview.fromJson(jsonBody);
    return overview;
  }

  static Future<ForexExploreTechnicalIndicator> getForexTechnicalIndicator(
      String code) async {
    String technicalIndicatorUrl =
        'https://api.bottomstreet.com/forex/technical?forex_name=$code';
    // print(url);
    var response = await http.get(Uri.parse(technicalIndicatorUrl));
    var jsonBody = json.decode(response.body);
    // print(jsonBody);
    ForexExploreTechnicalIndicator technicalIndicator =
        ForexExploreTechnicalIndicator.fromJson(jsonBody);
    return technicalIndicator;
  }

  static Future<forex.HistoricalData> getForexHistoricalData(
      String code) async {
    String historicalDataUrl =
        'https://api.bottomstreet.com/api/data?page=historical_data&filter_name=identifier&filter_value=$code';
    // print(url);
    var response = await http.get(Uri.parse(historicalDataUrl));
    var jsonBody = json.decode(response.body);
    forex.HistoricalData historicalData =
        forex.HistoricalData.fromJson(jsonBody["historical_data"]);
    return historicalData;
  }

  static Future searchForex(String code) async {
    String url = 'https://api.bottomstreet.com/forex/prices?forex_name=$code';
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  static Future<ForexWatch> watchForex(var code) async {
    try {
      String url =
          'https://api.bottomstreet.com/forex/prices?forex_name=$code';
      var response = await http.get(Uri.parse(url));
      final crypto = watchlistForexFromJson(response.body);
      return crypto;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }


}
