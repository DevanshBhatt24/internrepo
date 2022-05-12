import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:technical_ind/components/codeSearch.dart';
import 'package:technical_ind/styles.dart';

class Utils {
  static Color determineColorfromValue(String s) {
    s = s.replaceAll(',', '');
    double d = double.tryParse(s);
    if (d == null) return blue;
    if (d >= 0)
      return blue;
    else
      return red;
  }

  static Future<CodeSearch> getStockCodes(String idType, String id) async {
    String url =
        'https://api.bottomstreet.com/api/data?page=stocks_internal_details&filter_name=$idType&filter_value=$id';
    print(url);

    var response = await http.get(Uri.parse(url));
    final codeSearch = codeSearchFromJson(response.body);
    return codeSearch;
  }
}
