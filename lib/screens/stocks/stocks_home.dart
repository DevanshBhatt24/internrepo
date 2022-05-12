// ignore_for_file: dead_code

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/screens/search/searchPage.dart';
import 'package:technical_ind/screens/stocks/52WeekHighPage.dart';
import 'package:technical_ind/screens/stocks/52WeekLowPage.dart';
import 'package:technical_ind/screens/stocks/LosersPage.dart';
import 'package:technical_ind/screens/stocks/TrendingPage.dart';
import 'package:technical_ind/screens/stocks/gainersPage.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import '../search/business/model.dart';
import 'ActivePage.dart';

class StockWatchList extends StatefulWidget {
  StockWatchList({
    Key key,
  }) : super(key: key);

  @override
  _StockWatchListState createState() => _StockWatchListState();
}

class _StockWatchListState extends State<StockWatchList> {
  List<Widget> widgets = [
    TrendingPage(),
    ActivePage(),
    GainersPage(),
    LosersPage(),
    Week52HighPage(),
    Week52LowPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWithBack(
          text: "Stocks",
        ),
        body: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            _customListTile("Trending", widgets[0]),
            _customListTile("Most Active", widgets[1]),
            _customListTile("Top Gainers", widgets[2]),
            _customListTile("Top Losers", widgets[3]),
            _customListTile("52 Week High", widgets[4]),
            _customListTile("52 Week Low", widgets[5]),
          ],
        ));
  }

  Widget _customListTile(String title, Widget onTap) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      minVerticalPadding: 14,
      title: new Text(title, style: subtitle1White),
      trailing: Icon(
        CupertinoIcons.forward,
        color: almostWhite,
      ),
      onTap: () {
        pushNewScreen(context, screen: onTap, withNavBar: true);
      },
    );
  }
}

class StockHome extends StatefulWidget {
  final String defaultWidget;
  final double defaultHeight;
  final bool isList;

  StockHome({
    Key key,
    this.isList = false,
    this.defaultWidget,
    this.defaultHeight = 80,
  }) : super(key: key);

  @override
  _StockHomeState createState() => _StockHomeState();
}

class _StockHomeState extends State<StockHome> {
  int _selected;
  PanelController _panelController = new PanelController();
  List<String> menu = [
    "Trending",
    "Most Active",
    "Top Gainers",
    "Top Losers",
    "52 Week High",
    "52 Week Low",
  ];

  var jsonText;
  List<StockSearch> stocks;
  List<IndicesSearch> indices;
  List<FundEtfSearch> fundsEtf;
  List<EtfSearch> etf;
  List<ForexSearch> forex;
  List<CryptoSearch> crypto;
  List<CommoditySearch> commodity;
  bool isLoading = false;
  TextEditingController textController = TextEditingController();
  List<SearchIdentifier> searchIdentifier = [];

  @override
  void initState() {
    _selected = menu.indexOf(widget.defaultWidget);
    // _loadJson();
    super.initState();
  }

  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Stocks');
    List<Widget> widgetList = [
      TrendingPage(),
      ActivePage(),
      GainersPage(),
      LosersPage(),
      Week52HighPage(),
      Week52LowPage()
    ];

    return Material(
      child: isLoading
          ? LoadingPage()
          : SlidingUpPanel(
              controller: _panelController,
              color: const Color(0xff1c1c1e),
              defaultPanelState: PanelState.CLOSED,
              backdropEnabled: true,
              minHeight: 0,
              maxHeight: widget.defaultHeight + menu.length * 48,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18), topRight: Radius.circular(18)),
              panel: Column(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 8, bottom: 24),
                      width: 38,
                      height: 4,
                      decoration: BoxDecoration(
                          color: white60,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  ...List.generate(
                      menu.length,
                      (index) => InkWell(
                            onTap: () {
                              _panelController.close().whenComplete(() {
                                if (widgetList[index] != null)
                                  setState(() {
                                    _selected = index;
                                  });
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              child: Row(
                                children: [
                                  Container(
                                      width: 24,
                                      child: Icon(
                                        Icons.check,
                                        color: _selected == index
                                            ? almostWhite
                                            : Colors.transparent,
                                      )),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    menu[index],
                                    style: subtitle1.copyWith(
                                      color: _selected == index
                                          ? almostWhite
                                          : white38,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                ],
              ),
              body: Scaffold(
                floatingActionButton: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 50),
                  child: FloatingActionButton(
                    backgroundColor: blue,
                    splashColor: grey,
                    onPressed: () {
                      pushNewScreen(context,
                          screen: SearchPage(),
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino);
                    },
                    child: Image.asset(
                      'images/loupe.png',
                      color: Colors.white,
                      scale: 24,
                    ),
                  ),
                ),
                appBar: PreferredSize(
                  preferredSize: Size(0, 112),
                  child: Column(
                    children: [
                      !widget.isList
                          ? AppBar(
                              title: Row(
                                children: [
                                  Text("Stocks"),
                                ],
                              ),
                              backgroundColor: Colors.black,
                              elevation: 0,
                              leading: IconButton(
                                icon: Icon(CupertinoIcons.back),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            )
                          : Container(),
                      InkWell(
                        onTap: () {
                          _panelController.open();
                        },
                        child: Hero(
                          tag: "explore",
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 6),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              //height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xff1c1c1e),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(menu[_selected], style: buttonWhite),
                                  Icon(
                                    Icons.expand_more,
                                    color: almostWhite,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: widgetList[_selected],
              ),
            ),
    );
  }
}
