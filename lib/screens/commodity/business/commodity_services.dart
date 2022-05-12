import 'package:http/http.dart' as http;
import 'commodity_model.dart';
import 'commodity_overview_model.dart';

String hostUrl =
    'https://api.bottomstreet.com/api/data?page=commodities_list&filter_name=identifier&filter_value=unique';
String baseUrl =
    'https://api.bottomstreet.com/api/data?page=commodity_details&filter_name=identifier&filter_value=';

class CommodityServices {
  static Future<CommodityModel> getCommodityList() async {
    print(hostUrl);
    var response = await http.get(Uri.parse(hostUrl));

    CommodityModel results = commodityModelFromJson(response.body);
    return results;
  }

  static Future<CommodityOverviewModel> getCommodityOverviewList(
      String commodityname) async {
    var response = await http.get(Uri.parse(baseUrl + commodityname));
    // print(response.body);
    CommodityOverviewModel results =
        commodityOverviewModelFromJson(response.body);
    return results;
  }
}
