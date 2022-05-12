// import 'package:flutter/cupertino.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/containPage.dart';
import 'package:technical_ind/screens/News/broadcastPage.dart';
import 'package:technical_ind/screens/chartScreen.dart';
import 'package:technical_ind/screens/cryptocurrency/historyPage.dart';
import 'package:technical_ind/screens/forex/business/services.dart';
import 'package:technical_ind/screens/forex/forex_overview.dart';
import 'package:technical_ind/screens/forex/indicatorpageforex.dart';
import 'package:technical_ind/screens/landingPage.dart';
import 'package:technical_ind/screens/search/business/model.dart';
import '../../animated_search_bar.dart';
import '../../components/slidePanel.dart';
import '../../providers/navBarProvider.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import 'business/forexmodel.dart';
import 'package:http/http.dart' as http;

class ForexPage extends StatefulWidget {
  @override
  _ForexPageState createState() => _ForexPageState();
}

class _ForexPageState extends State<ForexPage> {
  int _selected;

  PanelController _panelController = new PanelController();
  List<String> menu = [
    "AUD - Austrailian Dollar",
    "CAD - Canadian dollar",
    "CHF - Swiss franc",
    "CNY - Chinese renminbi",
    "EUR - Euro",
    "GBP - Pound Sterling",
    "INR - Indian Rupees",
    "JPY - Japanese Yen",
    "NZD - New Zealand Dollar",
    "SEK - Swedish krona",
    "USD - US Dollar"
  ];
  List<String> codes = [
    'AUD',
    'CAD',
    'CHF',
    'CNY',
    'EUR',
    'GBP',
    'INR',
    'JPY',
    'NZD',
    'SEK',
    'USD',
  ];

  List<String> noDataValues = ['INR/NZD', 'INR/CHF', 'INR/CAD', 'INR/AUD'];
  int crossAxisCount;
  List<ForexModel> forexLists = [];

  var jsonText;
  List<StockSearch> stocks;
  List<IndicesSearch> indices;
  List<FundEtfSearch> fundsEtf;
  List<EtfSearch> etf;
  List<ForexSearch> forex;
  List<CryptoSearch> crypto;
  List<CommoditySearch> commodity;
  TextEditingController textController = TextEditingController();
  bool isLoading = true;

  _fetchApiAndSearchData() async {
    for (var i in codes) {
      forexLists.add(await ForexServices.forexlist(i));
    }
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
      isLoading = false;
    });
  }

  _fetchApiAt(int i) async {
    forexLists[i] = await ForexServices.forexlist(codes[i]);
    _refreshController.refreshCompleted();
    setState(() {});
  }

  @override
  void initState() {
    _selected = menu.indexOf("INR - Indian Rupees");
    super.initState();
    
    _fetchApiAndSearchData();
    // Timer.periodic(Duration(milliseconds: autoRefreshDuration), (t) {
    //   if (mounted)
    //     _fetchApiAndSearchData();
    //   else {
    //     print("Timer Ticking is stopping.");
    //     t.cancel();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Forex');
    return Material(
      child: forexLists.isNotEmpty && forexLists.length >= 7
          ? SlidePanel(
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
                    preferredSize: Size.fromHeight(120),
                    child: Column(
                      children: [
                        // Container(
                        //   // margin: EdgeInsets.only(top: 5),
                        //   child: Stack(
                        //     children: [
                        //       AppBarWithBack(
                        //         text: "Forex",
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
                        //         child: AnimatedSearchBar(
                        //           stocks: gstocks,
                        //           indices: gindices,
                        //           fundsEtf: gfundsEtf,
                        //           etf: getf,
                        //           forex: gforex,
                        //           crypto: gcrypto,
                        //           commodity: gcommodity,
                        //           color: Colors.black,
                        //           onSubmit: (value) {
                        //             print('submitted search : $value');
                        //           },
                        //           style: TextStyle(
                        //             color: Colors.white,
                        //           ),
                        //           closeSearchOnSuffixTap: true,
                        //           suffixIcon: Icon(
                        //             Icons.close,
                        //             color: Colors.white,
                        //           ),
                        //           prefixIcon: Image.asset(
                        //             'images/loupe.png',
                        //             color: Colors.white,
                        //             height: 24,
                        //           ),
                        //           rtl: true,
                        //           width: MediaQuery.of(context).size.width,
                        //           textController: textController,
                        //           onSuffixTap: () {
                        //             setState(() {
                        //               textController.clear();
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        AppBarWithBack(
                          text: "Forex",
                        ),
                        InkWell(
                          onTap: () {
                            context
                                .read(navBarVisibleProvider)
                                .setNavbarVisible(true);
                            _panelController.open();
                          },
                          child: Hero(
                            tag: "explore1",
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 2),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 11),
                                //height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color(0xff1c1c1e),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(menu[_selected],
                                        style: subtitle2White),
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
                  body: Padding(
                    padding: EdgeInsets.only(
                        top: 8,
                        left: 16,
                        right: 16,
                        bottom: kBottomNavigationBarHeight),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 600)
                          crossAxisCount = 2;
                        else {
                          crossAxisCount = 4;
                        }
                        return section(context);
                      },
                    ),
                  )),
            )
          : LoadingPage(),
    );
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  section(BuildContext context) {
    forexLists[_selected]
        .forexList
        .removeWhere((element) => noDataValues.contains(element.name));
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
      onRefresh: () => _fetchApiAt(_selected),
      child: GridView.count(
        childAspectRatio: 0.74,
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(
          forexLists[_selected].forexList.length,
          (index) => forexTile(index, context),
        ),
      ),
    );
  }

  List<String> containerMenu = [
    "Overview",
    "Charts",
    "Technical Indicators",
    "Historical Data",
    "News",
  ];

  Widget forexTile(int i, BuildContext context) {
    var d = forexLists[_selected].forexList[i];
    return GestureDetector(
      onTap: () {
        pushNewScreen(
          context,
          withNavBar: false,
          screen: ContainPage(
            isListForex: true,
            query: d.name.replaceAll("/", ""),
            menu: containerMenu,
            menuWidgets: [
              ForexOverviewPage(
                query: d.name.replaceAll("/", ""),
                price:
                    // isSearch
                    //     ? price
                    //     :
                    d.price,
                chng:
                    // widget.isSearch
                    //     ? chng
                    //     :
                    d.change,
                chngPercentage:
                    //  widget.isSearch
                    //     ? chngPercentage
                    //     :
                    d.changePercent,
              ),
              ChartScreen(
                isForex: true,
                companyName: d.name,
              ),
              IndicatorPageForex(
                query: d.name.replaceAll("/", ""),
              ),
              HistoryPage(
                isForex: true,
                isin: d.name.replaceAll("/", ""),
                // historicalData:
                //     forexModel.historicalData,
              ),
              NewsWidget(
                isForex: true,
                title: d.name,
              ),
            ],
            title: d.name,
            defaultWidget: containerMenu[0],
          ),
          // ForexExplorePage(
          //     menu: [
          //       "Overview",
          //       "Charts",
          //       "Technical Indicators",
          //       "Historical Data",
          //       "News",
          //     ],
          //     code: d.name.replaceAll("/", ""),
          //     title: d.name,
          //     price: d.price,
          //     change: d.change,
          //     changePercentage: d.changePercent
          //     //good
          //     ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(
          right: 16,
          left: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: darkGrey,
        ),
        child: Center(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(d.name, style: subtitle1White),
                SizedBox(height: 10),
                Text(d.price, style: subtitle2White),
                SizedBox(height: 2),
                Text(
                  "${d.change.substring(0, 5)} ${d.changePercent}",
                  style: subtitle2.copyWith(
                      color: d.change[0] != '-' ? blue : red),
                ),
                SizedBox(height: 13),
                rows('Bid', d.bid),
                rows('Ask', d.ask),
                rows('High', d.high),
                rows('Low', d.low),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget rows(String s, String d) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(s, textAlign: TextAlign.left, style: bodyText2White60),
          Text(d, textAlign: TextAlign.right, style: bodyText2White)
        ],
      ),
    );
  }
}
