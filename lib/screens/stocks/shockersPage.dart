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
import 'package:technical_ind/screens/stocks/explore/containerPage.dart';
import 'package:technical_ind/widgets/item.dart';

import '../../components/customcard.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';

import 'business/models/shockers.dart';
import 'business/stockServices.dart';
import 'explore/home.dart';

class ShockersPage extends StatefulWidget {
  final isVolume;
  ShockersPage({Key key, this.isVolume = false}) : super(key: key);

  @override
  _ShockersPageState createState() => _ShockersPageState();
}

class _ShockersPageState extends State<ShockersPage>
    with SingleTickerProviderStateMixin {
  int _selected = 0;
  int crossAxisCount;
  List<PriceShocker> bsePrice = [], nsePrice = [];

  PanelController _panelController = new PanelController();

  List<String> menu = [];

  _fetchapi() async {
    if (widget.isVolume == false) {
      bsePrice = await StockServices.shockers("bse", "priceshocker", true);
      setState(() {});
      nsePrice = await StockServices.shockers("nse", "priceshocker", true);
      setState(() {});
    } else {
      bsePrice = await StockServices.shockers("bse", "volumeshocker", false);

      setState(() {});
      nsePrice = await StockServices.shockers("nse", "volumeshocker", false);

      setState(() {});
    }
    // bseVol = await StockServices.shockers("stock_volumeshocker", 'bse');
    // setState(() {});
    // nseVol = await StockServices.shockers("stock_volumeshocker", 'nse');
    // setState(() {});
    _refreshController.refreshCompleted();
  }

  _fetchDataAt(int index) async {
    if (widget.isVolume == false) {
      if (_controller.index == 0) {
        bsePrice = await StockServices.shockers("bse", "priceshocker", true);

        setState(() {});
      } else {
        nsePrice = await StockServices.shockers("nse", "priceshocker", true);

        setState(() {});
      }
    } else {
      if (_controller.index == 0) {
        bsePrice = await StockServices.shockers("bse", "volumeshocker", false);

        setState(() {});
      } else {
        nsePrice = await StockServices.shockers("nse", "volumeshocker", false);

        setState(() {});
      }
    }
  }

  _refreshDataAt(int index) async {
    if (widget.isVolume == false) {
      if (_controller.index == 0) {
        bsePrice = await StockServices.shockers("bse", "priceshocker", true);

        setState(() {});
      } else {
        nsePrice = await StockServices.shockers("nse", "priceshocker", true);

        setState(() {});
      }
    } else {
      if (_controller.index == 0) {
        bsePrice = await StockServices.shockers("bse", "volumeshocker", false);

        setState(() {});
      } else {
        nsePrice = await StockServices.shockers("nse", "volumeshocker", false);

        setState(() {});
      }
    }
    _refreshController.refreshCompleted();
  }

  TabController _controller;

  @override
  void initState() {
    super.initState();
    // print(bseCodes.length);
    // print(bseMenu.length);
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
                  text: widget.isVolume == false
                      ? 'Price Shockers'
                      : 'Volume Shockers',
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
                bsePrice != null && bsePrice.isEmpty == false
                    ? section(context, bsePrice)
                    : bsePrice != null
                        ? LoadingPage()
                        : NoDataAvailablePage(),
                nsePrice != null && nsePrice.isEmpty == false
                    ? section(context, nsePrice)
                    : nsePrice != null
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
    //                 text: 'Price/Volume Shockers',
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
    //               // SizedBox(
    //               //   height: 18,
    //               // ),
    //               // Row(
    //               //   children: [
    //               //     _button(0, 'Price Shockers'),
    //               //     _button(1, 'Volume Shockers')
    //               //   ],
    //               // )
    //             ],
    //           )),
    //       body: Container(
    //         padding: EdgeInsets.only(top: 0, left: 16, right: 16),
    //         child: LayoutBuilder(
    //           builder: (context, constraints) {
    //             if (constraints.maxWidth < 600)
    //               crossAxisCount = 2;
    //             else {
    //               crossAxisCount = 4;
    //             }
    //             return TabBarView(children: [
    // bsePrice != null && bseVol != null
    //     ? section(context, bsePrice, bseVol)
    //     : LoadingPage(),
    // nsePrice != null && nseVol != null
    //     ? section(context, nsePrice, nseVol)
    //     : LoadingPage(),
    //             ]);
    //           },
    //         ),
    //       ),
    //     ));
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Widget section(BuildContext context, List<PriceShocker> price) {
    // List<PriceShocker> data = _selected == 0 ? price : vol;
    List<PriceShocker> data = price;
    if (data.length == 0) {
      _fetchDataAt(
        _selected,
      );
      return LoadingPage();
    }
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
      onRefresh: () => _refreshDataAt(_selected),
      child: GridView.count(
        childAspectRatio: 1.05,
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
                    title: data[index]?.companyName ?? "",
                    date: data[index]?.sector ?? "",
                    price: data[index]?.price ?? "",
                    highlight:
                        double.parse(data[index].chg.replaceAll(',', '')) > 0
                            ? "(+${data[index].chg} %)"
                            : "(${data[index].chg} %)",
                    color: double.parse(data[index].chg.replaceAll(',', '')) > 0
                        ? blue
                        : red,
                    list: [
                      RowItem(
                        widget.isVolume ? "Avg Vol" : "Prev Price",
                        data[index]?.previousPrice ?? "",
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
