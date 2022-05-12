import 'package:http/http.dart' as http;

import 'sectorSenseModel.dart';
import 'sectorSenseCodeModel.dart';

String hostUrl = 'https://api.bottomstreet.com/api/data?page=sector_sense_list';
String codeUrl =
    'https://api.bottomstreet.com/api/data?page=sector_sense_individual&filter_name=com_id&filter_value=';

class SectorSenseServices {
  static Future<List<SectorSenseModel>> getSectorSenseList() async {
    var response = await http.get(Uri.parse(hostUrl));
    // print(response.body);
    List<SectorSenseModel> sectorSenceResults =
        sectorSenseModelFromJson(response.body);
    return sectorSenceResults;
  }

  static Future<List<SectorSenseCodeModel>> getSectorSenseIndividual(
      String code) async {
    String baseUrl = codeUrl + code;
    var response = await http.get(Uri.parse(baseUrl));
    print(response.body);
    List<SectorSenseCodeModel> sectorSenceIndividualResults =
        sectorSenseCodeModelFromJson(response.body);
    return sectorSenceIndividualResults;
  }
}
