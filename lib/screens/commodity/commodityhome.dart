// import 'dart:async';
// import 'dart:ui';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/screens/landingPage.dart';
import 'package:technical_ind/screens/search/business/model.dart';
import '../../animated_search_bar.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import '../../widgets/card.dart';
import '../../widgets/item.dart';
import 'business/commodity_model.dart';
import 'business/commodity_services.dart';
import 'package:http/http.dart' as http;
// import './commodity_explore.dart';

class CommodityHome extends StatefulWidget {
  @override
  _CommodityHomeState createState() => _CommodityHomeState();
}

class _CommodityHomeState extends State<CommodityHome> {
  CommodityModel arr;
  bool loading = true;

  var jsonText;
  List<StockSearch> stocks;
  List<IndicesSearch> indices;
  List<FundEtfSearch> fundsEtf;
  List<EtfSearch> etf;
  List<ForexSearch> forex;
  List<CryptoSearch> crypto;
  List<CommoditySearch> commodity;
  TextEditingController textController = TextEditingController();

  _fetchApiDataAndSearchData() async {
    arr = await CommodityServices.getCommodityList().whenComplete(() {
      _refreshController.refreshCompleted();
    });
    // if (gstocks == null) {
    //   jsonText = (await http.get(Uri.parse(
    //           "https://api.bottomstreet.com/api/data?page=stocks_isin_list")))
    //       .body;
    //   // await rootBundle.loadString('assets/instrument/stocks_list.json');
    //   print("done");
    //   gstocks = stockSearchFromJson(jsonText);
    //   jsonText = await rootBundle.loadString('assets/instrument/indices.json');
    //   print("done");
    //   gindices = indicesSearchFromJson(jsonText);
    //   jsonText = await rootBundle.loadString('assets/instrument/fundsEtf.json');
    //   print("done");
    //   gfundsEtf = fundEtfSearchFromJson(jsonText);
    //   jsonText = await rootBundle
    //       .loadString('assets/instrument/investing_etf_list.json');
    //   print("done");
    //   getf = etfSearchFromJson(jsonText);
    //   jsonText = await rootBundle.loadString('assets/instrument/forex.json');
    //   print("done");
    //   gforex = forexSearchFromJson(jsonText);
    //   jsonText = await rootBundle.loadString('assets/instrument/crypto.json');
    //   print("done");
    //   gcrypto = cryptoSearchFromJson(jsonText);
    // }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchApiDataAndSearchData();
    
    // Timer.periodic(Duration(milliseconds: autoRefreshDuration), (t) {
    //   if (mounted)
    //     _fetchApiData();
    //   else {
    //     print("Timer Ticking is stopping.");
    //     t.cancel();
    //   }
    // });
  }

  final List<String> menu = [
    'Overview',
    'Charts',
    'Technical Indicators',
    'Historical Data',
    'News'
  ];

  int crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Commodity');
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // appBar: AppBarWithBack(text: "Indian Indices",height:40.h),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(105),
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.only(top: 5),
                child: Stack(
                  children: [
                    AppBarWithBack(text: "Commodity", height: 20),
                    // Container(
                    //   margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
                    //   child: AnimatedSearchBar(
                    //     stocks: gstocks,
                    //     indices: gindices,
                    //     fundsEtf: gfundsEtf,
                    //     etf: getf,
                    //     forex: gforex,
                    //     crypto: gcrypto,
                    //     commodity: gcommodity,
                    //     color: Colors.black,
                    //     onSubmit: (value) {
                    //       print('submitted search : $value');
                    //     },
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //     closeSearchOnSuffixTap: true,
                    //     suffixIcon: Icon(
                    //       Icons.close,
                    //       color: Colors.white,
                    //     ),
                    //     prefixIcon: Image.asset(
                    //       'images/loupe.png',
                    //       color: Colors.white,
                    //       height: 24,
                    //     ),
                    //     rtl: true,
                    //     width: MediaQuery.of(context).size.width,
                    //     textController: textController,
                    //     onSuffixTap: () {
                    //       setState(() {
                    //         textController.clear();
                    //       });
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
              TabBar(
                labelStyle: buttonWhite,
                unselectedLabelColor: Colors.white38,
                //indicatorSize: TabBarIndicatorSize.values[0.2],
                indicator: MaterialIndicator(
                  horizontalPadding: 24,
                  bottomLeftRadius: 8,
                  bottomRightRadius: 8,
                  color: almostWhite,
                  paintingStyle: PaintingStyle.fill,
                ),
                tabs: [
                  Tab(
                    text: "MCX",
                  ),
                  Tab(
                    text: "NCDEX",
                  ),
                  Tab(
                    text: "COMEX",
                  ),
                ],
              ),
            ],
          ),
        ),
        body: loading
            ? LoadingPage()
            : Padding(
                padding: EdgeInsets.only(top: 18, left: 16, right: 16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 600)
                      crossAxisCount = 2;
                    else {
                      crossAxisCount = 4;
                    }
                    return TabBarView(
                      children: [
                        como(true, context, arr.mcx),
                        comoncdex(false, context, arr.ncdex),
                        comex(false, context, arr.comex),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Widget como(bool ismcx, BuildContext context, List arr) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      header: ClassicHeader(
        completeIcon: Icon(Icons.done, color: Colors.white60),
        refreshingIcon: SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            color: Colors.white60,
          ),
        ),
      ),
      onRefresh: () => _fetchApiDataAndSearchData(),
      child: GridView.count(
        childAspectRatio: 0.78,
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(
          arr.length,
          (i) {
            return StockCard(
              onTap: () {
                BotToast.showText(
                    contentColor: almostWhite,
                    textStyle: TextStyle(color: black),
                    text: 'Coming soon!');
              },
              title: arr[i]?.name.toString().substring(4).contains('1 Kg')
                  ? arr[i]
                      ?.name
                      ?.toString()
                      ?.substring(4, arr[i].name.length - 5)
                  : arr[i]?.name.toString().substring(4).contains('WTI')
                      ? arr[i]
                          ?.name
                          ?.toString()
                          ?.substring(4, arr[i].name.length - 4)
                      : arr[i]?.name?.toString()?.substring(4),
              price: arr[i]?.price ?? "",
              highlight: (arr[i].chgPercentage == null || arr[i].change == null)
                  ? ""
                  : arr[i].change.substring(0, arr[i].change.length - 1) +
                      ' (' +
                      arr[i].chgPercentage.split('%')[0].substring(0, 5) +
                      '%)',
              color: arr[i].change.contains('-') ? red : blue,
              list: [
                RowItem(
                  "Open",
                  arr[i]?.open?.substring(0, arr[i].open.length - 1) ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
                RowItem(
                  "Hign",
                  arr[i]?.high?.substring(0, arr[i].high.length - 1) ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
                RowItem(
                  "Low",
                  arr[i]?.low?.substring(0, arr[i].low.length - 1) ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
                RowItem(
                  "Close",
                  arr[i]?.close?.substring(0, arr[i].close.length - 1) ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget comoncdex(bool ismcx, BuildContext context, List<Ncdex> arr) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      header: ClassicHeader(
        completeIcon: Icon(Icons.done, color: Colors.white60),
        refreshingIcon: SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            color: Colors.white60,
          ),
        ),
      ),
      onRefresh: () => _fetchApiDataAndSearchData(),
      child: GridView.count(
        childAspectRatio: 0.78,
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(
          arr.length,
          (i) {
            var tempname = arr[i]?.name?.split(' ');
            tempname.removeAt(0);
            var finalName = tempname.join(' ');
            return StockCard(
              onTap: () {
                BotToast.showText(
                  text: 'Coming soon!',
                  contentColor: almostWhite,
                  textStyle: TextStyle(color: black),
                );
              },
              // date: arr[i].expiryDate,
              title: finalName,
              price: arr[i]?.price ?? "",
              highlight: (arr[i].chgPercentage == null || arr[i].chg == null)
                  ? ""
                  : arr[i].chg.substring(0, arr[i].chg.length - 1) +
                      ' (' +
                      arr[i].chgPercentage.split('%')[0].substring(0, 5) +
                      '%)',
              color: arr[i].chg.contains('-') ? red : blue,
              list: [
                RowItem(
                  "Open",
                  arr[i]?.open?.substring(0, arr[i].open.length - 1) ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
                RowItem(
                  "High",
                  arr[i]?.high?.substring(0, arr[i].high.length - 1) ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
                RowItem(
                  "Low",
                  arr[i]?.low?.substring(0, arr[i].low.length - 1) ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
                RowItem(
                  "Close",
                  arr[i]?.close?.substring(0, arr[i].close.length - 1) ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget comex(bool ismcx, BuildContext context, List<Comex> arr) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      header: ClassicHeader(
        completeIcon: Icon(Icons.done, color: Colors.white60),
        refreshingIcon: SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            color: Colors.white60,
          ),
        ),
      ),
      onRefresh: () => _fetchApiDataAndSearchData(),
      child: GridView.count(
        childAspectRatio: 0.78,
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(
          arr.length,
          (i) {
            var tempname = arr[i]?.name?.split(' ');
            tempname.removeAt(0);
            var finalName = tempname.join(' ');
            return StockCard(
              onTap: () {
                BotToast.showText(
                  text: 'Coming soon!',
                  contentColor: almostWhite,
                  textStyle: TextStyle(color: black),
                );
              },
              title: finalName,
              price: arr[i]?.price ?? "",
              highlight: (arr[i].chgPercentage == null || arr[i].chg == null)
                  ? ""
                  : arr[i].chg.substring(0, arr[i].chg.length - 1) +
                      ' (' +
                      arr[i].chgPercentage.split('%')[0].substring(0, 5) +
                      '%)',
              color: arr[i].chg.contains('-') ? red : blue,
              list: [
                RowItem(
                  "Open",
                  arr[i]?.open?.substring(0, arr[i].open.length - 1) ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
                RowItem(
                  "High",
                  arr[i]?.high?.substring(0, arr[i].high.length - 1) ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
                RowItem(
                  "Low",
                  arr[i]?.low?.substring(0, arr[i].low.length - 1) ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
                RowItem(
                  "Close",
                  arr[i]?.close?.substring(0, arr[i].close.length - 1) ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
