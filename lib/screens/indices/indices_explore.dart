import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/LoadingPage.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_ind/components/containPage.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/News/broadcastPage.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/News/business/newsServices.dart';
import 'package:technical_ind/screens/chartScreen.dart';
// import 'package:technical_ind/screens/cryptocurrency/historyPage.dart';
import 'package:technical_ind/screens/cryptocurrency/indicatorsPage.dart';
import 'package:technical_ind/screens/cryptocurrency/newsPage.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/explore/fAndO.dart';
import 'package:technical_ind/styles.dart';
import 'package:technical_ind/widgets/appbar_with_bookmark_and_share.dart';

import 'indianIndices/indianIndicesComponents.dart';
import 'indianIndices/overview_indian.dart';
import 'indianIndices/stockEffect.dart';
import 'business/indices_services.dart';
import 'business/indian_overview_model.dart';
import '../commodity/historycommo.dart';

class ExplorePageIndices extends StatefulWidget {
  final List<String> menu;
  final String title, value, subValue;
  final Widget top, mid, end;
  final String expiryDate;
  final double defaultheight;
  final bool isSearch;
  final String query;

  ExplorePageIndices({
    Key key,
    this.isSearch = false,
    this.menu,
    this.query,
    this.title,
    this.value,
    this.subValue,
    this.expiryDate,
    this.top,
    this.mid,
    this.end,
    this.defaultheight = 80,
  }) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePageIndices> {
  PanelController _panelController = PanelController();
  List<String> menu;
  IndianOverviewModel indianOverviewModel;

  FutureAndOptions futureAndOptions;

  List<Article> articles = [];

  void getArticles(String title) async {
    articles = await NewsServices.getNewsFromQuery(title).whenComplete(() {
      setState(() {});
    });
  }

  String price = "";
  String chng = "";
  String chngPercentage = "";
  String query;

  _fetchApidata() async {
    // indianOverviewModel = await IndicesServices.getIndianOverview(
    //     widget.title.replaceAll('&', 'and'));

    if (widget.isSearch == true) {
      final response = await IndicesServices.getSearchIndian(query);
      setState(() {
        price = response["price"];
        chng = response["chg"];
        chngPercentage = response["chg_percent"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    menu = widget.menu;
    query = widget.title.replaceAll('&', 'and');
    _fetchApidata();
    getArticles('Indices ' + widget.title.replaceAll('S&P', ''));
  }

  Future<bool> checkIsSaved() async {
    print("checking saved...");
    var user = context.read(firestoreUserProvider);
    if (user.containsKey('IndianIndicesWatchlist')) {
      List<dynamic> indianwatchlist = user['IndianIndicesWatchlist'];

      return indianwatchlist.contains(query);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SlidingUpPanel(
        controller: _panelController,
        color: const Color(0xff1c1c1e),
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
              widget.menu.length,
              (index) => InkWell(
                onTap: () {
                  _panelController.close().whenComplete(
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => menu.length == 8
                                ? ContainPage(
                                    menu: menu,
                                    menuWidgets: [
                                      OverviewIndianIndices(
                                        query: query,
                                        price: widget.isSearch
                                            ? price
                                            : widget.value,
                                        chng: widget.isSearch
                                            ? chng + chngPercentage
                                            : widget.subValue,
                                      ),
                                      ChartScreen(
                                        isIndice: true,
                                        companyName: widget.title,
                                        isUsingWeb: true,
                                        presentInSymbols: true,
                                      ),
                                      StockEffect(
                                        query: query,
                                        // stockEffects: indianOverviewModel.stockEffect,
                                      ),
                                      IndianIndicesComponents(
                                        query: query,
                                      ),
                                      IndicatorPage(
                                        query: query, isIndianIndices: true,
                                        // indicator:
                                        //     indianOverviewModel.technicalIndicator,
                                      ),
                                      HistoryPageCommodity(
                                        query: query, isIndianIndices: true,
                                        // historicalData:
                                        //     indianOverviewModel.historicalData,
                                      ),
                                      FandO(query: query),
                                      NewsWidget(
                                        isIndice: true,
                                        title: widget.title,
                                        // articles: articles,
                                      )
                                    ],
                                    title: widget.title,
                                    defaultWidget: menu[0],
                                  )
                                : ContainPage(
                                    menu: menu,
                                    menuWidgets: [
                                      OverviewIndianIndices(
                                        query: query,
                                        price: widget.isSearch
                                            ? price
                                            : widget.value,
                                        chng: widget.isSearch
                                            ? "${chng} ${chngPercentage}"
                                            : widget.subValue,
                                        // overview: indianOverviewModel.overview,
                                      ),
                                      ChartScreen(
                                        isIndice: true,
                                        companyName: widget.title,
                                        isUsingWeb: true,
                                        presentInSymbols: true,
                                      ),
                                      StockEffect(
                                        query: query,
                                        // stockEffects: indianOverviewModel.stockEffect,
                                      ),
                                      IndianIndicesComponents(
                                        query: query,
                                      ),
                                      IndicatorPage(
                                        query: query, isIndianIndices: true,
                                        // indicator:
                                        //     indianOverviewModel.technicalIndicator,
                                      ),
                                      HistoryPageCommodity(
                                        query: query, isIndianIndices: true,
                                        // historicalData:
                                        //     indianOverviewModel.historicalData,
                                      ),
                                      NewsWidget(
                                        isIndice: true,
                                        title: widget.title,
                                      ),
                                    ],
                                    title: widget.title,
                                    defaultWidget: menu[0],
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
            ),
          ],
        ),
        body: Scaffold(
          // backgroundColor: kindaWhite,
          appBar: query != null
              ? AppbarWithShare(
                  showShare: false,
                  isSaved: checkIsSaved,
                  onSaved: () async {
                    var db = context.read(storageServicesProvider);
                    await db.updateIndianIndicesWatchlist(query);
                    BotToast.showText(
                        contentColor: almostWhite,
                        textStyle: TextStyle(color: black),
                        text: "Added to Watchlist");
                  },
                  delSaved: () async {
                    print("removing...");
                    var db = context.read(storageServicesProvider);
                    await db.removeIndianIndicesWatchlist([query]);
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
                                  child: Text(
                                      widget.title
                                          .replaceAll('S&P', '')
                                          .replaceAll('SandP', ''),
                                      textAlign: TextAlign.center,
                                      style: headline6)),
                          widget.mid != null ? widget.mid : Container(),
                          SizedBox(
                              height: (widget.expiryDate != null) ? 15 : 0),
                          (widget.expiryDate != null)
                              ? Center(
                                  child: Text(
                                    widget.expiryDate,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: almostWhite,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              : SizedBox(),
                          (widget.expiryDate != null)
                              ? Center(
                                  child: Text(
                                    'Expiry date',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: white60,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 100,
                          ),
                          widget.end != null
                              ? widget.end
                              : Center(
                                  child: widget.isSearch == false
                                      ? Text(widget.value,
                                          style: headline5White)
                                      : Text(price, style: headline5White)),
                          widget.end != null
                              ? Container()
                              : Center(
                                  child: widget.isSearch == false
                                      ? Text(
                                          widget.subValue,
                                          style: bodyText2.copyWith(
                                            color: widget.subValue[0] == '-'
                                                ? red
                                                : blue,
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                              if (chng != "")
                                                Text(chng,
                                                    style: bodyText2.copyWith(
                                                        color: chng[0] != '-'
                                                            ? blue
                                                            : red)),
                                              if (chngPercentage != "")
                                                Text(chngPercentage,
                                                    style: bodyText2.copyWith(
                                                        color:
                                                            chngPercentage[1] !=
                                                                    '-'
                                                                ? blue
                                                                : red)),
                                            ]),
                                ),
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
                                    Icon(
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
