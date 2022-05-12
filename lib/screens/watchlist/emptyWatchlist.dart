import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/providers/navBarProvider.dart';
import 'package:technical_ind/screens/commodity/commodityhome.dart';
import 'package:technical_ind/screens/cryptocurrency/cyptoListingPage.dart';
import 'package:technical_ind/screens/etf/etfHome.dart';
import 'package:technical_ind/screens/forex/forexPage.dart';
import 'package:technical_ind/screens/indices/indicesHome.dart';
import 'package:technical_ind/screens/mutual/mutualFundsHome.dart';
import 'package:technical_ind/screens/stocks/stocks_home.dart';
import '../../styles.dart';

class EmptyWatchlist extends StatelessWidget {
  const EmptyWatchlist({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/startIcons/$title.svg",
            height: 130,
            width: 130,
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "Experience Investing",
            style: subtitle1White,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Watchlist helps you experience investing by\nallowing you to add $title and track their\nperformance over time.",
            style: bodyText2White60,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 48,
          ),
          InkWell(
            onTap: () {
              if (title == "Stocks") {
                pushNewScreenWithRouteSettings(context,
                    // screen: StockWatchList(), settings: RouteSettings());
                    screen: StockHome(
                      defaultWidget: "Trending",
                    ),
                    settings: RouteSettings());
              } else if (title == "Indices") {
                pushNewScreenWithRouteSettings(context,
                    screen: IndicesHome(), settings: RouteSettings());
              } else if (title == "Mutual Funds") {
                pushNewScreenWithRouteSettings(context,
                    screen: MutualFundsHome(), settings: RouteSettings());
              } else if (title == "ETF") {
                pushNewScreenWithRouteSettings(context,
                    screen: EtfHome(), settings: RouteSettings());
              } else if (title == "Forex") {
                pushNewScreenWithRouteSettings(context,
                    screen: ForexPage(), settings: RouteSettings());
              } else if (title == "Cryptocurrency") {
                pushNewScreenWithRouteSettings(context,
                    // screen: CryptoListingPage(), settings: RouteSettings());
                    screen: CryptoListingPage2(),
                    settings: RouteSettings());
              } else if (title == "Commodity") {
                pushNewScreenWithRouteSettings(context,
                    screen: CommodityHome(), settings: RouteSettings());
              } else {
                context.read(navBarVisibleProvider).controller.jumpToTab(0);
              }
            },
            child: Container(
              height: 40,
              width: 220,
              decoration: BoxDecoration(
                  color: darkGrey, borderRadius: BorderRadius.circular(6)),
              child: Center(
                child: Text(
                  "Search $title",
                  style: buttonWhite.copyWith(color: blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
