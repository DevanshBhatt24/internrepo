import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';

String hostUrl = 'https://api.bottomstreet.com/';

class NewsServices {
  static Future<FullArticle> getFullArticle(String url) async {
    String baseUrl = hostUrl + 'api/article?url=' + url;
    // print(baseUrl);
    var response = await http.get(Uri.parse(baseUrl));
    // print(response.body);
    var convertDataToJson = json.decode(response.body);
    FullArticle fullArticle = FullArticle.fromJson(convertDataToJson);
    return fullArticle;
  }

  static Future<String> getImageUrl(String url) async {
    String baseUrl = hostUrl + 'api/image?url=';

    var response = await http.get(Uri.parse(baseUrl + url));
    // print(response.body);
    var convertDataToJson = json.decode(response.body);
    String imageUrl = convertDataToJson['image_url'].toString();
    return imageUrl;
  }

  static Future<List<Article>> getNewsFromQuery(String query) async {
    String baseUrl = hostUrl + 'api/search?q=';

    var response = await http.get(Uri.parse(baseUrl + query));
    // print(baseUrl + query);
    var convertDataToJson = json.decode(response.body);
    List<Article> articles = List<Article>.from(
        convertDataToJson.map((model) => Article.fromJson(model)));
    return articles;
  }

  static Future<List<Article>> getNewsFromTopic(String topic) async {
    String baseUrl = hostUrl + 'api/by_topic?topic=';
    // print(Uri.parse(baseUrl + topic).toString());
    // print(baseUrl + topic);

    var response = await http.get(Uri.parse(baseUrl + topic));
    // print(response.body);
    var convertDataToJson = json.decode(response.body);
    List<Article> articles = List<Article>.from(
        convertDataToJson.map((model) => Article.fromJson(model)));
    return articles;
  }

  static Future<String> getoutlineApi(String topic) async {
    String url = "https://api.outline.com/v3/parse_article?source_url=";
    var response = await http.get(Uri.parse(url + topic));
    try {
      var arr = json.decode(response.body);
      return arr["data"]["html"];
    } catch (e) {
      return e.message;
    }
  }

  static Future<Article> getLatestArticle(keyword) async {
    return (await NewsServices.getNewsFromTopic(keyword.toUpperCase()))[0];
  }

  static Future<List<News>> getNewsFeed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var convertDataToJson;
    String newsData = prefs.getString('newsData');
    if (newsData != null) {
      convertDataToJson = json.decode(newsData);
    } else {
      var response = await http.get(
          Uri.parse('https://api.bottomstreet.com/api/data?page=short_newsV2'));
      convertDataToJson = json.decode(response.body);
    }
    List<News> articles = List<News>.from(
        convertDataToJson.map((model) => News.fromJson(model['data'])));
    return articles;
  }

  updateCachedNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonText = (await http.get(Uri.parse(
            'https://api.bottomstreet.com/api/data?page=short_newsV2')))
        .body;
    prefs.setString('newsData', jsonText);
  }

  Future<List> getNewsPulseData() async {
    List<NewsPulseModel> pulseData = [];
    var response = await http.get(Uri.parse(
        'https://api.stockedge.com/Api/DailyDashboardApi/GetLatestNewsItems'));
    List data = json.decode(response.body);
    pulseData =
        data.map((jsonData) => NewsPulseModel.fromJson(jsonData)).toList();
    return pulseData;
  }
}
