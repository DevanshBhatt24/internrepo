import 'dart:developer';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_ind/animated_search_bar.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/screens/landingPage.dart';
import 'package:technical_ind/screens/radar/optionChain.dart';
import 'package:technical_ind/screens/radar/stockScreener.dart';
import 'package:technical_ind/screens/search/business/model.dart';
import 'package:technical_ind/screens/stocks/allStocksPage.dart';
import '../../styles.dart';
import 'dalalRoad.dart';
import 'dealsPage.dart';
import 'eventsPage.dart';
import 'holidaysPage.dart';
import 'ipo.dart';
import 'mapMarker.dart';
import 'tradingActivity.dart';
import 'package:http/http.dart' as http;

class RadarHome extends StatefulWidget {
  RadarHome({Key key}) : super(key: key);

  @override
  _RadarHomeState createState() => _RadarHomeState();
}

class _RadarHomeState extends State<RadarHome> {
  List<Widget> widgets = [
    AllStocksPage(),
    TradingActivity(),
    EventsPage(),
    // SectorSense(),
    IPO2(),
    DealsPage(),
    StockScreener(),
    OptionChain(),
    HolidaysPage(),
    TradingHoursPage(),
  ];

  Future<List> checkForNewTabs() async {
    List a = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool openedOptionChain = prefs.getBool('openedOpenChain') ?? false;
    bool openedStockScreener = prefs.getBool('openedStockScreener') ?? false;
    a.add(openedOptionChain);
    a.add(openedStockScreener);
    return a;
  }

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

  // _loadJson() async {
  //   // try {
  //   //   jsonText = await http.get(Uri.parse(
  //   //       'https://api.bottomstreet.com/api/data?page=stocks_isin_list'));
  //   //   print("done");
  //   //   stocks = stockSearchFromJson(jsonText.body);
  //   // } catch (e) {
  //   //   print('this is the error ${e.toString()}');
  //   // }
  //   if (gstocks == null) {
  //     jsonText = (await http.get(Uri.parse(
  //             "https://api.bottomstreet.com/api/data?page=stocks_isin_list")))
  //         .body;
  //     // await rootBundle.loadString('assets/instrument/stocks_list.json');
  //     print("done");
  //     gstocks = stockSearchFromJson(jsonText);
  //     jsonText = await rootBundle.loadString('assets/instrument/indices.json');
  //     print("done");
  //     gindices = indicesSearchFromJson(jsonText);
  //     jsonText = await rootBundle.loadString('assets/instrument/fundsEtf.json');
  //     print("done");
  //     gfundsEtf = fundEtfSearchFromJson(jsonText);
  //     jsonText = await rootBundle
  //         .loadString('assets/instrument/investing_etf_list.json');
  //     print("done");
  //     getf = etfSearchFromJson(jsonText);
  //     jsonText = await rootBundle.loadString('assets/instrument/forex.json');
  //     print("done");
  //     gforex = forexSearchFromJson(jsonText);
  //     jsonText = await rootBundle.loadString('assets/instrument/crypto.json');
  //     print("done");
  //     gcrypto = cryptoSearchFromJson(jsonText);
  //   }

  //   // jsonText = await rootBundle.loadString('assets/instrument/commodity.json');
  //   // print("done");
  //   // commodity = commoditySearchFromJson(jsonText);
  //   setState(() {
  //     print('isLoading : $isLoading');
  //     isLoading = false;
  //     print('isLoading after: $isLoading');
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _loadJson();
    setState(() {
      log('rebuilding');
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Radar');
    return isLoading
        ? LoadingPage()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              // actions: [
              //   Container(
              //     margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              //     child: AnimatedSearchBar(
              //       stocks: gstocks,
              //       indices: gindices,
              //       fundsEtf: gfundsEtf,
              //       etf: getf,
              //       forex: gforex,
              //       crypto: gcrypto,
              //       commodity: gcommodity,
              //       color: Colors.black,
              //       onSubmit: (value) {
              //         print('submitted search : $value');
              //       },
              //       style: TextStyle(
              //         color: Colors.white,
              //       ),
              //       closeSearchOnSuffixTap: true,
              //       suffixIcon: Icon(
              //         Icons.close,
              //         color: Colors.white,
              //       ),
              //       // prefixIcon: Icon(
              //       //   Icons.search,
              //       //   color: Colors.white,
              //       // ),
              //       prefixIcon: Image.asset(
              //         'images/loupe.png',
              //         color: Colors.white,
              //         height: 24,
              //       ),
              //       rtl: true,
              //       width: MediaQuery.of(context).size.width * 0.94,
              //       textController: textController,
              //       onSuffixTap: () {
              //         setState(() {
              //           textController.clear();
              //         });
              //       },
              //     ),
              //   )
              // ],
              title: Text('Radar', style: headingStyle),
            ),
            body: FutureBuilder(
                future: checkForNewTabs(),
                builder: (BuildContext context, AsyncSnapshot snapShot) {
                  if (snapShot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _customListTile("All Stocks", widgets[0], false),

                            _customListTile("Deals", widgets[4], false),
                            _customListTile("Events", widgets[2], false),
                            _customListTile(
                                "Global Trading Hours", widgets[8], false),
                            _customListTile("IPO", widgets[3], false),
                            _customListTile(
                                "Market Holidays", widgets[7], false),
                            _customListTile(
                                'Option Chain', widgets[6], !snapShot.data[0]),
                            _customListTile('Stock Screener', widgets[5],
                                !snapShot.data[1]),
                            _customListTile(
                                "Trading Activity", widgets[1], false),
                            // _customListTile("Sector Sense", widgets[3]),
                          ],
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }),
          );
  }

  Widget _customListTile(String title, Widget onTap, bool isNew) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      title: Row(
        children: [
          new Text(title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: almostWhite)),
          // if(isNew == true)Container(
          //   margin: EdgeInsets.only(left: 20),
          //   padding: EdgeInsets.symmetric(horizontal: 5 , vertical: 2),
          //   child: Text(
          //       'New',
          //     style: TextStyle(
          //       fontSize: 12,
          //       color: Colors.blueAccent
          //     ),
          //   ),
          // ),
        ],
      ),
      trailing: Icon(
        CupertinoIcons.forward,
        color: white60,
      ),
      onTap: () {
        pushNewScreen(context, screen: onTap, withNavBar: false);
      },
    );
  }
}
