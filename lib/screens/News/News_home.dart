import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/src/indicator/classic_indicator.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/src/smart_refresher.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/screens/News/SavedArticles.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/News/headlines.dart';
import 'package:technical_ind/screens/News/news_categories.dart';
import 'package:technical_ind/screens/News/news_feed.dart';
import 'package:technical_ind/screens/News/newsfeed.dart';
import 'package:technical_ind/screens/indices/business/indices_mcx_model.dart';
import 'package:technical_ind/styles.dart';

import '../../components/LoadingPage.dart';
import '../../components/noDataAvailable.dart';
import '../indices/business/indices_nse_model.dart';
import 'NewsSearchPage.dart';
import 'business/newsServices.dart';
import 'containpage2.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with WidgetsBindingObserver {
  List<String> _list = ["Bites", "Shots", "Drops"];

  bool loading = true;
  List<News> news;
  AppLifecycleState _notification;
  void initState() {
    getData();
    NewsServices().updateCachedNews();
    WidgetsBinding.instance.addObserver(this);
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
    WidgetsBinding.instance.addObserver(this);
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
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(

          // appBar: AppBarWithBack(text: "Indian Indices",height:40.h),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 16, top: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "News",
                        style: headingStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: NotificationDotOverlay(
                          onPressed: () {
                            pushNewScreen(context,
                                screen: SavedArticles(), withNavBar: false);
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/bookmark-line (1).svg",
                            color: almostWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  labelStyle: buttonWhite,
                  unselectedLabelColor: Colors.white38,
                  //indicatorSize: TabBarIndicatorSize.label,
                  indicator: MaterialIndicator(
                    horizontalPadding: 24,
                    bottomLeftRadius: 8,
                    bottomRightRadius: 8,
                    color: almostWhite,
                    paintingStyle: PaintingStyle.fill,
                  ),
                  tabs: [
                    Tab(
                      text: "List",
                    ),
                    Tab(
                      text: "Cards",
                      //child: NSEtab(),
                    ),
                    Tab(
                      text: "Updates",
                      //child: NSEtab(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(top: 8),
            child: TabBarView(children: [
              NewsCategories(),
              loading
                  ? LoadingPage()
                  : (news == null
                      ? NoDataAvailablePage()
                      : RefreshIndicator(
                          onRefresh: getData,
                          color: Colors.white,
                          child: NewsFeed(
                            news: new List.from(news.reversed),
                          ),
                        )),
              NewsPulse(),
            ]),
          )),
    );
  }
}
