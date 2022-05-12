import 'package:http/http.dart' as http;
import 'package:technical_ind/screens/commodity/business/commodity_overview_model.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'indices_mcx_model.dart';
import 'indices_nse_model.dart';
import 'indices_global_model.dart';
import 'indices_forex_model.dart';
import 'indian_overview_model.dart' as indianOverview;
import 'global_overview_model.dart' as globalOverview;
import 'dart:convert';

class IndicesServices {
  static Future getSearchGlobal(String code) async {
    String url =
        'https://api.bottomstreet.com/globalindices/prices?indices_name=$code';
    print(url);
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  static Future getSearchIndian(String code) async {
    String url =
        'https://api.bottomstreet.com/indianindices/prices?indices_name=$code';
    print(url);
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  static Future<List<IndicesNseModel>> getBseList() async {
    String hostUrl = 'https://api.bottomstreet.com/api/data?page=indices_bse';
    print(hostUrl);
    var response = await http.get(Uri.parse(hostUrl));
    // print(response.body);
    List<IndicesNseModel> results = indicesNseModelFromJson(response.body);
    return results;
  }

  static Future<List<IndicesNseModel>> getNseList() async {
    String hostUrl = 'https://api.bottomstreet.com/api/data?page=indices_nse';
    var response = await http.get(Uri.parse(hostUrl));
    // print(response.body);
    List<IndicesNseModel> results = indicesNseModelFromJson(response.body);
    return results;
  }

  static Future<List<IndicesMcxModel>> getMcxList() async {
    String hostUrl = 'https://api.bottomstreet.com/api/data?page=indices_mcxs';
    var response = await http.get(Uri.parse(hostUrl));
    // print(response.body);
    List<IndicesMcxModel> results = indicesMcxModelFromJson(response.body);
    return results;
  }

  static Future<IndicesGlobalModel> getGlobalList() async {
    String hostUrl = 'https://api.bottomstreet.com/api/data?page=globalindices';
    print(hostUrl);
    var response = await http.get(Uri.parse(hostUrl));
    // print(response.body);
    List<IndicesGlobalModel> results =
        indicesGlobalModelFromJson(response.body);
    return results[0];
  }

  static Future<IndicesForexModel> getForexList() async {
    String hostUrl =
        'https://api.bottomstreet.com/api/data?page=indices_forex_list';
    print(hostUrl);
    var response = await http.get(Uri.parse(hostUrl));
    // print(response.body);
    List<IndicesForexModel> results = indicesForexModelFromJson(response.body);
    return results[0];
  }

  static Future<HistoricalData> getIndianIndicesHistoricalData(
      String query) async {
    String historicalDataUrl =
        'https://api.bottomstreet.com/api/data?page=historical_data&filter_name=identifier&filter_value=$query';
    var response = await http.get(Uri.parse(historicalDataUrl));
    var jsonBody = json.decode(response.body);
    HistoricalData historicalData =
        HistoricalData.fromJson(jsonBody['historical_data']);
    return historicalData;
  }

  static Future<List<indianOverview.Component>> getIndianIndicesComponents(
      String query) async {
    String url =
        'https://api.bottomstreet.com/indianindices/components?indices_name=$query';
    var response = await http.get(Uri.parse(url));
    var jsonBody = json.decode(response.body);

    List<indianOverview.Component> components =
        List<indianOverview.Component>.from(
            jsonBody.map((x) => indianOverview.Component.fromJson(x)));

    return components;
  }

  static Future<CommodityOverviewModelTechnicalIndicator>
      getIndianIndicesTechnicalIndicator(String query) async {
    String url =
        'https://api.bottomstreet.com/indianindices/technical?indices_name=$query';
    var response = await http.get(Uri.parse(url));
    var jsonBody = json.decode(response.body);
    CommodityOverviewModelTechnicalIndicator technicalIndicator =
        CommodityOverviewModelTechnicalIndicator.fromJson(jsonBody);
    return technicalIndicator;
  }

  static Future<indianOverview.Overview> getIndianIndicesOverview(
      String query) async {
    String url =
        'https://api.bottomstreet.com/indianindices/overview?indices_name=$query';
    print(url);
    var response = await http.get(Uri.parse(url));
    var jsonBody = json.decode(response.body);
    indianOverview.Overview overview =
        indianOverview.Overview.fromJson(jsonBody);
    return overview;
  }

  static Future<indianOverview.StockEffects> getIndianIndicesStockEffect(
      String query) async {
    String url =
        'https://api.bottomstreet.com/indianindices/stockeffect?indices_name=$query';
    var response = await http.get(Uri.parse(url));
    var jsonBody = json.decode(response.body);
    indianOverview.StockEffects stockEffects =
        indianOverview.StockEffects.fromJson(jsonBody);
    return stockEffects;
  }

  static Future<FutureAndOptions> getFandO(String query) async {
    String hostUrl =
        'https://api.bottomstreet.com/api/data?page=futures_and_options_data&filter_name=identifier&filter_value=$query';
    try {
      var response = await http.get(Uri.parse(hostUrl));
      var jsonBody = json.decode(response.body);
      var result =
          FutureAndOptions.fromJson(jsonBody["futures_and_options_data"]);
      return result;
    } catch (e) {
      return null;
    }
  }

  static Future<globalOverview.GobalOverview> getGlobalOverview(
      String name) async {
    // print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' + name);
    String hostOverviewUrl =
        'https://api.bottomstreet.com/globalindices/overview?indices_name=$name';

    String technicalIndicatorUrl =
        'https://api.bottomstreet.com/globalindices/technical?indices_name=$name';
    String historicalDataUrl =
        "https://api.bottomstreet.com/api/data?page=historical_data&filter_name=identifier&filter_value=$name";
    String componentsUrl =
        'https://api.bottomstreet.com/api/data?page=global_indices_detail&filter_name=identifier&filter_value=$name';

    var response = await http.get(Uri.parse(hostOverviewUrl));
    var jsonBody = json.decode(response.body);
    globalOverview.Overview overview =
        globalOverview.Overview.fromJson(jsonBody);

    response = await http.get(Uri.parse(technicalIndicatorUrl));
    jsonBody = json.decode(response.body);

    CommodityOverviewModelTechnicalIndicator technicalIndicator =
        CommodityOverviewModelTechnicalIndicator.fromJson(jsonBody);

    response = await http.get(Uri.parse(componentsUrl));
    jsonBody = json.decode(response.body);

    globalOverview.Component components =
        globalOverview.Component.fromJson(jsonBody["components"][0]);

    response = await http.get(Uri.parse(historicalDataUrl));
    jsonBody = json.decode(response.body);
    HistoricalData historicalData =
        HistoricalData.fromJson(jsonBody["historical_data"]);

    globalOverview.GobalOverview results = globalOverview.GobalOverview(
        components: components,
        historicalData: historicalData,
        overview: overview,
        technicalIndicator: technicalIndicator);
    return results;
  }

  static Future<globalOverview.Overview> getGolbalIndicesOverview(
      String name) async {
    String hostOverviewUrl =
        'https://api.bottomstreet.com/globalindices/overview?indices_name=$name';
    var response = await http.get(Uri.parse(hostOverviewUrl));
    var jsonBody = json.decode(response.body);
    globalOverview.Overview overview =
        globalOverview.Overview.fromJson(jsonBody);
    return overview;
  }

  static Future<CommodityOverviewModelTechnicalIndicator>
      getGolbalIndicesTechnicalIndicator(String name) async {
    String technicalIndicatorUrl =
        'https://api.bottomstreet.com/globalindices/technical?indices_name=$name';
    var response = await http.get(Uri.parse(technicalIndicatorUrl));
    var jsonBody = json.decode(response.body);

    CommodityOverviewModelTechnicalIndicator technicalIndicator =
        CommodityOverviewModelTechnicalIndicator.fromJson(jsonBody);
    return technicalIndicator;
  }

  static Future<globalOverview.Component> getGolbalIndicesComponents(
      String name) async {
    // print('??????????????????????????????????' + name);
    // https://api.bottomstreet.com/globalindices/components?indices_name=Nasdaq
    String componentsUrl =
        'https://api.bottomstreet.com/globalindices/components?indices_name=$name';
    var response = await http.get(Uri.parse(componentsUrl));
    var jsonBody = json.decode(response.body);
    // print(jsonBody);
    List<globalOverview.Datum> data = List<globalOverview.Datum>.from(
        jsonBody.map((x) => globalOverview.Datum.fromJson(x)));
    globalOverview.Component components = globalOverview.Component(data: data);
    return components;
  }

  static Future<HistoricalData> getGolbalIndicesHistoricalData(
      String name) async {
    String historicalDataUrl =
        "https://api.bottomstreet.com/api/data?page=historical_data&filter_name=identifier&filter_value=$name";
    var response = await http.get(Uri.parse(historicalDataUrl));
    var jsonBody = json.decode(response.body);
    HistoricalData historicalData =
        HistoricalData.fromJson(jsonBody["historical_data"]);
    return historicalData;
  }

  static Future<GlobalIndiceWatchModel> watchGlobal(var code) async {
    try {
      String url =
          'https://api.bottomstreet.com/globalindices/prices?indices_name=$code';
      var response = await http.get(Uri.parse(url));
      final indice = watchlistGlobalIndiceFromJson(response.body);
      return indice;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<GlobalIndiceWatchModel> watchIndian(var code) async {
    try {
      String url =
          'https://api.bottomstreet.com/indianindices/prices?indices_name=$code';
      var response = await http.get(Uri.parse(url));
      final indice = watchlistGlobalIndiceFromJson(response.body);
      return indice;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
