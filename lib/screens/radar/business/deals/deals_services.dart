import 'package:http/http.dart' as http;
import 'deals_model.dart';

String hostUrl =
    'https://api.bottomstreet.com/api/data?page=radar_deals&filter_name=identifier&filter_value=';

class DealsServices {
  static Future<Dealsmodel> getSectorSenseList(String type) async {
    String baseUrl = hostUrl + type;
    print(baseUrl);
    var response = await http.get(Uri.parse(baseUrl));
    // print(response.body);
    Dealsmodel dealsResults = dealsmodelFromJson(response.body);
    return dealsResults;
  }
}
