import 'package:flutter/material.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/News/business/model.dart';

import '../News/broadcastPage.dart';

class NewsPage extends StatefulWidget {
  final List<Article> articles;
  NewsPage({this.articles});
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return widget.articles == null
        ? NoDataAvailablePage()
        : NewsWidget(
            articles: widget.articles,
          );
  }
}
