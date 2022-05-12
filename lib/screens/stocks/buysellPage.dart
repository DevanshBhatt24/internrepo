import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/screens/stocks/explore/containerPage.dart';

import '../../components/customcard.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import '../../widgets/item.dart';
import 'business/models/buyerssellers.dart';
import 'business/stockServices.dart';
import 'explore/home.dart';

class BuySellPage extends StatefulWidget {
  BuySellPage({Key key}) : super(key: key);

  @override
  _BuySellPageState createState() => _BuySellPageState();
}

class _BuySellPageState extends State<BuySellPage> {
  int _selected = 0;

  int crossAxisCount;
  List<BuyerSeller> bseSeller, bseBuyer, nseSeller, nseBuyer;
  _fetchapi() async {
    bseSeller = await StockServices.buyerSellers("stock_sellers", 'bse');
    setState(() {});
    nseSeller = await StockServices.buyerSellers("stock_sellers", 'nse');
    setState(() {});
    bseBuyer = await StockServices.buyerSellers("stock_buyers", 'bse');
    setState(() {});
    nseBuyer = await StockServices.buyerSellers("stock_buyers", 'nse');
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    _fetchapi();
    // Timer.periodic(Duration(milliseconds: autoRefreshDuration), (t) {
    //   if (mounted)
    //     _fetchapi();
    //   else {
    //     print("Timer Ticking is stopping.");
    //     t.cancel();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          //backgroundColor: Colors.black,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(168),
              child: Column(
                children: [
                  AppBarWithBack(
                    text: 'Buyers/Sellers',
                  ),
                  TabBar(
                    labelStyle: buttonWhite,
                    unselectedLabelColor: white38,
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
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      _button(0, 'Only Buyers'),
                      _button(1, 'Only Sellers')
                    ],
                  )
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
                return TabBarView(children: [
                  bseBuyer != null && bseSeller != null
                      ? section(context, bseSeller, bseBuyer)
                      : LoadingPage(),
                  nseBuyer != null && nseSeller != null
                      ? section(context, nseSeller, nseBuyer)
                      : LoadingPage(),
                ]);
              },
            ),
          ),
        ));
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Widget section(
      BuildContext context, List<BuyerSeller> seller, List<BuyerSeller> buyer) {
    List<BuyerSeller> data = _selected == 0 ? buyer : seller;
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
                        isEvents: false,
                        isList: true,
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
            style: captionWhite60,
          ),
          Text(
            val,
            style: captionWhite,
          )
        ],
      ),
    );
  }
}
