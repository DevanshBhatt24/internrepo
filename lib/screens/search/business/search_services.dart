import 'dart:convert';

import 'package:http/http.dart' as http;

import 'search_model.dart';

String hostUrl = 'https://api.bottomstreet.com/search?src=';

class SearchServices {
  static Future<List<SearchModel>> getSearchListFromQuery(String query) async {
    String baseUrl = hostUrl + query;
    var response = await http.get(Uri.parse(baseUrl));
    print(response.body);
    List<SearchModel> searchResults = searchModelFromJson(response.body);
    return searchResults;
  }
}
