import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/News/business/newsServices.dart';
import 'package:technical_ind/screens/chartScreen.dart';
import 'package:technical_ind/screens/stocks/explore/peersPage.dart';
import 'package:technical_ind/widgets/appbar_with_bookmark_and_share.dart';
import '../../../styles.dart';
import '../../cryptocurrency/historyPage.dart';
import '../../cryptocurrency/indicatorsPage.dart';
import '../financials/financialPage.dart';
import 'aboutPage.dart';
import '../../News/broadcastPage.dart';
import 'crucialCheckList.dart';
import 'deals.dart';
import 'deliveryPage.dart';
import 'enquiry.dart';
import 'fAndO.dart';
import 'qualityPage.dart';
import 'quotesPage.dart';
import 'returnsPage.dart';
import 'shareholdingPage.dart';
import 'summaryPage.dart';
import 'swot.dart';
import 'valuationPage.dart';
import 'votalityPage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ContainerPage extends StatefulWidget {
  final String defaultWidget;
  final String isin;
  final String stockCode;
  final bool isList, isEvents, isAllStocks;

  final String stockName;
  final List<Article> articles;
  ContainerPage(
      {Key key,
      this.isEvents,
      this.isList = false,
      this.defaultWidget,
      this.isin = null,
      this.stockName,
      this.articles,
      this.stockCode,
      this.isAllStocks = false})
      : super(key: key);

  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  int _selected;
  double _maxHeight;
  bool _expanded = false;

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
    // "Historical Data",
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

  String isin;
  bool loading = true;

  Future<bool> checkIsSaved() async {
    print("checking saved...");
    var user = context.read(firestoreUserProvider);
    if (user.containsKey('StocksWatchlist')) {
      List<dynamic> stockwatchlist = user['StocksWatchlist'];

      return stockwatchlist.contains(isin);
    }
    return false;
  }

  fetchApi() async {
    if (isin == null && widget.isin == null) {
      String stockCode = widget.stockCode;
      print("stock code : " + stockCode);
      String url = !widget.isAllStocks
          ? 'https://api.bottomstreet.com/api/data?page=stocks_internal_details&filter_name=investing_historical_data_url&filter_value=$stockCode'
          : 'https://api.bottomstreet.com/api/data?page=stocks_internal_details&filter_name=moneycontrol_code&filter_value=${stockCode}';
      print(url);
      var response = await http.get(Uri.parse(url));
      var jsonbody = json.decode(response?.body);
      isin = jsonbody["isin"];
    } else
      isin = widget.isin;
    loading = false;
    setState(() {});
  }

  List<Article> articles = [];
  void getArticles(String title) async {
    if (this.mounted) {
      articles = await NewsServices.getNewsFromQuery(title).whenComplete(() {
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    _selected = menu.indexOf(widget.defaultWidget);
    // _maxHeight = 0.68.sh;
    // _maxHeight = 0.68 * MediaQuery.of(context).size.height;
    getArticles(widget.stockName);
    fetchApi();
    super.initState();
    // ScreenUtil.init(BoxConstraints());
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      SummaryPage(isin: isin),
      QuotesPage(isin: isin),
      ChartScreen(isin: isin, isUsingWeb: true, companyName: widget.stockName),
      IndicatorPage(
        isStock: true,
        isin: isin,
      ),
      NewsWidget(
        isStock: true,
        title: widget.stockName,
      ),
      FandO(
          // futureAndOptions: widget.stockFutureandOptions,
          isin: isin),
      VotalityPage(
          // volatility: widget.stockDetail.volatility,
          isin: isin),
      DeliveryPage(isin: isin),
      // HistoryPage(
      //   isin: isin,
      //   isStock: true,
      // ),
      BroadcastPage(isin: isin, articles: articles),
      ShareHoldingPage(
        isin: isin,
      ),
      FinancialPage(
        isin: isin,
        title: widget.stockName,
      ),
      ValuationPage(isin: isin),
      ReturnsPage(isin: isin),
      PeersPage(
        isin: isin,
      ),
      SwotPage(isin: isin),
      QualityPage(isin: isin),
      DealsPage(isin: isin),
      CrucialChecklistPage(isin: isin),
      Enquiry(
        isin: isin,
      ),
      AboutPage(isin: isin),
      // SustainPage(isin: widget.isin),
    ];

    return loading
        ? LoadingPage()
        : Material(
            child: SlidingUpPanel(
              controller: _panelController,
              color: const Color(0xff1c1c1e),
              defaultPanelState: PanelState.CLOSED,
              backdropEnabled: true,
              minHeight: 0,
              maxHeight: 0.7 * MediaQuery.of(context).size.height,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18), topRight: Radius.circular(18)),
              panel: Column(
                children: [
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
                      child: Text(widget.stockName,
                          textAlign: TextAlign.center, style: subtitle2White),
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
                              _panelController.close().whenComplete(() {
                                if (widgetList[index] != null)
                                  setState(() {
                                    _selected = index;
                                  });
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              child: Row(
                                children: [
                                  Container(
                                      width: 24,
                                      child: Icon(
                                        Icons.check,
                                        color: _selected == index
                                            ? almostWhite
                                            : Colors.transparent,
                                      )),
                                  SizedBox(
                                    width: 16,
                                  ),
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
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Scaffold(
                //backgroundColor: kindaWhite,
                appBar: PreferredSize(
                  preferredSize: _selected != 2
                      ? Size.fromHeight(120)
                      : MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? Size.fromHeight(0)
                          : Size.fromHeight(60),
                  child: Column(
                    children: [
                      _selected == menu.indexOf("Charts") &&
                              MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                          ? SizedBox()
                          : !widget.isList
                              ? AppBar(
                                  backgroundColor: Colors.black,
                                  elevation: 0,
                                  leading: IconButton(
                                    icon: Icon(CupertinoIcons.back),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  title: Text(
                                    widget.stockName,
                                    style: headline6,
                                  ),
                                )
                              : Container(),
                      isin != null && widget.isList
                          ? AppbarWithShare(
                              showTitle: true,
                              title: widget.stockName,
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
                          : Container(),
                      isin == null && widget.isList
                          ? AppBar(
                              backgroundColor: Colors.black,
                              elevation: 0,
                              leading: IconButton(
                                icon: Icon(CupertinoIcons.back),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              title: Text(
                                widget.stockName,
                                style: headline6,
                              ),
                            )
                          : Container(),
                      _selected == menu.indexOf("Charts")
                          ? Container()
                          : InkWell(
                              onTap: () {
                                _panelController.open();
                              },
                              child: Hero(
                                tag: "explore",
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 6),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    //height: 40.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xff1c1c1e),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(menu[_selected],
                                            style: buttonWhite),
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
                body: widgetList[_selected],
              ),
            ),
          );
  }
}
