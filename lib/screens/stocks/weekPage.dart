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
import 'package:technical_ind/screens/stocks/explore/containerPage.dart';
import 'package:technical_ind/widgets/item.dart';

import '../../components/customcard.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import 'business/models/weekhighlow.dart';
import 'business/stockServices.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'explore/home.dart';

class WeekPage extends StatefulWidget {
  final bool isHigh;
  WeekPage({Key key, this.isHigh = true}) : super(key: key);

  @override
  _WeekPageState createState() => _WeekPageState();
}

class _WeekPageState extends State<WeekPage>
    with SingleTickerProviderStateMixin {
  int _selected = 0;

  int crossAxisCount;
  List<HighLow> bseHigh = [], nseHigh = [];
  _fetchapi() async {
    if (widget.isHigh == true) {
      bseHigh = await StockServices.weekHighLowBSE("bsehigh");
      setState(() {});
      nseHigh = await StockServices.weekHighLowNSE("nsehigh");
      setState(() {});
    } else {
      bseHigh = await StockServices.weekHighLowBSE("bselow");
      setState(() {});
      nseHigh = await StockServices.weekHighLowNSE("nselow");
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  TabController _controller;
  PanelController _panelController = new PanelController();

  List<String> menu = [];

  _fetchDataAt(int index) async {
    if (widget.isHigh == true) {
      if (_controller.index == 0) {
        bseHigh = await StockServices.weekHighLowBSE("bsehigh");

        setState(() {});
      } else {
        nseHigh = await StockServices.weekHighLowNSE("nsehigh");

        setState(() {});
      }
    } else {
      if (_controller.index == 0) {
        bseHigh = await StockServices.weekHighLowBSE("bselow");

        setState(() {});
      } else {
        nseHigh = await StockServices.weekHighLowNSE("nselow");

        setState(() {});
      }
    }
  }

  _refreshDataAt(int index) async {
    if (widget.isHigh == true) {
      if (_controller.index == 0) {
        bseHigh = await StockServices.weekHighLowBSE("bsehigh");

        setState(() {});
      } else {
        nseHigh = await StockServices.weekHighLowNSE("nsehigh");

        setState(() {});
      }
    } else {
      if (_controller.index == 0) {
        bseHigh = await StockServices.weekHighLowBSE("bselow");

        setState(() {});
      } else {
        nseHigh = await StockServices.weekHighLowNSE("nselow");

        setState(() {});
      }
    }
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    _controller.addListener(() {
      setState(() {
        _selected = 0;
        menu = _controller.index == 0 ? bseMenu : nseMenu;
      });
    });

    menu = bseMenu;
    _fetchapi();
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
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        //backgroundColor: Colors.black,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Column(
              children: [
                AppBarWithBack(
                  text: widget.isHigh == true ? '52 Week High' : '52 Week Low',
                ),
                TabBar(
                  labelStyle: buttonWhite,
                  unselectedLabelColor: white38,
                  controller: _controller,
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
              return TabBarView(controller: _controller, children: [
                bseHigh != null && bseHigh.isEmpty == false
                    ? section(context, bseHigh)
                    : bseHigh != null
                        ? LoadingPage()
                        : NoDataAvailablePage(),
                nseHigh != null && nseHigh.isEmpty == false
                    ? section(context, nseHigh)
                    : nseHigh != null
                        ? LoadingPage()
                        : NoDataAvailablePage()
              ]);
            },
          ),
        ),
      ),
    );

    // return DefaultTabController(
    //     length: 2,
    //     initialIndex: 0,
    //     child: Scaffold(
    //       //backgroundColor: Colors.black,
    //       appBar: PreferredSize(
    //           preferredSize: Size.fromHeight(168),
    //           child: Column(
    //             children: [
    //               AppBarWithBack(
    //                 text: '52 Week High/low',
    //               ),
    //               TabBar(
    //                 labelStyle: buttonWhite,
    //                 unselectedLabelColor: white38,
    //                 //indicatorSize: TabBarIndicatorSize.label,
    //                 indicator: MaterialIndicator(
    //                   horizontalPadding: 30,
    //                   bottomLeftRadius: 8,
    //                   bottomRightRadius: 8,
    //                   color: Colors.white,
    //                   paintingStyle: PaintingStyle.fill,
    //                 ),
    //                 tabs: [
    //                   Tab(
    //                     text: "BSE",
    //                   ),
    //                   Tab(
    //                     text: "NSE",
    //                     //child: NSEtab(),
    //                   ),
    //                 ],
    //               ),
    //               SizedBox(
    //                 height: 18,
    //               ),
    //               Row(
    //                 children: [
    //                   _button(0, '52 Week high'),
    //                   _button(1, '52 Week Low')
    //                 ],
    //               )
    //             ],
    //           )),
    //       body: Padding(
    //         padding: EdgeInsets.only(top: 18, left: 16, right: 16),
    //         child: LayoutBuilder(
    //           builder: (context, constraints) {
    //             if (constraints.maxWidth < 600)
    //               crossAxisCount = 2;
    //             else {
    //               crossAxisCount = 4;
    //             }
    //             return TabBarView(children: [
    //               bseHigh != null && bseLow != null
    //                   ? section(context, bseHigh, bseLow)
    //                   : LoadingPage(),
    //               nseHigh != null && nselow != null
    //                   ? section(context, nseHigh, nselow)
    //                   : LoadingPage(),
    //             ]);
    //           },
    //         ),
    //       ),
    //     ));
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Widget section(BuildContext context, List<HighLow> high) {
    // List<HighLow> data = _selected == 0 ? high : low;
    List<HighLow> data = high;
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
      onRefresh: () => _fetchapi(),
      child: GridView.count(
        childAspectRatio: 0.93,
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(
            data.length,
            (index) => InkWell(
                  onTap: () {
                    pushNewScreen(
                      context,
                      withNavBar: false,
                      screen: ContainerPage(
                        isList: true,
                        isEvents: false,
                        stockName: data[index].companyName,
                        stockCode: data[index].stockCode,
                        defaultWidget: "Quick Summary",
                      ),
                    );
                  },
                  child: CustomCardStock(
                    title: data[index].companyName,
                    // date: data[index].sector,
                    price: data[index].price,
                    highlight:
                        double.parse(data[index].chg.replaceAll(',', '')) > 0
                            ? "(+${data[index].chg} %)"
                            : " (${data[index].chg} %)",
                    color: double.parse(data[index].chg.replaceAll(',', '')) > 0
                        ? blue
                        : red,
                    list: [
                      RowItem(
                        "High",
                        data[index].high,
                        fontsize: 14,
                        pad: 3,
                      ),
                      RowItem(
                        "Low",
                        data[index].low,
                        fontsize: 14,
                        pad: 3,
                      ),
                    ],
                  ),
                )),
      ),
    );
  }

  Expanded _button(int index, String title) {
    return Expanded(
        child: Center(
      child: InkWell(
        onTap: () {
          setState(() {
            _selected = index;
          });
        },
        child: Container(
          width: 150,
          height: 40,
          padding: EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
              color: _selected == index ? almostWhite : Colors.transparent,
              borderRadius: BorderRadius.circular(6)),
          child: Center(
              child: Text(
            title,
            style:
                button.copyWith(color: _selected == index ? darkGrey : white38),
          )),
        ),
      ),
    ));
  }

  Padding _row(String title, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: bodyText2White60,
          ),
          Text(
            val,
            style: bodyText2White,
          )
        ],
      ),
    );
  }
}
