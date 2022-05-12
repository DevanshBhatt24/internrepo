import 'package:technical_ind/screens/etf/business/eftlist_model.dart';
import 'package:technical_ind/screens/etf/business/models/etf_explore_model.dart';
import 'package:technical_ind/screens/mutual/business/mutualfunds.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FundsService {
  static Future<List<Fund>> funds(String code, String pageNumber) async {
    String url =
        'https://api.bottomstreet.com/mutualfundlist?category=$code&page=$pageNumber';
    // String changesUrl = 'https://api.bottomstreet.com/mutualfund/price?amc=icici-prudential-technology-fund-direct-plan';
    print(url);
    var response = await http.get(Uri.parse(url));
    print(json
        .decode(response.body)[0]["funds"][0]["name"]
        .toString()
        .toLowerCase()
        .replaceAll(" ", "-"));
    final mutualFundsModel = fundsModelFromJson(response.body);
    return mutualFundsModel;
  }

  static Future<MutualPriceDetails> fundPriceDetails(String code) async {
    String url = 'https://api.bottomstreet.com/mutualfund/price?amc=$code';
    var response = await http.get(Uri.parse(url));

    final fundPriceDetails = json.decode(response.body).length != 0
        ? mutualAndEtfPriceDetails(response.body)
        : null;
    return fundPriceDetails;
  }

  static Future<MutualFund> fundDetails(String code) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=mutual_fund_detail&filter_name=identifier&filter_value=$code';
    var response = await http.get(Uri.parse(url));

    final mutualfundDetails = mutualAndEtfDetails(response.body);
    return mutualfundDetails;
  }

  static Future<FundWatchModel> watchMutual(var code) async {
    try {
      String url = 'https://api.bottomstreet.com/mutualfund/price?amc=$code';
      var response = await http.get(Uri.parse(url));
      final fund = watchlistFundFromJson(response.body);
      return fund;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // static Future<FundWatchModel> watchEtf(var code) async {
  //   try {
  //     String url = 'https://api.bottomstreet.com/etf/price?amc=$code';
  //     var response = await http.get(Uri.parse(url));
  //     final fund = watchlistFundFromJson(response.body);
  //     print(fund);
  //     return fund;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
  static Future<EtfOverviewModel> watchEtf(var code) async {
    try {
      String url = 'https://api.bottomstreet.com/etf/overview?etf_name=$code';
      var response = await http.get(Uri.parse(url));
      final fund = etfOverviewListModelFromJson(response.body);
      print(fund);
      return fund;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
