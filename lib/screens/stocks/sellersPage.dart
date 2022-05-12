import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/constants.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/providers/navBarProvider.dart';
import 'package:technical_ind/screens/stocks/business/models/buyerssellers.dart';
import 'package:technical_ind/screens/stocks/explore/containerPage.dart';
import 'package:technical_ind/widgets/item.dart';

import '../../components/customcard.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';

import 'business/models/shockers.dart';
import 'business/stockServices.dart';
import 'explore/home.dart';

class SellersPage extends StatefulWidget {
  SellersPage({
    Key key,
  }) : super(key: key);

  @override
  _SellersPageState createState() => _SellersPageState();
}

class _SellersPageState extends State<SellersPage>
    with SingleTickerProviderStateMixin {
  int _selected = 0;
  int crossAxisCount;
  List<PriceShocker> bsePrice = [], nsePrice = [];

  PanelController _panelController = new PanelController();

  List<String> menu = [];
  List<BuyerSeller> bseSellers, nseSellers;

  _fetchapi() async {
    bseSellers = await StockServices.getSellers('bse');
    nseSellers = await StockServices.getSellers('nse');
    setState(() {});

    // bseVol = await StockServices.shockers("stock_volumeshocker", 'bse');
    // setState(() {});
    // nseVol = await StockServices.shockers("stock_volumeshocker", 'nse');
    // setState(() {});
    _refreshController.refreshCompleted();
  }

  _fetchDataAt(int index) async {
    if (_controller.index == 0) {
      setState(() {
        bseSellers = [];
      });
      bseSellers = await StockServices.getSellers('bse');
      setState(() {});
    } else {
      setState(() {
        nseSellers = [];
      });
      nseSellers = await StockServices.getSellers('nse');
      setState(() {});
    }
  }

  _refreshDataAt(int index) async {
    if (_controller.index == 0) {
      bseSellers = await StockServices.getSellers('bse');

      setState(() {});
    } else {
      nseSellers = await StockServices.getSellers('nse');
      setState(() {});
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
                AppBarWithBack(text: 'Only Sellers'),
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
                bseSellers != null
                    ? section(context, bseSellers)
                    : LoadingPage(),
                nseSellers != null
                    ? section(context, nseSellers)
                    : LoadingPage(),
              ]);
            },
          ),
        ),
      ),
    );
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Widget section(BuildContext context, List<BuyerSeller> buyer) {
    List<BuyerSeller> data = buyer;
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
                    title: data[index].companyName,
                    date: data[index].sector,
                    price: data[index].price,
                    highlight:
                        double.parse(data[index].chg.replaceAll(',', '')) > 0
                            ? " (+${data[index].chg} %)"
                            : "(${data[index].chg} %)",
                    color: double.parse(data[index].chg.replaceAll(',', '')) > 0
                        ? blue
                        : red,
                    list: [
                      RowItem(
                        "Bid Qty",
                        data[index].bidQty,
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
