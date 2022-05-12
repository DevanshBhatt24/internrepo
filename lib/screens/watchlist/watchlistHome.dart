import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/screens/stocks/stocks_home.dart';
import '../../components/slidePanel.dart';
import '../../providers/navBarProvider.dart';
import '../../styles.dart';
import 'crypto.dart';
import 'etf.dart';
import 'forex.dart';
import 'indices.dart';
import 'mf.dart';
import 'stocks.dart';

class WatchListHome extends StatefulWidget {
  WatchListHome({Key key}) : super(key: key);

  @override
  _WatchListHomeState createState() => _WatchListHomeState();
}

class _WatchListHomeState extends State<WatchListHome> {
  static List<String> menu = [
    "Stocks",
    "Indices",
    "Mutual Funds",
    "ETF",
    "Forex",
    "Cryptocurrency",
    // "Commodity",
    // "Bonds",
  ];

  int _selected;
  PanelController _panelController = new PanelController();
  List<Widget> menuWidgets = [
    StocksW(title: menu[0]),
    IndicesW(title: menu[1], isIndian: true),
    // IndicesW(
    //   title: menu[2],
    //   isIndian: false,
    // ),
    MfW(title: menu[2]),
    EtfW(title: menu[3]),
    ForexW(title: menu[4]),
    CryptoW(title: menu[5]),
    // CommodityW(title: menu[7]),
    // BondsW(title: menu[7])
  ];
  @override
  void dispose() {
    print("ex");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'WatchList');
    return Material(
      child: SlidePanel(
        defaultHeight: 80,
        menu: menu,
        defaultWidget: menu[_selected],
        panelController: _panelController,
        onChange: (val) {
          setState(() {
            _selected = val;
          });
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(114),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    "Watchlist",
                    style: headingStyle,
                  ),
                  // titleTextStyle: headline5White,
                ),
                InkWell(
                  onTap: () {
                    context.read(navBarVisibleProvider).setNavbarVisible(true);
                    _panelController.open();
                  },
                  child: Hero(
                    tag: "explore",
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                        //height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xff1c1c1e),
                          // color: Colors.green
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(menu[_selected], style: subtitle2White),
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
                SizedBox(height: 8)
              ],
            ),
          ),
          body: menuWidgets[_selected],
        ),
      ),
    );
  }

  @override
  void initState() {
    _selected = menu.indexOf("Stocks");
    super.initState();
  }
}
