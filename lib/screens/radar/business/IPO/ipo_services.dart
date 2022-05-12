import 'dart:convert';

import 'package:http/http.dart' as http;
import 'ipo_model.dart';
import 'ipo_indi_model.dart';

String hostUrl = 'https://api.bottomstreet.com/api/data?page=radar_ipo_list';
String hostUrl2 =
    'https://api.bottomstreet.com/api/data?page=radar_ipo_individual&filter_name=identifier&filter_value=';

class IpoServices {
  static Future<List<IpoModel>> getIpoList() async {
    var response = await http.get(Uri.parse(hostUrl));
    // print(response.body);
    List<IpoModel> ipoResults = ipoModelFromJson(response.body);
    return ipoResults;
  }

  static Future<IpoIndividualModel> getIpoIndiResults(String query) async {
    var response = await http.get(Uri.parse(hostUrl2 + query));
    print(hostUrl2 + query);
    IpoIndividualModel ipoindiresults =
        ipoIndividualModelFromJson(response.body);
    return ipoindiresults;
  }
}

class IpoServices2 {
  static Future<List<Ipo2>> getListedIpo() async {
    Uri url = Uri.parse(
        'https://api.stockedge.com/Api/IPODashboardApi/GetListedIPOs');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      List<Ipo2> ipoResults = decode
          .map((ipo2) {
            return Ipo2.fromJson(ipo2);
          })
          .toList()
          .cast<Ipo2>();
      return ipoResults;
    } else {
      return null;
    }
  }

  static Future<List<Ipo2>> getOngoing() async {
    Uri url = Uri.parse(
        'https://api.stockedge.com/Api/IPODashboardApi/GetOngoingIPOs');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      List<Ipo2> ipoResults = decode
          .map((ipo2) {
            return Ipo2.fromJson(ipo2);
          })
          .toList()
          .cast<Ipo2>();
      return ipoResults;
    } else {
      return null;
    }
  }

  static Future<Map<String,dynamic>> getIPODetails(int id) async {
    Uri url = Uri.parse(
        'https://api.stockedge.com/Api/IPODashboardApi/GetIpoDetails/$id');
    var response = await http.get(url);
    print(response.body);
    print(response.statusCode);
    // if (response.statusCode == 200) {
    Map<String,dynamic> decode = jsonDecode(response.body);
    print(decode["CloseDate"]);
    // Ipo2 ipoResult = new Ipo2.fromJson(decode);

    return decode;
    // } else {
    //   return null;
    // }
  }
  static Future<Map<String,dynamic>> getIPOSubscription(int id) async {
    Uri url = Uri.parse(
        'https://api.stockedge.com/Api/IPODashboardApi/GetSubscription/$id');
    var response = await http.get(url);
    print(response.body);
    print(response.statusCode);
    // if (response.statusCode == 200) {
    Map<String,dynamic> decode = jsonDecode(response.body);
    
    // Ipo2 ipoResult = new Ipo2.fromJson(decode);

    return decode;
    // } else {
    //   return null;
    // }
  }

  static Future<Map<String,dynamic>> getIPOPromoters(int id) async {
    Uri url = Uri.parse(
        'https://api.stockedge.com/Api/IPODashboardApi/GetPromoters/$id');
    var response = await http.get(url);
    print(response.body);
    print(response.statusCode);
    // if (response.statusCode == 200) {
    Map<String,dynamic> decode = jsonDecode(response.body);
    
    // Ipo2 ipoResult = new Ipo2.fromJson(decode);

    return decode;
    // } else {
    //   return null;
    // }
  }

  static Future<List<UpcomingIpo2>> getUpcoming() async {
    Uri url = Uri.parse(
        'https://api.stockedge.com/Api/IPODashboardApi/GetUpcomingIPOs');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      List<UpcomingIpo2> ipoResults = decode
          .map((ipo2) {
            return UpcomingIpo2.fromJson(ipo2);
          })
          .toList()
          .cast<UpcomingIpo2>();
      return ipoResults;
    } else {
      return null;
    }
  }
}
