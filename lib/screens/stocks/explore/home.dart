import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/codeSearch.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/components/utils.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/News/business/newsServices.dart';
import 'package:technical_ind/screens/search/business/model.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/models/allStockResponse.dart';
import 'package:technical_ind/screens/stocks/business/models/stockPrice.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';
import 'package:technical_ind/widgets/appbar_with_back_and_search.dart';
import '../../../styles.dart';
import '../../../widgets/appbar_with_bookmark_and_share.dart';
import 'containerPage.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  final String name, isin, stockCode, sector;
  final Stock stock;
  final bool isRecom;
  final bool isEvents, isSearch;

  const Homepage(
      {Key key,
      this.name,
      this.isSearch = false,
      this.stock,
      this.isin = "empty",
      this.stockCode,
      this.sector,
      this.isRecom = false,
      this.isEvents = false})
      : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  StockDetail stockDetail;

  StockPrice stockPrice;

  String name = '';
  String isin, sector;
  bool loading = true;

  List<Article> articles = [];
  void getArticles(String title) async {
    if (this.mounted) {
      articles = await NewsServices.getNewsFromQuery(title).whenComplete(() {
        setState(() {});
      });
    }
  }

  _fetchApi() async {
    if (widget.isin == 'empty') {
      // await _searchIsin();
      if (widget.isEvents) {
        CodeSearch codeSearch =
            await Utils.getStockCodes('trendlyne_id', widget.stockCode);
        isin = codeSearch.isin;
      } else {
        String url = widget.isRecom
            ? 'https://api.bottomstreet.com/api/data?page=stocks_internal_details&filter_name=marketsmojo_id&filter_value=${widget.stockCode}'
            : 'https://api.bottomstreet.com/api/data?page=stocks_internal_details&filter_name=moneycontrol_code&filter_value=${widget.stockCode}';
        print(url);
        var response = await http.get(Uri.parse(url));
        var jsonbody = json.decode(response?.body);
        isin = jsonbody["isin"];
      }
      if (isin != null) {
        await _searchdetailsFromISIN(isin);
        stockDetail = await StockServices.stockDetail(isin);
        stockPrice = await StockServices.stockPrice(isin);
      }
    } else {
      if (widget.isin != null && !widget.isSearch) {
        await _searchdetailsFromISIN(widget.isin);
      } else {
        setState(() {
          name = widget.name;
          this.isin = widget.isin;
          sector = widget.sector;
        });
      }
      if (widget.isin != null)
        stockPrice = await StockServices.stockPrice(widget.isin);
      if (widget.isin != null)
        stockDetail = await StockServices.stockDetail(widget.isin);
    }

    setState(() {
      loading = false;
    });
  }

  // Future<void> _searchIsin() async {
  //   List<StockSearch> stocks;
  //   var jsonText = await rootBundle.loadString('assets/instrument/stocks.json');
  //   print("done");
  //   stocks = stockSearchFromJson(jsonText);
  //   StockSearch s;
  //   if (widget.stockCode != null) {
  //     s = stocks[stocks
  //         .indexWhere((element) => element.stockCode == widget.stockCode)];
  //   } else {
  //     s = stocks[stocks.indexWhere((element) => element.name
  //         .toLowerCase()
  //         .trim()
  //         .contains(widget.name.toLowerCase().trim()))];
  //   }
  //   setState(() {
  //     name = s.name;
  //     isin = s.isin;
  //     sector = s.sector;
  //   });
  // }

  Future<void> _searchdetailsFromISIN(String isin) async {
    List<StockSearch> stocks;
    var jsonText =
        await rootBundle.loadString('assets/instrument/stocks_list.json');
    // print("done");
    stocks = stockSearchFromJson(jsonText);
    StockSearch s =
        stocks[stocks.indexWhere((element) => element.isin == isin)];
    setState(() {
      name = s.name;
      this.isin = isin;
      sector = s.sector;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchApi();
    getArticles(widget.name);
  }

  Future<bool> checkIsSaved() async {
    print("checking saved...");
    var user = context.read(firestoreUserProvider);
    if (user.containsKey('StocksWatchlist')) {
      List<dynamic> stockwatchlist = user['StocksWatchlist'];

      return stockwatchlist.contains(isin);
    }
    return false;
  }

  PanelController _panelController = new PanelController();
  List<String> menu = [
    "Quick Summary",
    "Quotes",
    'Charts',
    "Technical Indicators",
    "News",
    'F & O',
    "Volatility",
    "Delivery",
    "Historical Data",
    "Broadcast",
    "Shareholdings",
    "Financials",
    "Valuation",
    "Returns",
    "Peers",
    'SWOT',
    "Quality",
    'Deals',
    'Crucial checklist',
    'Scrutiny',
    "About",
    // "ESG Ratings",
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
        child: loading
            ? LoadingPage()
            : (stockPrice?.bse == null || stockPrice?.nse == null)
                ? Scaffold(
                    appBar: AppBarWithBack(
                      text: "",
                    ),
                    body: NoDataAvailablePage(
                      message:
                          "We are updating the data. Please come back after sometime.",
                    ),
                  )
                : SlidingUpPanel(
                    controller: _panelController,
                    color: const Color(0xff1c1c1e),
                    defaultPanelState: PanelState.CLOSED,
                    backdropEnabled: true,
                    minHeight: 0,
                    maxHeight: 0.88 * MediaQuery.of(context).size.width,
                    borderRadius: BorderRadius.circular(18),
                    panel: Column(children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 8, bottom: 24),
                          width: 38,
                          height: 4,
                          decoration: BoxDecoration(
                              color: white60,
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(name ?? "",
                              textAlign: TextAlign.center,
                              style: subtitle2White),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                                menu.length,
                                (index) => InkWell(
                                      onTap: () {
                                        _panelController
                                            .close()
                                            .whenComplete(() {
                                          setState(() {
                                            pushNewScreen(context,
                                                screen: ContainerPage(
                                                  defaultWidget: menu[index],
                                                  isin: isin,
                                                  stockName: name,
                                                  articles: articles,
                                                ));
                                          });
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 14),
                                        alignment: Alignment.centerLeft,
                                        child: Text(menu[index],
                                            style: subtitle1White),
                                      ),
                                    )),
                          ),
                        ),
                      ),
                    ]),
                    body: Scaffold(
                      // backgroundColor: kindaWhite,
                      appBar: isin != null
                          ? AppbarWithShare(
                              showShare: false,
                              isSaved: checkIsSaved,
                              onSaved: () async {
                                print("saving...");
                                var db = context.read(storageServicesProvider);
                                await db.updateStocksWatchlist(isin);
                                BotToast.showText(
                                    contentColor: almostWhite,
                                    textStyle: TextStyle(color: black),
                                    text: "Added to Watchlist");
                              },
                              delSaved: () async {
                                print("removing...");
                                var db = context.read(storageServicesProvider);
                                await db.removeStockWatchlistFromList([isin]);
                                BotToast.showText(
                                    contentColor: almostWhite,
                                    textStyle: TextStyle(color: black),
                                    text: "Removed from Watchlist");
                              },
                            )
                          : null,
                      body: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? MediaQuery.of(context).size.height * 1.4
                              : MediaQuery.of(context).size.height * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  // SizedBox(
                                  //   height: 165,
                                  // ),
                                  Center(
                                      child: Text(name,
                                          textAlign: TextAlign.center,
                                          style: headline6)),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Center(
                                    child: Text(
                                      stockDetail != null
                                          ? "$sector / BSE: ${stockDetail.about.details.bse} / NSE: ${stockDetail.about.details.nse}"
                                          : sector ?? "",
                                      style: bodyText2White60,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 163,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment: stockPrice != null
                                          ? MainAxisAlignment.spaceBetween
                                          : MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        stockPrice != null
                                            ? Column(children: <Widget>[
                                                Text(
                                                  'BSE',
                                                  textAlign: TextAlign.center,
                                                  style: subtitle1White60,
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Text(stockPrice.bse.price,
                                                    textAlign: TextAlign.center,
                                                    style: headline5White),
                                                Row(
                                                  children: [
                                                    Text(
                                                        '${stockPrice.bse.change}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: bodyText2.copyWith(
                                                            color: stockPrice
                                                                    .bse.change
                                                                    .contains(
                                                                        '-')
                                                                ? red
                                                                : blue)),
                                                    Text(
                                                        ' ${stockPrice.bse.changePercent}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: bodyText2.copyWith(
                                                            color: stockPrice
                                                                    .bse
                                                                    .changePercent
                                                                    .contains(
                                                                        '-')
                                                                ? red
                                                                : blue)),
                                                  ],
                                                ),
                                              ])
                                            : CircularProgressIndicator(
                                                color: white,
                                              ),
                                        Container(
                                          width: 4,
                                          height: 87,
                                          color: Color(0xffffffff)
                                              .withOpacity(0.12),
                                        ),
                                        stockPrice != null
                                            ? Column(
                                                children: <Widget>[
                                                  Text('NSE',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: subtitle1White60),
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  Text(
                                                    stockPrice.nse.price,
                                                    textAlign: TextAlign.center,
                                                    style: headline5White,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          '${stockPrice.nse.change}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: bodyText2.copyWith(
                                                              color: stockPrice
                                                                      .nse
                                                                      .change
                                                                      .contains(
                                                                          '-')
                                                                  ? red
                                                                  : blue)),
                                                      Text(
                                                          ' ${stockPrice.nse.changePercent}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: bodyText2.copyWith(
                                                              color: stockPrice
                                                                      .nse
                                                                      .changePercent
                                                                      .contains(
                                                                          '-')
                                                                  ? red
                                                                  : blue)),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Center(
                                                child:
                                                    CircularProgressIndicator(
                                                color: white,
                                              ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 70,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    // if (stockDetail != null)
                                    _panelController.open();
                                  },
                                  child: Hero(
                                    tag: "explore",
                                    child: Material(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        width: 240,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            color: Colors.white12,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/explore.svg',
                                              color: almostWhite,
                                            ),
                                            Text("   Explore",
                                                style: buttonWhite),
                                            Flexible(
                                              child: Container(),
                                            ),
                                            // stockDetail != null
                                            // ?
                                            Icon(
                                              CupertinoIcons.forward,
                                              color: almostWhite,
                                              //size: 30,
                                            )
                                            // : Container(
                                            //     height: 20,
                                            //     width: 20,
                                            //     child: CircularProgressIndicator(
                                            //       strokeWidth: 2,
                                            //       color: Colors.white,
                                            //     )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )));
  }
}
