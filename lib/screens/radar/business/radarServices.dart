import 'package:http/http.dart' as http;
import 'package:technical_ind/screens/radar/business/tradingActivity.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';

import 'dalalRoad.dart';
import 'events.dart';

import 'dart:convert';

class RadarServices {
  static Future<List<dynamic>> clocktradinghours(String s) async {
    var response = await http.get(Uri.parse(s));
    return json.decode(response.body);
  }

  static Future<List<TradingActivityModel>> tradingActivity() async {
    String url =
        'https://api.bottomstreet.com/api/data?page=trading_activity_list';
    print(url);
    var response = await http.get(Uri.parse(url));
    final tradingActivityModel = tradingActivityModelFromJson(response.body);
    print(tradingActivityModel[1].toJson().toString());
    return tradingActivityModel;
  }

  static Future<TradingActivityModel> currentTradingActivity() async {
    String url =
        'https://api.bottomstreet.com/api/data?page=trading_activity_current_month';
    print(url);
    var response = await http.get(Uri.parse(url));
    final tradingActivityModel = tradingActivityModelFromJson(response.body);

    return tradingActivityModel[0];
  }

  //individual api request for trading activity(filtered)
  static Future<Map<String, dynamic>> filteredTradingActivity(String s) async {
    print(s);
    var response = await http.get(Uri.parse(s));
    final filteredTradingAcitivityModel = tradingAcitiviyModelFilteredFromJson(
        json.decode(response.body)["table"]);
    return {
      "data": filteredTradingAcitivityModel,
      "total": json.decode(response.body)["total"]
    };
  }

  static Future<List<EventsModel>> events(String type) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=radar_events&filter_name=event_type&filter_value=$type';
    print(url);
    var response = await http.get(Uri.parse(url));
    final eventsModel = eventsModelFromJson(response.body);
    return eventsModel;
  }

  static Future<List<Datum>> dalalRoadList() async {
    String url = isBeforeFourPM()
        ? 'https://api.bottomstreet.com/radar/dalalroad_list'
        : 'https://api.bottomstreet.com/api/data?page=dalal_road';
    print(url);
    var response = await http.get(Uri.parse(url));
    // print(response.body);

    if (isBeforeFourPM()) {
      final dalalRoadModel = dalalRoadModelDatabaseFromJson(response.body);
      return dalalRoadModel;
    } else {
      final dalalRoadModel = dalalRoadModelFromJson(response.body);
      return dalalRoadModel[0].data;
    }

    // print(dalalRoadModel[0].data);
  }

  static Future<BrokerInitial> brokerInitial(String type) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=dalal_road_profile&filter_name=identifier&filter_value=$type';
    print(url);
    var response = await http.get(Uri.parse(url));
    final brokerInitial = brokerInitialFromJson(response.body);
    return brokerInitial;
  }

  static Future<List<BrokerRecomendation>> brokerRecomendation(
      String type) async {
    String url = isBeforeFourPM()
        ? 'https://api.bottomstreet.com/radar/dalalroad_latest_recommendations?broker_code=$type'
        : 'https://api.bottomstreet.com/api/data?page=dalal_road_latestrecommendation&filter_name=identifier&filter_value=$type';
    print(url);
    var response = await http.get(Uri.parse(url));
    final brokerRecomendation = brokerRecomendationFromJson(response.body);
    return brokerRecomendation;
  }
}
