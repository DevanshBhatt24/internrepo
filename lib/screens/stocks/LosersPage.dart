import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/constants.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/providers/navBarProvider.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_ind/screens/stocks/explore/containerPage.dart';
import '../../components/customcard.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import '../../widgets/item.dart';
import 'business/models/gainerLoserModel.dart';
import 'explore/home.dart';

class LosersPage extends StatefulWidget {
  LosersPage({Key key}) : super(key: key);

  @override
  _LosersPageState createState() => _LosersPageState();
}

class _LosersPageState extends State<LosersPage>
    with SingleTickerProviderStateMixin {
  int crossAxisCount;
  int _selected = 0;
  bool loading = true;
  // List<StockData2> stockData.bse = [], stockData.nse = [];
  StockModel2 stockData;
  _fetchApi() async {
 
  stockData = await StockServices2.getTopLosers();
  // stockData.bse  =stoc
    setState(() {
      loading = false;
    });
  }

  _fetchDataAt(int index) async {
    if (_controller.index == 0) {
      setState(() {
      });
      
      setState(() {});
    } else {
      setState(() {
      });
    }
    setState(() {
      stockData;
    });
    stockData = await StockServices2.getTopLosers();
    setState(() {});
  }

  _refreshDataAt(int index) async {
    stockData = await StockServices2.getTopLosers();
    if (_controller.index == 0) {
      stockData.bse = stockData.bse;
      setState(() {});
    } else {
      stockData.nse = stockData.nse;
      setState(() {});
    }
    stockData = await StockServices2.getTopLosers();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<String> menu = [];
  TabController _controller;
  @override
  void initState() {
    print(bseCodes.length);
    print(bseMenu.length);
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    _controller.addListener(() {
      setState(() {
        _selected = 0;
        menu = _controller.index == 0 ? bseMenu : nseMenu;
      });
    });

    menu = bseMenu;
    _fetchApi();
    // Timer.periodic(Duration(milliseconds: autoRefreshDuration), (t) {
    //   if (mounted)
    //     _refreshDataAt(_selected);
    //   else {
    //     print("Timer Ticking is stopping.");
    //     t.cancel();
    //   }
    // });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
    // Material(
    //   child: SlidingUpPanel(
    //     onPanelClosed: () =>
    //         context.read(navBarVisibleProvider).setNavbarVisible(false),
    //     controller: _panelController,
    //     color: const Color(0xff1c1c1e),
    //     defaultPanelState: PanelState.CLOSED,
    //     backdropEnabled: true,
    //     // snapPoint: 0.2,
    //     minHeight: 0,
    //     maxHeight: MediaQuery.of(context).size.height * 0.8,
    //     borderRadius: BorderRadius.circular(18),
    //     panel: Column(
    //       children: [
    //         Center(
    //           child: Container(
    //             margin: EdgeInsets.only(top: 6),
    //             width: 38,
    //             height: 4,
    //             decoration: BoxDecoration(
    //                 color: white60, borderRadius: BorderRadius.circular(30)),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 24,
    //         ),
    //         Expanded(
    //           child: SingleChildScrollView(
    //             child: Column(
    //               children: List.generate(
    //                   menu.length,
    //                   (index) => InkWell(
    //                         onTap: () {
    //                           _panelController.close().whenComplete(() {
    //                             setState(() {
    //                               _selected = index;
    //                             });
    //                             _fetchDataAt(_selected);
    //                           });
    //                         },
    //                         child: Container(
    //                           padding: EdgeInsets.only(left: 16, bottom: 28),
    //                           child: Row(
    //                             children: [
    //                               Container(
    //                                   width: 40,
    //                                   child: Icon(
    //                                     Icons.check,
    //                                     color: _selected == index
    //                                         ? Colors.white.withOpacity(0.87)
    //                                         : Colors.transparent,
    //                                   )),
    //                               Text(
    //                                 menu[index],
    //                                 style: subtitle1.copyWith(
    //                                   color: _selected == index
    //                                       ? almostWhite
    //                                       : white38,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       )),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
        // body: 
        Scaffold(
          backgroundColor: Colors.black,
          appBar: 
          PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Column(
                children: [
                  // AppBarWithBack(
                  //   text: 'Top Losers',
                  // ),
                  TabBar(
                    labelStyle: buttonWhite,
                    unselectedLabelColor: white38,
                    controller: _controller,
                    //indicatorSize: TabBarIndicatorSize.label,
                    indicator: MaterialIndicator(
                      horizontalPadding: 30,
                      bottomLeftRadius: 8,
                      bottomRightRadius: 8,
                      color: Colors.white,
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
                  // SizedBox(
                  //   height: 8,
                  // ),
                  
                ],
              )),

          body: Padding(
            padding: EdgeInsets.only(top: 18, left: 16, right: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600)
                  crossAxisCount = 2;
                else {
                  crossAxisCount = 4;
                }
                return loading
                    ? LoadingPage()
                    : !stockData.nse.isEmpty || stockData != null
                        ? TabBarView(
                          controller: _controller,
                          children: [section(context, stockData.bse), section(context, stockData.nse)])
                        : NoDataAvailablePage();
              },
            ),
          ),
        // ),
      // ),
    );
  }

  Widget section(BuildContext context, List<StockData2> data) {
    if (data.length == 0) {
      _fetchDataAt(
        _selected,
      );
      return LoadingPage();
    }
    final d = data;
    return Column(
      children: [
        Expanded(
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
            onRefresh: () => _refreshDataAt(_selected),
            child: GridView.count(
              childAspectRatio: 0.75,
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: List.generate(
                  d.length,
                  (index) => InkWell(
                        onTap: () {
                          pushNewScreen(
                            context,
                            withNavBar: false,
                            screen: ContainerPage(
                              isList: true,
                              isEvents: false,
                              stockName: d[index].name,
                              stockCode: d[index].backendParameter,
                              defaultWidget: "Quick Summary",
                            ),
                          );
                        },
                        child: CustomCardStock(
                          title: d[index].name,
                          price: d[index].price,
                          highlight:
                              double.parse(d[index].chg.replaceAll(',', '')) > 0
                                  ? "+${d[index].chg}"
                                  : "${d[index].chg}"
                                     +
                                 " (${d[index].chgPer})" ,
                          color:
                              double.parse(d[index].chg.replaceAll(',', '')) > 0
                                  ? blue
                                  : red,
                          list: [
                            RowItem(
                              "High",
                              d[index].high,
                              fontsize: 14,
                              pad: 3,
                            ),
                            RowItem(
                              "Low",
                              d[index].low,
                              fontsize: 14,
                              pad: 3,
                            ),
                            RowItem(
                               "Volume",
                              d[index].volume,
                              fontsize: 14,
                              pad: 3,
                            ),
                          ],
                        ),
                      )),
            ),
          ),
        ),
        // SizedBox(
        //   height: kBottomNavigationBarHeight,
        // )
      ],
    );
  }
}
