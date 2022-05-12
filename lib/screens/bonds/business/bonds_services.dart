import 'package:http/http.dart' as http;
import 'bonds_model.dart';

String hostUrl = 'https://api.bottomstreet.com/api/data?page=bonds';

class BondsServices {
  static Future<List<BondsModel>> getSectorSenseList() async {
    var response = await http.get(Uri.parse(hostUrl));
    print(response.body);
    List<BondsModel> bondsResults = bondsModelFromJson(response.body);
    return bondsResults;
  }
}
