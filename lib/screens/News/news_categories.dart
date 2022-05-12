import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/screens/News/broadcastPage.dart';
import 'package:technical_ind/screens/News/containpage2.dart';
import 'package:technical_ind/screens/News/newsbites.dart';
import 'package:technical_ind/screens/landingPage.dart';
import 'package:technical_ind/screens/profile/homeProfile.dart';
import 'package:technical_ind/screens/radar/dalalRoad.dart';
import 'package:technical_ind/screens/radar/radarHome.dart';
import 'package:provider/provider.dart';

import '../../components/containPage.dart';
import '../../styles.dart';

import 'category_specific_news.dart';
import 'business/model.dart';
import 'business/newsServices.dart';
import 'searchResults.dart';
import 'NewsSearchPage.dart';
import 'SavedArticles.dart';

class NewsCategories extends StatefulWidget {
  NewsCategories({Key key}) : super(key: key);

  @override
  _NewsCategoriesState createState() => _NewsCategoriesState();
}

class NotificationDotOverlay extends StatelessWidget {
  final Widget icon;
  final int counter;
  final Function onPressed;

  const NotificationDotOverlay(
      {Key key, this.icon, this.counter = 0, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'News Categories');
    return IconButton(
      icon: new Stack(
        children: <Widget>[
          icon,
          new Positioned(
            right: 0,
            child: new Container(
              height: 10, width: 10,
              //padding: EdgeInsets.all(1),
              decoration: new BoxDecoration(
                  color: const Color(0xff04df54),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2)),

              child: counter > 0
                  ? Center(
                      child: new Text(
                        '$counter',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Container(),
            ),
          )
        ],
      ),
      onPressed: onPressed,
    );
  }
}

class _NewsCategoriesState extends State<NewsCategories> {
  List<String> _list = [
    'Markets',
    'Business',
    'Technology',
    'Politics',
    'Economy',
    'Cryptocurrency',
    'IPO'
  ];

  // List<Article> articles;
  // bool loading = true;
  // void getArticles(String title) async {
  //   articles = await NewsServices.getNewsFromQuery(title);
  //   if (mounted) {
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getArticles('IPO');
  // }
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainPage2(
        menu: _list,
        menuWidgets: [
          NewsDetailsPage(
            keyword: "Markets",
          ),
          NewsBites(topic: "Business"),
          NewsBites2(topic: "Technology"),
          NewsBites3(topic: "Politics"),
          NewsBites4(topic: "Economy"),
          NewsBites5(topic: "Cryptocurrency"),
          SearchResultsPage(
            title: "IPO",
            isIpo: true,
            isSearched: true,
          ),
        ],
        defaultWidget: "Politics",
      ),
    );
  }
}
