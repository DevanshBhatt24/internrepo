import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:technical_ind/main.dart';
import 'package:technical_ind/screens/News/business/newsNotifications.dart';
import 'package:workmanager/workmanager.dart';

import '../../widgets/appbar_with_back_and_search.dart';
import 'broadcastPage.dart';
import 'business/dynamicLinkHandle.dart';
import 'business/model.dart';
import 'business/newsServices.dart';

class NewsDetailsPage extends StatefulWidget {
  final String keyword;

  NewsDetailsPage({Key key, this.keyword}) : super(key: key);

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  List<Article> articles = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: articles.isEmpty
            ? Center(
                heightFactor: 16,
                child: CircularProgressIndicator(color: Colors.white),
              )
            : NewsWidget(
                articles: articles,
                refresh: getArticles,
              ));
  }

  Future getArticles() async {
    articles = await NewsServices.getNewsFromTopic(widget.keyword.toUpperCase())
        .whenComplete(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getArticles();
  }
}
