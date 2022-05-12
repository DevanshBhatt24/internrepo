import 'package:flutter/material.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/News/news_feed.dart';

import 'business/model.dart';
import 'business/newsServices.dart';

class NewsData extends StatefulWidget {
  const NewsData({Key key}) : super(key: key);

  @override
  State<NewsData> createState() => _NewsDataState();
}

class _NewsDataState extends State<NewsData> {
  bool loading = true;
  List<News> news;
  AppLifecycleState _notification;
  void initState() {
    getData();
    NewsServices().updateCachedNews();

    super.initState();
  }

  Future<void> getData() async {
    var n = await NewsServices.getNewsFeed();
    if (mounted) {
      setState(() {
        news = n;
        loading = false;
      });
    }
    // _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        NewsServices().updateCachedNews();
        List<News> temp = await NewsServices.getNewsFeed();
        setState(() {
          news = temp;
        });

        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        NewsServices().updateCachedNews();
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        NewsServices().updateCachedNews();
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(child: LoadingPage())
          : (news == null
              ? NoDataAvailablePage()
              : RefreshIndicator(
                  onRefresh: getData,
                  color: Colors.white,
                  child: NewsFeed(
                    news: new List.from(news.reversed),
                  ),
                )),
    );
  }
}
