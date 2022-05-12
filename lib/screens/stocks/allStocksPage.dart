import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/constants.dart';
import 'package:technical_ind/providers/navBarProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_ind/screens/stocks/business/models/allStockResponse.dart';
import 'package:technical_ind/screens/stocks/business/models/stockResponse.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';
import 'package:technical_ind/screens/stocks/explore/containerPage.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';

class AllStocksPage extends StatefulWidget {
  AllStocksPage({Key key}) : super(key: key);

  @override
  _AllStocksPageState createState() => _AllStocksPageState();
}

class StockListItem extends StatelessWidget {
  final String stockName, value, highlight, mcap, mcapText;
  final Color color;
  final Function onTap;

  const StockListItem(
      {Key key,
      this.mcapText,
      this.value,
      this.highlight,
      this.color,
      this.onTap,
      this.stockName,
      this.mcap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      height: 42,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(stockName,
                      textAlign: TextAlign.start, style: subtitle1White),
                  Row(
                    children: [
                      Text(
                        "MCap(₹) ",
                        style: captionWhite60,
                      ),
                      Text(
                        "$mcap",
                        style: captionWhite,
                      )
                    ],
                  )
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(value, textAlign: TextAlign.end, style: bodyText2White),
                  SizedBox(height: 2),
                  Text(highlight,
                      textAlign: TextAlign.end,
                      style: bodyText2.copyWith(color: color))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AllStocksPageState extends State<AllStocksPage>
    with SingleTickerProviderStateMixin {
  // AllStockResponse allStockResponseBSE, allStockResponseNSE;
  List<AllStockResponse> allStockResponseBSE, allStockResponseNSE;
  // final PagingController<int, Stock> _pagingController =
  //     PagingController(firstPageKey: 1);
  // double maxHeight = 0.8.sh;
  PanelController _panelController = new PanelController();
  TabController _controller;

  int _selected;

  List<String> menu = [
    'Automotive',
    'Banking/Finance',
    'Cement/Construction',
    'Chemicals',
    'Conglomerates',
    'Cons Durable',
    'Cons Non-Durable',
    //'Auto Ancillaries',
    'Engineering',
    'Food & Beverage',
    // 'Gold ETF',
    'Technology',
    'Manufacturing',
    'Media',
    'Metal & Mining',
    'Miscellaneous',
    'Oil & Gas',
    'Pharmaceuticals',
    'Retail/Real Estate',
    'Services',
    'Telecom',
    'Tabacco',
    'Utilities'
  ];
  List<String> codes = [
    'AUTOMOTIVE',
    'BANKING_FINANCE',
    'CEMENT_CONSTRUCTION',
    'CHEMICALS',
    'CONGLOMERATES',
    'CONS_DURABLE',
    'CONS_NON_DURABLE',
    'ENGINEERING',
    'FOOD_BEVERAGE',
    // 'GOLD_ETF',
    'TECHNOLOGY',
    'MANUFACTURING',
    'MEDIA',
    'METALS_MINING',
    'MISCELLANEOUS',
    'OIL_GAS',
    'PHARMACEUTICALS',
    'RETAIL_REAL_ESTATE',
    'SERVICES',
    'TELECOM',
    'TOBACCO',
    'UTILITIES',
  ];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SlidingUpPanel(
        onPanelClosed: () =>
            context.read(navBarVisibleProvider).setNavbarVisible(false),
        controller: _panelController,
        color: const Color(0xff1c1c1e),
        defaultPanelState: PanelState.CLOSED,
        backdropEnabled: true,
        // snapPoint: 0.2,
        minHeight: 0,
        maxHeight: 0.8 * MediaQuery.of(context).size.height,
        borderRadius: BorderRadius.circular(18),
        panel: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 6),
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                    color: white60, borderRadius: BorderRadius.circular(30)),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                      sectorValueMenu.length,
                      (index) => InkWell(
                            onTap: () {
                              _panelController.close().whenComplete(() {
                                setState(() {
                                  _selected = index;
                                  allStockResponseBSE = null;
                                  allStockResponseNSE = null;
                                  _fetchApi();
                                });
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 16, bottom: 28),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    child: Icon(
                                      Icons.check,
                                      color: _selected == index
                                          ? Colors.white.withOpacity(0.87)
                                          : Colors.transparent,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(sectorValueMenu[index],
                                        style: subtitle1.copyWith(
                                          color: _selected == index
                                              ? almostWhite
                                              : white38,
                                        ),
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ),
                          )),
                ),
              ),
            ),
          ],
        ),
        body: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(108),
            child: Column(
              children: [
                AppBarWithBack(
                  text: "All Stock List",
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
                                  Expanded(
                                    child: Text(
                                      sectorValueMenu[_selected],
                                      style: subtitle2White,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Icon(
                                    Icons.expand_more,
                                    color: almostWhite,
                                  )
                                ],
                              ),
                            ))))
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                TabBar(
                  controller: _controller,
                  labelStyle: subtitle2White,
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
                      text: "BSE",
                    ),
                    Tab(
                      text: "NSE",
                      //child: NSEtab(),
                    ),
                  ],
                ),
                //allStockResponse != null ? _mainCard() : Container(),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: TabBarView(
                  controller: _controller,
                  children: [
                    allStockResponseBSE != null
                        ? SmartRefresher(
                            controller: _refreshController,
                            enablePullDown: true,
                            enablePullUp: false,
                            header: ClassicHeader(
                              completeIcon:
                                  Icon(Icons.done, color: Colors.white60),
                              refreshingIcon: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            onRefresh: _fetchApi,
                            child: section(allStockResponseBSE))
                        : LoadingPage(),
                    allStockResponseNSE != null
                        ? SmartRefresher(
                            controller: _refreshController,
                            enablePullDown: true,
                            enablePullUp: false,
                            header: ClassicHeader(
                              completeIcon:
                                  Icon(Icons.done, color: Colors.white60),
                              refreshingIcon: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            onRefresh: _fetchApi,
                            child: section(allStockResponseNSE))
                        : LoadingPage()
                  ],
                )
                    //  PagedListView<int, Stock>(
                    //     pagingController: _pagingController,
                    //     builderDelegate: PagedChildBuilderDelegate<Stock>(
                    //       itemBuilder: (context, item, index) => StockListItem(
                    //         color: item.change <= 0 ? red : blue,
                    //         stockName: item.name,
                    //         value: item.price.toString(),
                    //         highlight: item.change <= 0
                    //             ? '${item.change} (${item.changePercentage.toStringAsFixed(2)}%)'
                    //             : '+${item.change} (+${item.changePercentage.toStringAsFixed(2)}%)',
                    //         onTap: () {
                    //           pushNewScreen(context,
                    //               withNavBar: false,
                    //               screen: Homepage(
                    //                 name: item.name,
                    //                 isin: item.isin,
                    //               ));
                    //         },
                    //       ),
                    //     ))
                    ),
                SizedBox(
                  height: kBottomNavigationBarHeight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView section(List<AllStockResponse> allStockResponse) {
    return ListView.builder(
      itemCount: allStockResponse.length,
      itemBuilder: (context, i) {
        var item = allStockResponse[i];
        Stock stock = Stock(
            change: item.change,
            changePercentage: item.changePercentage,
            isin: item.isin,
            lastPrice: item.lastPrice,
            marketCap: item.sortedBy,
            name: item.name,
            stockCode: item.stockCode);

        // print(allStockResponse.stocks[0].change);
        return StockListItem(
          color:
              (double.tryParse(item.changePercentage) ?? 0) <= 0 ? red : blue,
          stockName: item.name ?? "",
          value: item.lastPrice?.toString() ?? "",
          mcap: "${item.sortedBy} Cr",
          highlight: (double.tryParse(item.change) ?? 0) <= 0
              ? '${item.change == "-" ? "" : item.change} (${item.changePercentage ?? ""}%)'
              : '+${item.change == "-" ? "" : item.change} (+${item.changePercentage ?? ""}%)',
          onTap: () async {
            String isin = item?.isin;

            if (isin == null) {
              pushNewScreen(context,
                  withNavBar: false,
                  screen: ContainerPage(
                    isAllStocks: true,
                    isList: true,
                    isEvents: false,
                    defaultWidget: "Quick Summary",
                    stockCode: item.stockCode,
                    stockName: item?.name,
                  ));
            } else {
              pushNewScreen(context,
                  withNavBar: false,
                  screen: ContainerPage(
                    defaultWidget: "Quick Summary",
                    isList: true,
                    isEvents: false,
                    // stock: stock,
                    // isin: isin,
                    stockCode: item.stockCode,
                    isin: isin,
                    stockName: item?.name,
                  ));
            }
          },
        );
      },
    );
  }

  Column column1(String title, String sub, {Color color}) {
    return Column(
      children: [
        Text(
          title,
          style:
              color != null ? subtitle1.copyWith(color: color) : subtitle1White,
        ),
        Text(
          sub,
          style: captionWhite60,
        )
      ],
    );
  }

  _fetchApi() async {
    // List<String> codes = _selectedLeft ? valueCodes : sectorValueCodes;
    if (_controller.index == 1) {
      allStockResponseNSE =
          await StockServices.allStocks(sectorValueCodes[_selected], false);
      // allStockResponseNSE.sort((b, a) => (double.tryParse(a.marketCap) ?? 0.0)
      //     .toInt()
      //     .compareTo((double.tryParse(b.marketCap) ?? 0.0).toInt()));
    } else {
      allStockResponseBSE =
          await StockServices.allStocks(sectorValueCodes[_selected], true);
      // allStockResponseBSE.sort((b, a) => (double.tryParse(a.marketCap) ?? 0.0)
      //     .toInt()
      //     .compareTo((double.tryParse(b.marketCap) ?? 0.0).toInt()));
    }

    // allStockResponseNSE.stocks
    //     .sort((a, b) => a.marketCap.compareTo(b.marketCap));
    setState(() {});
    _refreshController.refreshCompleted();
  }

  // _fetchPage(int p) async {
  //   allStockResponse = await StockServices.allStocks(
  //       menu[_selected].toUpperCase().replaceAll(RegExp('[- ]'), '_'), p);
  //   setState(() {});
  //   final isLastPage = allStockResponse.stocks.length < 30;
  //   if (isLastPage) {
  //     _pagingController.appendLastPage(allStockResponse.stocks);
  //   } else {
  //     page = p + 1;
  //     _pagingController.appendPage(allStockResponse.stocks, page);
  //   }
  // }
  // Timer timer;
  @override
  void initState() {
    _selected = 0;
    // ScreenUtil.init(context);
    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() {
      setState(() {
        _fetchApi();
      });
    });
    _fetchApi();
    // timer = Timer.periodic(Duration(milliseconds: autoRefreshDuration), (t) {
    //   if (mounted)
    //     _fetchApi();
    //   else {
    //     print("Timer Ticking will stop.");
    //     t.cancel();
    //   }
    // });
    // _pagingController.addPageRequestListener((pageKey) {
    //   _fetchPage(pageKey);
    // });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // timer.cancel();
  }
  // Container _mainCard() {
  //   final meta = allStockResponse.metadata;
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 14),
  //     height: 188,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(6), color: darkGrey),
  //     child: Column(
  //       children: [
  //         column1(meta.count.toString(), "Stocks"),
  //         SizedBox(
  //           height: 16,
  //         ),
  //         Row(
  //           children: [
  //             Expanded(child: column1(meta.marketCap, "MKT CAP")),
  //             Expanded(child: column1(meta.volume, "Volume"))
  //           ],
  //         ),
  //         SizedBox(
  //           height: 12,
  //         ),
  //         Row(
  //           children: [
  //             Expanded(
  //                 child: column1(meta.changePercent, "Change",
  //                     color: meta.changePercent[0] == '+' ? blue : red)),
  //             Expanded(
  //                 child: column1(meta.performanceMonth, "Per Month",
  //                     color: meta.performanceMonth[0] == '+' ? blue : red)),
  //             Expanded(
  //                 child: column1(meta.performanceYear, "Per Year",
  //                     color: meta.performanceYear[0] == '+' ? blue : red)),
  //             Expanded(
  //                 child: column1(meta.performanceYearToDate, "Per YTD",
  //                     color:
  //                         meta.performanceYearToDate[0] == '+' ? blue : red)),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
}
