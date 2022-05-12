import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_ind/components/containPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/News/broadcastPage.dart';
import 'package:technical_ind/screens/chartScreen.dart';
import 'package:technical_ind/screens/cryptocurrency/historyPage.dart';
import 'package:technical_ind/screens/cryptocurrency/indicatorsPage.dart';
import 'package:technical_ind/screens/cryptocurrency/overviewPAge.dart';
import 'package:technical_ind/screens/search/business/model.dart';
import '../../components/flatTile.dart';
import '../../providers/navBarProvider.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import 'business/eftlist_model.dart';
import 'business/etf_services.dart';

class EtfHome extends StatefulWidget {
  EtfHome({Key key}) : super(key: key);

  @override
  _EtfHomeState createState() => _EtfHomeState();
}

class _EtfHomeState extends State<EtfHome> {
  int _selected = 0;
  bool _loading = true;

  PanelController _panelController = new PanelController();
  List<String> exploremenu = [
    "Overview",
    "Charts",
    "Technical Indicators",
    "Historical Data",
    "News"
  ];

  List<List<EtfListModel>> etf = [];
  List<String> results = [];

  var jsonText;
  List<StockSearch> stocks;
  List<IndicesSearch> indices;
  List<FundEtfSearch> fundsEtf;
  List<EtfSearch> etfSearch;
  List<ForexSearch> forex;
  List<CryptoSearch> crypto;
  List<CommoditySearch> commodity;
  TextEditingController textController = TextEditingController();

  _fetchetflistandSearchData() async {
    etf.add(await EtfServices.getEtfList('major'));
    etf.add(await EtfServices.getEtfList('equity'));
    etf.add(await EtfServices.getEtfList('bonds'));
    etf.add(await EtfServices.getEtfList('commodity'));
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
      _loading = false;
    });
  }

  _fetchApiAt() async {
    etf[_selected] = await EtfServices.getEtfList(codes[_selected]);
    setState(() {});
    _refreshController.refreshCompleted();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<String> codes = [
    "major",
    "equity",
    "bonds",
    "commodity",
  ];
  List<String> menu = [
    "Major",
    "Equity",
    "Bonds",
    "Commodity",
  ];
  // List<String> menu = [
  //   "All",
  //   "Gold",
  //   "Banking",
  //   "Index",
  //   "Liquid",
  //   "International"
  // ];
  List<String> titleRow = ["Open", "High", "Low"];

  @override
  void initState() {
    _selected = menu.indexOf("Major");
    super.initState();
    _fetchetflistandSearchData();
    // Timer.periodic(Duration(milliseconds: autoRefreshDuration), (t) {
    //   if (mounted)
    //     _fetchApiAt();
    //   else {
    //     print("Timer Ticking is stopping.");
    //     t.cancel();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'ETF');
    return Material(
      child: _loading
          ? LoadingPage()
          : etf == null
              ? NoDataAvailablePage()
              : SlidingUpPanel(
                  controller: _panelController,
                  color: const Color(0xff1c1c1e),
                  defaultPanelState: PanelState.CLOSED,
                  backdropEnabled: true,
                  minHeight: 0,
                  maxHeight: menu.length * 60.0,
                  onPanelClosed: () {
                    context.read(navBarVisibleProvider).setNavbarVisible(false);
                  },
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18)),
                  panel: Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 8, bottom: 18),
                          width: 38,
                          height: 4,
                          decoration: BoxDecoration(
                              color: white60,
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                      // Center(
                      //   child: Text(
                      //     "Return",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w500,
                      //       fontSize: 20,
                      //       color: const almostWhite,
                      //     ),
                      //   ),
                      // ),
                      ...List.generate(
                          menu.length,
                          (index) => InkWell(
                                onTap: () {
                                  _panelController.close().whenComplete(() {
                                    setState(() {
                                      _selected = index;
                                    });
                                  });
                                },
                                child: Container(
                                  height: 48,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 40,
                                          child: Icon(
                                            Icons.check,
                                            color: _selected == index
                                                ? Colors.white.withOpacity(0.87)
                                                : Colors.transparent,
                                          )),
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
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(130),
                      child: Column(
                        children: [
                          Container(
                            // margin: EdgeInsets.only(top: 5),
                            child: AppBarWithBack(
                              text: "ETF",
                              height: 40,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              context
                                  .read(navBarVisibleProvider)
                                  .setNavbarVisible(true);
                              _panelController.open();
                              _panelController.open();
                            },
                            child: Hero(
                              tag: "explore1",
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  //height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xff1c1c1e),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        menu[_selected],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: const Color(0xffffffff)
                                                .withOpacity(0.87)),
                                      ),
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
                          // TabBar(
                          //   labelStyle: subtitle2White,
                          //   unselectedLabelColor: Colors.white38,
                          //   //indicatorSize: TabBarIndicatorSize.label,
                          //   indicator: MaterialIndicator(
                          //     horizontalPadding: 24,
                          //     bottomLeftRadius: 8,
                          //     bottomRightRadius: 8,
                          //     color: almostWhite,
                          //     paintingStyle: PaintingStyle.fill,
                          //   ),
                          //   tabs: [
                          //     Tab(
                          //       text: "BSE",
                          //     ),
                          //     Tab(
                          //       text: "NSE",
                          //       //child: NSEtab(),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.only(bottom: 55),
                      child: SmartRefresher(
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
                        onRefresh: () => _fetchApiAt(),
                        child: ListView.builder(
                          itemBuilder: (context, i) {
                            return buildListView(
                              context,
                              true,
                              etf[_selected][i]?.etfName ?? "",
                              etf[_selected][i]?.price ?? "",
                              etf[_selected][i]?.change ?? "",
                              etf[_selected][i]?.changePer ?? "",
                              etf[_selected][i]?.high ?? "",
                              etf[_selected][i]?.low ?? "",
                              etf[_selected][i]?.backendParameter ?? "",
                              etf[_selected][i]?.open ?? "",
                              etf[_selected][i]?.chartSymbol ?? "",
                            );
                          },
                          itemCount: etf[_selected].length,
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }

  List<String> containerMenu = [
    "Overview",
    "Charts",
    "Technical Indicators",
    "Historical Data",
    "News"
  ];

  buildListView(
      BuildContext context,
      bool isBse,
      String name,
      String price,
      String netchange,
      String percentchange,
      String high,
      String low,
      // String vol,
      String id,
      String open,
      String tickerSymbol) {
    String temp = 'ETF';
    // for (int j = 1; j < menu.length; j++) {
    //   for (var ele in (isBse ? etfsbse[j] : etfsnse[j])) {
    //     if (ele.schemeName == name) {
    //       temp = menu[j];
    //     }
    //   }
    // }
    return InkWell(
      onTap: () {
        pushNewScreen(
          context,
          screen: ContainPage(
            query: id,
            isListEtf: true,
            isList: false,
            menu: containerMenu,
            menuWidgets: [
              OverviewPage(
                query: id,
                price:
                    //  widget.isSearch
                    //     ? price
                    // :
                    price,
                chng:
                    // widget.isSearch
                    //     ? netchange
                    //     :
                    netchange,
                chngPercentage:
                    // widget.isSearch
                    //     ? "($percentchange)"
                    //     :
                    "($percentchange)",
                isEtf: true,
              ),
              ChartScreen(
                isEtf: true,
                etfTicker:
                    // widget.isSearch == false
                    //     ? widget.tickerSymbol
                    //     :
                    tickerSymbol,
                isUsingWeb: true,
              ),
              IndicatorPage(
                isEtf: true,
                query: id,
              ),
              HistoryPage(
                isEtf: true,
                isin: id,
              ),
              NewsWidget(
                isEtf: true,
                // articles: articles,
              )
            ],
            title: name.split("(")[0],
            defaultWidget: containerMenu[0],
          ),
          //  ExplorePageETF(
          //     id: id,
          //     defaultheight: 95,
          //     tickerSymbol: tickerSymbol,
          //     title: name.split("(")[0],
          //     mid: Column(
          //       children: [
          //         SizedBox(
          //           height: 12,
          //         ),
          //         Text(_selected == 0 ? temp : menu[_selected],
          //             textAlign: TextAlign.center, style: bodyText2White60),
          //         SizedBox(
          //           height: 14,
          //         ),
          //         // RatingBar.readOnly(
          //         //   initialRating: 4,
          //         //   isHalfAllowed: true,
          //         //   halfFilledIcon: Icons.star_half,
          //         //   filledIcon: Icons.star,
          //         //   emptyIcon: Icons.star_border,
          //         //   filledColor: almostWhite,
          //         //   emptyColor: almostWhite,
          //         //   size: 25,
          //         // ),
          //       ],
          //     ),
          //     end: Column(
          //       children: [
          //         Text(price,
          //             textAlign: TextAlign.center, style: headline5White),
          //         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //           Text(
          //             "${netchange}",
          //             textAlign: TextAlign.center,
          //             style: highlightStyle.copyWith(
          //                 color: netchange.contains("-") ? red : blue),
          //           ),
          //           Text(
          //             "(${percentchange})",
          //             textAlign: TextAlign.center,
          //             style: highlightStyle.copyWith(
          //                 color: netchange.contains("-") ? red : blue),
          //           ),
          //         ])
          //         // SizedBox(height: 60.h,)
          //       ],
          //     ),
          //     menu: exploremenu,
          //     lasttradeprice: price,
          //     netchange: netchange,
          //     percentage: percentchange),
          withNavBar: false,
        );
      },
      child: FlatTile(
        valueRow: [open, high, low],
        titleRow: titleRow,
        midWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(price, textAlign: TextAlign.center, style: subtitle2White),
            SizedBox(
              height: 2,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "${netchange}",
                textAlign: TextAlign.center,
                style: highlightStyle.copyWith(
                    color: netchange.contains("-") ? red : blue),
              ),
              Text(
                "(${percentchange})",
                textAlign: TextAlign.center,
                style: highlightStyle.copyWith(
                    color: netchange.contains("-") ? red : blue),
              ),
            ])
          ],
        ),
        title: name.split("(")[0],
      ),
    );
  }
}
