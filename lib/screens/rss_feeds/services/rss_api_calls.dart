import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_ind/screens/rss_feeds/models/feed_model.dart';

class RSSApiCalls {
  // final String youtubeLink =
  //     'https://api.bottomstreet.com/socialMediaFeed?source=youtube';
  final String instagramLink =
      'https://api.bottomstreet.com/socialMediaFeed?source=instagram';
  // final String twitterLink =
  //     'https://api.bottomstreet.com/socialMediaFeed?source=twitter';

  Future<List<FeedModel>> getFeed() async {
    int instac = 0;
    int twc = 0;
    int ytc = 0;
    int randomchooser = 0;
    List<dynamic> instagramJsonList;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String feedData = prefs.getString('feedData');
    if (feedData != null) {
      instagramJsonList = json.decode(feedData);
    } else {
      var response = await http.get(Uri.parse(instagramLink));
      instagramJsonList = json.decode(response.body);
    }

    instagramJsonList.sort((b, a) => b['timestamp'].compareTo(a['timestamp']));
    final List instagramList = List.from(instagramJsonList.reversed);

    // var response = await http.get(Uri.parse(twitterLink));
    // List<dynamic> twitterJsonList = json.decode(response.body);
    // twitterJsonList.sort((b, a) => b['timestamp'].compareTo(a['timestamp']));
    // final twitterList = List.from(twitterJsonList.reversed);

    // response = await http.get(Uri.parse(youtubeLink));
    // List<dynamic> youtubeJsonList = json.decode(response.body);
    // youtubeJsonList.sort((b, a) => b['timestamp'].compareTo(a['timestamp']));
    // final youtubeList = List.from(youtubeJsonList.reversed);

    // var jsonList = [instagramList, youtubeList, twitterList];
    // var shuffledList = [];

    // final random = new Random();

    // for (int j = 0;
    //     j <=
    //         (instagramList.length + twitterList.length + youtubeList.length) -
    //             3;
    //     j++) {
    //   randomchooser = random.nextInt(jsonList.length);
    //   if (jsonList[randomchooser] == instagramList &&
    //       instac < instagramList.length) {
    //     shuffledList.add(jsonList[randomchooser][instac]);
    //     instac++;
    //   } else if (jsonList[randomchooser] == twitterList &&
    //       twc < twitterList.length) {
    //     shuffledList.add(jsonList[randomchooser][twc]);
    //     twc++;
    //   }
    //   if (jsonList[randomchooser] == youtubeList && ytc < youtubeList.length) {
    //     shuffledList.add(jsonList[randomchooser][ytc]);
    //     ytc++;
    //   }
    // }
    List<FeedModel> list = [];
    for (int i = 0; i < instagramList.length; i = i + 1) {
      list.add(FeedModel.fromJson(instagramList[i]));
    }
    return list;
  }

  updateCachedFeed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(instagramLink));
    prefs.setString('feedData', response.body);
    print('update feed called');
  }
}
