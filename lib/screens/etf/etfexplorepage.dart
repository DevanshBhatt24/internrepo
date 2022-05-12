import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/containPage.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/News/broadcastPage.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/News/business/newsServices.dart';
import 'package:technical_ind/screens/chartScreen.dart';
import 'package:technical_ind/screens/cryptocurrency/historyPage.dart';
import 'package:technical_ind/screens/cryptocurrency/indicatorsPage.dart';
import 'package:technical_ind/screens/cryptocurrency/overviewPAge.dart';
import 'package:technical_ind/screens/etf/business/eftlist_model.dart';
import 'package:technical_ind/screens/etf/business/etf_services.dart';
import 'package:technical_ind/screens/search/business/model.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/styles.dart';
import 'package:technical_ind/widgets/appbar_with_bookmark_and_share.dart';
import 'business/models/etf_explore_model.dart' as exploremodel;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExplorePageETF extends StatefulWidget {
  final selectedindex;
  final List<String> menu;
  final bool isSearch;
  final String title, value, subValue, commodityname, id, tickerSymbol;
  final Widget top, mid, end;
  final String expiryDate;
  final double defaultheight;
  final lasttradeprice;
  final netchange;
  final percentage;

  ExplorePageETF(
      {Key key,
      this.isSearch = false,
      this.tickerSymbol,
      this.percentage,
      this.netchange,
      this.lasttradeprice,
      this.selectedindex,
      this.commodityname,
      this.menu,
      this.title,
      this.value,
      this.subValue,
      this.expiryDate,
      this.top,
      this.mid,
      this.end,
      this.defaultheight = 80,
      this.id})
      : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePageETF> {
  PanelController _panelController = new PanelController();

  Future<bool> checkIsSaved() async {
    print("checking saved...");
    var user = context.read(firestoreUserProvider);
    if (user.containsKey('EtfWatchlist')) {
      List<dynamic> etfwatchlist = user['EtfWatchlist'];

      return etfwatchlist.contains(widget.id);
    }
    return false;
  }

  var jsonText;
  List<FundEtfSearch> fundsEtf;
  bool isloading = false;
  exploremodel.MutualFund etfSummaryModel;
  exploremodel.EtfExploreModel etfExploreModel;
  String etfcodename;
  // _loadData() async {
  //   jsonText = await rootBundle.loadString('assets/instrument/fundsEtf.json');
  //   // print("done");
  //   fundsEtf = fundEtfSearchFromJson(jsonText);
  //   for (var i in fundsEtf) {
  //     if (widget.isSearch == true) {
  //       if (i.field3.toString() == widget.id) {
  //         print(i.fundName);
  //         etfcodename = i.fundName;
  //         etfSummaryModel = await EtfServices.etfDetails(i.fundName);
  //         etfExploreModel = await EtfServices.getEtfExplore(i.fundName);
  //       }
  //     } else {
  //       if (i.field3.toString() == widget.id) {
  //         print(i.fundName);
  //         etfcodename = i.fundName;
  //         etfSummaryModel = await EtfServices.etfDetails(i.fundName);
  //         etfExploreModel = await EtfServices.getEtfExplore(i.fundName);
  //       }
  //     }
  //   }
  //   setState(() {
  //     if (etfSummaryModel != null && etfExploreModel != null)
  //       isloading = false;
  //     else
  //       isloading = true;
  //   });
  // }

  List<Article> articles = [];

  // void getArticles(String title) async {
  //   articles = await NewsServices.getNewsFromQuery(title).whenComplete(() {
  //     setState(() {
  //       isloading = false;
  //     });
  //   });
  // }

  String temp = 'ETF';
  int _selected = 0;
  List<String> menu = [
    "Overview",
    "Charts",
    "Technical Indicators",
    "Historical Data",
    "News"
  ];

  EtfOverviewModel etfoverview;

  String price = "";
  String netchange = "";
  String percentchange = "";
  String tickerSymbol = "";
  _loadData() async {
    etfoverview = await EtfServices.getEtfOverview(widget.id);
    setState(() {
      price = etfoverview.price;
      netchange = etfoverview.etfChange;
      percentchange = etfoverview.etfChangePer;
      tickerSymbol = etfoverview.chartSymbol;
    });
  }

  @override
  void initState() {
    super.initState();
    if (!widget.isSearch) {
      menu = widget.menu;
    }
    // _loadData();
    if (widget.isSearch) {
      _loadData();
    }
    // getArticles("ETF news");
    print('etf name is ' + widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SlidingUpPanel(
        controller: _panelController,
        color: Color(0xff1c1c1e),
        defaultPanelState: PanelState.CLOSED,
        backdropEnabled: true,
        minHeight: 0,
        maxHeight: widget.defaultheight + menu.length * 48 + 2,
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
                    color: white60, borderRadius: BorderRadius.circular(30)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(widget.title,
                    textAlign: TextAlign.center, style: subtitle2White),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ...List.generate(
              widget.isSearch == false ? widget.menu.length : menu.length,
              (index) => InkWell(
                onTap: () {
                  _panelController.close().whenComplete(
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContainPage(
                              menu: [
                                "Overview",
                                "Charts",
                                "Technical Indicators",
                                "Historical Data",
                                "News"
                              ],
                              menuWidgets: [
                                OverviewPage(
                                  query: widget.id,
                                  price: widget.isSearch
                                      ? price
                                      : widget.lasttradeprice,
                                  chng: widget.isSearch
                                      ? netchange
                                      : widget.netchange,
                                  chngPercentage: widget.isSearch
                                      ? "($percentchange)"
                                      : "(${widget.percentage})",
                                  isEtf: true,
                                ),
                                ChartScreen(
                                  isEtf: true,
                                  etfTicker: widget.isSearch == false
                                      ? widget.tickerSymbol
                                      : tickerSymbol,
                                  isUsingWeb: true,
                                ),
                                IndicatorPage(
                                  isEtf: true,
                                  query: widget.id,
                                ),
                                HistoryPage(
                                  isEtf: true,
                                  isin: widget.id,
                                ),
                                NewsWidget(
                                  isEtf: true,
                                  // articles: articles,
                                )
                              ],
                              title: widget.title,
                              defaultWidget: menu[index],
                            ),
                          ),
                        ),
                      );
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: new Text(menu[index], style: subtitle1White),
                ),
              ),
            )
          ],
        ),
        body: Scaffold(
          // backgroundColor: kindaWhite,
          appBar: widget.id != null
              ? AppbarWithShare(
                  showShare: false,
                  isSaved: checkIsSaved,
                  onSaved: () async {
                    var db = context.read(storageServicesProvider);
                    await db.updateEtfWatchlist(widget.id);
                    BotToast.showText(
                        contentColor: almostWhite,
                        textStyle: TextStyle(color: black),
                        text: "Added to Watchlist");
                  },
                  delSaved: () async {
                    print("removing...");
                    var db = context.read(storageServicesProvider);
                    await db.removeEtfWatchlist([widget.id]);
                    BotToast.showText(
                        contentColor: almostWhite,
                        textStyle: TextStyle(color: black),
                        text: "Removed from Watchlist");
                  },
                )
              : null,
          body: widget.isSearch == true && price == ""
              ? LoadingPage()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          // SizedBox(
                          //   height: 165,
                          // ),
                          widget.top != null
                              ? widget.top
                              : Center(
                                  child: Text(widget.title,
                                      textAlign: TextAlign.center,
                                      style: headline6)),
                          widget.mid != null ? widget.mid : Container(),
                          if (widget.isSearch)
                            Column(
                              children: [
                                SizedBox(
                                  height: 12,
                                ),
                                Text(_selected == 0 ? temp : menu[_selected],
                                    textAlign: TextAlign.center,
                                    style: bodyText2White60),
                                SizedBox(
                                  height: 14,
                                ),
                                // RatingBar.readOnly(
                                //   initialRating: 4,
                                //   isHalfAllowed: true,
                                //   halfFilledIcon: Icons.star_half,
                                //   filledIcon: Icons.star,
                                //   emptyIcon: Icons.star_border,
                                //   filledColor: almostWhite,
                                //   emptyColor: almostWhite,
                                //   size: 25,
                                // ),
                              ],
                            ),
                          SizedBox(
                              height: (widget.expiryDate != null) ? 15 : 0),
                          (widget.expiryDate != null)
                              ? Center(
                                  child: Text(widget.expiryDate,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: almostWhite,
                                          fontWeight: FontWeight.w600)))
                              : SizedBox(),
                          (widget.expiryDate != null)
                              ? Center(
                                  child: Text('Expiry date',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: white60,
                                      )))
                              : SizedBox(),
                          SizedBox(
                            height: 100,
                          ),
                          if (widget.isSearch == false)
                            widget.end != null
                                ? widget.end
                                : Center(
                                    child: Text(widget.lasttradeprice,
                                        style: headline5White)),
                          if (widget.isSearch)
                            Column(
                              children: [
                                Text(price,
                                    textAlign: TextAlign.center,
                                    style: headline5White),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${netchange}",
                                        textAlign: TextAlign.center,
                                        style: highlightStyle.copyWith(
                                            color: netchange.contains("-")
                                                ? red
                                                : blue),
                                      ),
                                      Text(
                                        "(${percentchange})",
                                        textAlign: TextAlign.center,
                                        style: highlightStyle.copyWith(
                                            color: netchange.contains("-")
                                                ? red
                                                : blue),
                                      ),
                                    ])
                                // SizedBox(height: 60.h,)
                              ],
                            ),
                          if (!widget.isSearch)
                            widget.end != null
                                ? Container()
                                : Center(
                                    child: Row(
                                    children: [
                                      Text(widget.netchange,
                                          style:
                                              bodyText2.copyWith(color: blue)),
                                      Text(widget.percentage,
                                          style:
                                              bodyText2.copyWith(color: blue))
                                    ],
                                  )),
                        ],
                      ),
                      SizedBox(
                        height:
                            (widget.expiryDate != null || widget.end != null)
                                ? 80
                                : 128,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            if (isloading == false) _panelController.open();
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
                                    borderRadius: BorderRadius.circular(6)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/explore.svg',
                                      color: almostWhite,
                                    ),
                                    Text("   Explore", style: buttonWhite),
                                    Flexible(
                                      child: Container(),
                                    ),
                                    isloading
                                        ? Container(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Icon(
                                            CupertinoIcons.forward,
                                            color: almostWhite,
                                            //size: 30,
                                          ),
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
      ),
    );
  }
}
