import 'package:http/http.dart' as http;
import 'package:technical_ind/screens/commodity/business/commodity_overview_model.dart';
import 'package:technical_ind/screens/cryptocurrency/business/crypto_overview_model.dart'
    as historicalModel;
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'eftlist_model.dart';
import 'models/etf_explore_model.dart' as exploremodel;

String hostUrl =
    'https://api.bottomstreet.com/api/data?page=etfs_nse&filter_name=category&filter_value=';

String hostUrl2 =
    'https://api.bottomstreet.com/api/data?page=etfs_bse&filter_name=category&filter_value=';

class EtfServices {
  // static Future<List<EtfCategoryModel>> getEtfNse(String query) async {
  //   String baseUrl = hostUrl + query;
  //   print(baseUrl);

  //   var response = await http.get(Uri.parse(baseUrl));
  //   // print(response.body);
  //   List<EtfCategoryModel> etfresults = etfCategoryModelFromJson(response.body);
  //   return etfresults;
  // }

  // static Future<List<EtfCategoryModel>> getEtfBse(String query) async {
  //   String baseUrl = hostUrl2 + query;
  //   print(baseUrl);
  //   var response = await http.get(Uri.parse(baseUrl));
  //   // print(response.body);
  //   List<EtfCategoryModel> etfresults = etfCategoryModelFromJson(response.body);
  //   return etfresults;
  // }

  static Future<historicalModel.HistoricalData> getHistoricalDataDetails(
      String isin) async {
    try {
      String url =
          "https://api.bottomstreet.com/api/data?page=historical_data&filter_name=identifier&filter_value=$isin";
      var response = await http.get(Uri.parse(url));

      final stockhistoricalData =
          historicalModel.stockHistoricalDetailFromJson(response.body);

      return stockhistoricalData;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<CommodityOverviewModelTechnicalIndicator> getTechnicalDetail(
      String query) async {
    try {
      String url = "https://api.bottomstreet.com/etf/technical?etf_name=$query";
      var response = await http.get(Uri.parse(url));

      final stockhistoricalData = stockTechnicalFromJson(response.body);

      return stockhistoricalData;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<List<EtfListModel>> getEtfList(String query) async {
    String url =
        "https://api.bottomstreet.com/api/data?page=etfs_list&filter_name=category&filter_value=$query";

    var response = await http.get(Uri.parse(url));

    List<EtfListModel> etflist = etfListModelFromJson(response.body);
    return etflist;
  }

  static Future<EtfOverviewModel> getEtfOverview(String name) async {
    String baseUrl = 'https://api.bottomstreet.com/etf/overview?etf_name=$name';
    var response = await http.get(Uri.parse(baseUrl));
    print(baseUrl);
    // print(response.body);
    EtfOverviewModel etfresults = etfOverviewListModelFromJson(response.body);
    return etfresults;
  }
  // static Future<EtfSummaryModel> getEtfSummary(String name) async {
  //   String baseUrl =
  //       'https://api.bottomstreet.com/mutualfund?amc=$name&page=summary';
  //   var response = await http.get(Uri.parse(baseUrl));
  //   print(baseUrl);
  //   // print(response.body);
  //   EtfSummaryModel etfresults = etfSummaryModelFromJson(response.body);
  //   return etfresults;
  // }

  static Future<exploremodel.EtfExploreModel> getEtfExplore(String name) async {
    String baseUrl =
        'https://api.bottomstreet.com/mutualfund?amc=$name&page=all';
    print(baseUrl);
    var response = await http.get(Uri.parse(baseUrl));
    // print(response.body);
    exploremodel.EtfExploreModel etfresults =
        exploremodel.etfExploreModelFromJson(response.body);
    return etfresults;
  }

  static Future<exploremodel.MutualFund> etfDetails(String code) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=mutual_fund_detail&filter_name=identifier&filter_value=$code';
    var response = await http.get(Uri.parse(url));

    final mutualfundDetails = exploremodel.mutualAndEtfDetails(response.body);
    return mutualfundDetails;
  }
}
